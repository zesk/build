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
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eou pipefail

#
# Do not depend on anything in build
#
# IDENTICAL errorEnvironment 1
errorEnvironment=1
# IDENTICAL errorArgument 1
errorArgument=2

me=$(basename "$0")
cd "$(dirname "${BASH_SOURCE[0]}")/.."

crontabApplicationSyncOptions() {
  echo "--env environment    Apply this environment file first before application environment files"
  echo "--user user          The crontab user to look for files for as well as to apply crontab for (defaults to current user)"
  echo "--show               Display new crontab, do not install it"
  echo "--mapper envMapper   Use this binary to map the environment files (usually map.sh)"
}
usage() {
  local rs
  rs=$1
  shift
  exec 1>&2
  echo
  if [ -n "$*" ]; then
    echo "$*"
    echo
  fi
  echo "$me [ --env environment ] [ --show ] [ --user user ] [ --mapper envMapper ] applicationPath"
  echo
  echo "Keep multiple applications in sync with a crontab"
  echo
  crontabApplicationSyncOptions
  echo
  echo Searches for files named user.crontab in applicationPath, and applies environment files
  echo to generate the crontab and keep it up to date.
  echo
  echo "The --mapper binary must convert tokens in like {ENV_NAME} to the environment value."
  echo
  echo "The value APPLICATION_PATH is set automatically to \"applicationPath/appName\" with no trailing slash within"
  echo "each application folder."
  echo
  echo "Within each application directory, a .env or .env.local file is loaded to set values for that application locally."
  echo
  exit "$rs"
}

rootEnv=
appPath=
user=$(whoami)
flagShow=
environmentMapper=
while [ $# -gt 0 ]; do
  case $1 in
  --help)
    usage 0
    ;;
  --env)
    if [ -n "$rootEnv" ]; then
      usage "$errorArgument" "--env only once"
    fi
    shift
    rootEnv=$1
    if [ ! -f "$rootEnv" ]; then
      usage "$errorArgument" "--env must supply a file that exists"
    fi
    ;;
  --mapper)
    if [ -n "$environmentMapper" ]; then
      usage "$errorArgument" "$environmentMapper already set"
    fi
    shift
    environmentMapper=$1
    if [ ! -x "$environmentMapper" ]; then
      usage $errorEnvironment "$environmentMapper is not executable, failing"
    fi
    ;;
  --user)
    shift
    user=$1
    ;;
  --show)
    flagShow=1
    ;;
  *)
    appPath=$1
    if [ ! -d "$appPath" ]; then
      usage $errorEnvironment "App path $appPath is not a directory"
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
    usage $errorArgument "Need to specify --mapper, none found nearby"
  fi
fi
if [ -z "$appPath" ]; then
  usage $errorArgument "Need to specify application path"
fi
if [ -z "$user" ]; then
  usage $errorArgument "Need to specify user"
fi

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
# Usage: crontab-application-sync.sh [ --env environment ] [ --show ] [ --user user ] [ --mapper envMapper ] applicationPath
# Usage: crontabGenerate rootEnv rootPath user mapper
# fn: crontab-application-sync.sh
# Argument: --env environment - Top-level environment file to pass variables into the user `crontab` template
# Argument: --show - Show the crontab instead of installing it
# Argument: --user user - Scan for crontab files in the form $(user.crontab) and then install as this user. If not specified, uses current user name.
# Argument: --mapper envMapper - The binary use to map environment values to the file (see (../bin/map.md)[./map.md])
# Example:     crontab-application-sync.sh --env /etc/myCoolApp.conf --user www-data --mapper /usr/local/bin/map.sh /var/www/applications
# Example:     crontabGenerate /etc/myCoolApp.conf /var/www/applications www-data /usr/local/bin/map.sh
# See: whoami
crontabGenerate() {
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

if test $flagShow; then
  newCrontab=$(mktemp)
  crontabGenerate "$rootEnv" "$appPath" "$user" "$environmentMapper"
  exit 0
fi
newCrontab=$(mktemp)
crontabGenerate "$rootEnv" "$appPath" "$user" "$environmentMapper" >"$newCrontab"

#
# Update crontab
#
if crontab -u "$user" -l | diff -q "$newCrontab" -; then
  rm -f "$newCrontab"
  exit 0
fi
echo "Updating crontab on $(date)"
crontab -u "$user" - <"$newCrontab"
rm -f "$newCrontab"
