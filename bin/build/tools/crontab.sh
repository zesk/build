#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/crontab.md
# Test: o ./test/tools/crontab-tests.sh

# Utility function
__crontabGenerate() {
  local crontabTemplate rootEnv rootPath user appName mapper env

  rootEnv=$1
  rootPath="${2%/}"
  user=$3
  mapper=$4
  find "$rootPath" -name "$user.crontab" | sort | grep -v stage | while IFS= read -r crontabTemplate; do
    appName="$(dirname "$crontabTemplate")"
    appName="${appName%/}"
    appName="${appName#"$rootPath"}"
    appName="${appName#/}"
    appName="${appName%%/*}"
    appName="${appName:-default}"
    (
      set -a
      for env in "$rootEnv" "$rootPath/$appName/.env" "$rootPath/$appName/.env.local"; do
        if [ -f "$env" ]; then
          # shellcheck disable=SC1090
          source "$env" || :
        fi
      done
      set +a
      APPLICATION_NAME="$appName" APPLICATION_PATH="$rootPath/$appName" "$mapper" <"$crontabTemplate"
    )
  done || return 0
}

# Summary: Application-specific crontab management
#
# Keep crontab synced with files and environment files in an application folder structure.
#
# Structure is:
#
# - `appPath/application1/.env`
# - `appPath/application1/.env.local`
# - `appPath/application1/etc/user.crontab`
#
# Search for `user.crontab` in `applicationPath` and when found, assign `APPLICATION_NAME` to the top-level directory name
# and `APPLICATION_PATH` to the top-level directory path and then map the file using the environment files given.
# Any `.env` or `.env.local` files found at `$applicationPath/` will be included for each file generation.
#
# Feasibly for each file, the following environment files are loaded:
#
# 1. `rootEnv`
# 2. `applicationPath/applicationName/.env`
# 3. `applicationPath/applicationName/.env.local`
#
# Any files not found are skipped. Note that environment values are not carried between applications.
#
# Usage: {fn} [ --env-file environment ] [ --show ] [ --user user ] [ --mapper envMapper ] applicationPath
# Argument: --env-file environmentFile - Top-level environment file to pass variables into the user `crontab` template
# Argument: --show - Show the crontab instead of installing it
# Argument: --user user - Scan for crontab files in the form `user.crontab` and then install as this user. If not specified, uses current user name.
# Argument: --mapper envMapper - Optional. Binary. The binary use to map environment values to the file. (Uses `mapEnvironment` by default)
# Example:     {fn} --env-file /etc/myCoolApp.conf --user www-data /var/www/applications
# Example:     {fn} /etc/myCoolApp.conf /var/www/applications www-data /usr/local/bin/map.sh
# See: whoami
crontabApplicationUpdate() {
  local usage="_${FUNCNAME[0]}"

  __usageEnvironment "$usage" packageWhich crontab cron || return $?

  local rootEnv="" appPath="" user
  user=$(whoami) || __failEnvironment "$usage" whoami || return $?
  [ -n "$user" ] || __failEnvironment "$usage" "whoami user is blank" || return $?

  local environmentMapper="" flagDiff=false flagShow=false
  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # --env DEPRECATED 2024-11 TODO
      --env | --env-file)
        [ -z "$rootEnv" ] || __failArgument "$usage" "$argument already" || return $?
        shift
        rootEnv=$(usageArgumentFile "$usage" "rootEnv" "$1")
        ;;
      --mapper)
        [ -z "$environmentMapper" ] || __failArgument "$usage" "$argument already" || return $?
        shift
        environmentMapper=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      --user)
        shift
        user="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --show)
        flagShow=true
        ;;
      --diff)
        flagDiff=true
        ;;
      *)
        appPath="$(usageArgumentDirectory "$usage" "applicationPath" "$argument")"
        ;;
    esac
    shift
  done

  if [ -z "$environmentMapper" ]; then
    environmentMapper=mapEnvironment
  fi
  isCallable "$environmentMapper" || __failEnvironment "$usage" "$environmentMapper is not callable" || return $?

  [ -n "$appPath" ] || __failArgument "$usage" "Need to specify application path" || return $?
  [ -n "$user" ] || __failArgument "$usage" "Need to specify user" || return $?

  if $flagShow; then
    __crontabGenerate "$rootEnv" "$appPath" "$user" "$environmentMapper"
    return 0
  fi
  local newCrontab returnCode
  newCrontab=$(mktemp)
  __crontabGenerate "$rootEnv" "$appPath" "$user" "$environmentMapper" >"$newCrontab" || return $?

  if [ ! -s "$newCrontab" ]; then
    decorate warning "Crontab for $user is EMPTY"
  fi
  if $flagDiff; then
    printf "%s\n" "$(decorate red "Differences")"
    crontab -u "$user" -l | diff "$newCrontab" - | wrapLines ">>> $(decorate code)" "$(decorate reset) <<<"
    return $?
  fi
  #
  # Update crontab
  #
  # 2>/dev/null HIDES stderr "no crontab for user" message
  if crontab -u "$user" -l 2>/dev/null | diff -q "$newCrontab" - >/dev/null; then
    rm -f "$newCrontab" || :
    return 0
  fi
  statusMessage printf "%s %s ...\n" "$(decorate info "Updating crontab on ")" "$(decorate value "$(date)")"
  crontab -u "$user" - <"$newCrontab" 2>/dev/null
  returnCode=$?
  rm -f "$newCrontab" || :
  [ $returnCode -eq 0 ] || _environment "crontab -u \"$user\"" || return $returnCode
  clearLine
  return 0
}
_crontabApplicationUpdate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
