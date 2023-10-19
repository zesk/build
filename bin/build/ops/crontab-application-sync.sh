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
set -eo pipefail

#
# Do not depend on anything in build
#
errorEnvironment=1
errorArgument=2
me=$(basename "$0")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

usageOptions() {
  echo "--env environment    Apply this environment file first before application environment files"
  echo "--user user          The crontab user to look for files for as well as to apply crontab for (defaults to whoami)"
  echo "--show               Display new crontab, do not install it"
  echo "--mapper envMapper   Use this binary to map the environment files (usually envmap.sh)"
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
  usageOptions
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
  if [ -x ./bin/build/envmap.sh ]; then
    environmentMapper="$(pwd)/bin/build/envmap.sh"
  elif which envmap.sh >/dev/null; then
    environmentMapper="$(which envmap.sh)"
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
# crontabGenerate rootEnv rootPath user mapper
#
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
