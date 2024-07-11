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
# Usage: {fn} [ --env environment ] [ --show ] [ --user user ] [ --mapper envMapper ] applicationPath
# fn: crontab-application-sync.sh
# Argument: --env environment - Top-level environment file to pass variables into the user `crontab` template
# Argument: --show - Show the crontab instead of installing it
# Argument: --user user - Scan for crontab files in the form `user.crontab` and then install as this user. If not specified, uses current user name.
# Argument: --mapper envMapper - Optional. Binary. The binary use to map environment values to the file. (Uses `mapEnvironment` by default)
# Example:     crontab-application-sync.sh --env /etc/myCoolApp.conf --user www-data /var/www/applications
# Example:     {fn} /etc/myCoolApp.conf /var/www/applications www-data /usr/local/bin/map.sh
# See: whoami
crontabApplicationUpdate() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments
  local rootEnv appPath user flagShow flagDiff environmentMapper newCrontab

  __usageEnvironment "$usage" whichApt crontab cron || return $?
  rootEnv=
  appPath=
  user=$(whoami) || __failEnvironment "$usage" whoami || return $?
  [ -n "$user" ] || __failEnvironment "$usage" "whoami user is blank" || return $?
  flagShow=false
  flagDiff=false
  environmentMapper=
  nArguments=$#
  while [ $# -gt 0 ]; do
    argument="$1"
    usageArgumentRequired "$usage" "argument #$((nArguments - $# + 1))" "$argument" >/dev/null || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return 0
        ;;
      --env)
        [ -z "$rootEnv" ] || __failArgument "$usage" "$argument already" || return $?
        shift
        rootEnv=$(usageArgumentFile "$usage" "rootEnv" "$1")
        ;;
      --mapper)
        [ -z "$environmentMapper" ] || __failArgument "$usage" "$argument already" || return $?
        shift
        environmentMapper=$(usageArgumentRequired "$usage" "$argument" "${1-}") || return $?
        ;;
      --user)
        shift
        user="$(usageArgumentRequired "$usage" "$argument" "${1-}")" || return $?
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
  isCallable "$environmentMapper" || __failEnvironment "$environmentMapper is not callable" || return $?

  [ -n "$appPath" ] || __failArgument "$usage" "Need to specify application path" || return $?
  [ -n "$user" ] || __failArgument "$usage" "Need to specify user" || return $?

  if $flagShow; then
    __crontabGenerate "$rootEnv" "$appPath" "$user" "$environmentMapper"
    return 0
  fi
  newCrontab=$(mktemp)
  __crontabGenerate "$rootEnv" "$appPath" "$user" "$environmentMapper" >"$newCrontab" || return $?

  if [ ! -s "$newCrontab" ]; then
    consoleWarning "Crontab for $user is EMPTY"
  fi
  if $flagDiff; then
    printf "%s\n" "$(consoleRed "Differences")"
    crontab -u "$user" -l | diff "$newCrontab" - | wrapLines ">>> $(consoleCode)" "$(consoleReset) <<<"
    return $?
  fi
  #
  # Update crontab
  #
  if crontab -u "$user" -l | diff -q "$newCrontab" - >/dev/null; then
    rm -f "$newCrontab" || :
    return 0
  fi
  printf "Updating crontab on %s ...\n" "$(date)"
  crontab -u "$user" - <"$newCrontab" 2>/dev/null
  returnCode=$?
  rm -f "$newCrontab" || :
  [ $returnCode -eq 0 ] && return 0
  _environment "crontab -u \"$user\"" || return $returnCode
}
_crontabApplicationUpdate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
