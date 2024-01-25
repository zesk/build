#!/bin/bash
#
# ┏━╸┏━┓┏━┓┏┓╻╺┳╸┏━┓┏┓    ┏━┓┏━┓┏━┓╻  ╻┏━╸┏━┓╺┳╸╻┏━┓┏┓╻   ┏━┓╻ ╻┏┓╻┏━╸ ┏━┓╻ ╻
# ┃  ┣┳┛┃ ┃┃┗┫ ┃ ┣━┫┣┻┓╺━╸┣━┫┣━┛┣━┛┃  ┃┃  ┣━┫ ┃ ┃┃ ┃┃┗┫╺━╸┗━┓┗┳┛┃┗┫┃   ┗━┓┣━┫
# ┗━╸╹┗╸┗━┛╹ ╹ ╹ ╹ ╹┗━┛   ╹ ╹╹  ╹  ┗━╸╹┗━╸╹ ╹ ╹ ╹┗━┛╹ ╹   ┗━┛ ╹ ╹ ╹┗━╸╹┗━┛╹ ╹
#
# Keep crontab synced with files and environment files in an application folder structure.
#
# Structure is:
#
# appPath/application1/.env
# appPath/application1/.env.local
# appPath/application1/etc/user.crontab
#
# Applies the environment files to the crontab and then concatenates each application to generate
#
# Depends: crontab find sort grep read
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

#
# Does NOT depend on anything in build!
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

cd "$(dirname "${BASH_SOURCE[0]}")/.."

_crontabApplicationSyncUsage() {
  local errorCode=$1
   shift
   printf "ERROR: %d %s\n" "$errorCode" "$*" 1>&2
   return "$errorCode"
}

_crontabGenerate() {
  local crontabTemplate rootEnv rootPath user appName mapper

  rootEnv=$1
  rootPath=$2
  user=$3
  mapper=$4
  find "$rootPath" -name "$user.crontab" | sort | grep -v stage | while IFS= read -r crontabTemplate; do
    appName="${crontabTemplate##"$rootPath"/}"
    appName="${appName%%/*}"
    (
      envs=("$rootEnv" "$rootPath/$appName/.env" "$rootPath/$appName/.env.local")
      set -a
      for env in "${envs[@]}"; do
        if [ -f "$env" ]; then
          # shellcheck disable=SC1090
          . "$env"
        fi
      done
      export APPLICATION_PATH="$rootPath/$appName"
      export APPLICATION_NAME
      APPLICATION_NAME="$(basename "$APPLICATION_PATH")"
      "$mapper" <"$crontabTemplate"
      : "$APPLICATION_NAME" - used
      set +a
    )
  done
}

# Summary: Application-specific crontab synchronization
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
crontabApplicationSync() {
  local rootEnv appPath user flagShow environmentMapper newCrontab
  rootEnv=
  appPath=
  user=$(whoami)
  flagShow=
  environmentMapper=
  while [ $# -gt 0 ]; do
    case $1 in
      --help)
        _crontabApplicationSyncUsage 0
        ;;
      --env)
        if [ -n "$rootEnv" ]; then
          _crontabApplicationSyncUsage "$errorArgument" "--env only once"
        fi
        shift
        rootEnv=$1
        if [ ! -f "$rootEnv" ]; then
          _crontabApplicationSyncUsage "$errorArgument" "--env must supply a file that exists"
          return $?
        fi
        ;;
      --mapper)
        if [ -n "$environmentMapper" ]; then
          _crontabApplicationSyncUsage "$errorArgument" "$environmentMapper already set"
          return $?
        fi
        shift
        environmentMapper=$1
        if [ ! -x "$mapper" ] && [ "$(type -t "$mapper")" != "function" ]; then
          _crontabApplicationSyncUsage $errorEnvironment "$environmentMapper is not executable, failing"
          return $?
        fi
        ;;
      --user)
        shift || :
        user="${1-}"
        if [ -z "$user" ]; then
          _crontabApplicationSyncUsage $errorArgument "--user should be non-blank"
          return $?
        fi
        ;;
      --show)
        flagShow=1
        ;;
      *)
        appPath=$1
        if [ ! -d "$appPath" ]; then
          _crontabApplicationSyncUsage $errorEnvironment "App path $appPath is not a directory"
        fi
        ;;
    esac
    shift
  done

  if [ -z "$environmentMapper" ]; then
    if [ -x ./map.sh ]; then
      environmentMapper="$(pwd)/map.sh"
    elif which map.sh >/dev/null; then
      environmentMapper="$(which map.sh)"
    else
      _crontabApplicationSyncUsage $errorArgument "Need to specify --mapper, none found nearby"
    fi
  fi
  if [ -z "$appPath" ]; then
    _crontabApplicationSyncUsage $errorArgument "Need to specify application path"
  fi
  if [ -z "$user" ]; then
    _crontabApplicationSyncUsage $errorArgument "Need to specify user"
  fi

  if test $flagShow; then
    _crontabGenerate "$rootEnv" "$appPath" "$user" "$environmentMapper"
    return 0
  fi
  newCrontab=$(mktemp)
  _crontabGenerate "$rootEnv" "$appPath" "$user" "$environmentMapper" >"$newCrontab"

  #
  # Update crontab
  #
  if crontab -u "$user" -l | diff -q "$newCrontab" -; then
    rm -f "$newCrontab"
    return 0
  fi
  printf "Updating crontab on %s\n" "$(date)"
  crontab -u "$user" - <"$newCrontab"
  rm -f "$newCrontab"
}

crontabApplicationSync "$@"
