#!/usr/bin/env bash
#
# composer.sh
#
# Depends: docker
#
# run composer install
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail
# set -x
errEnv=1
errArg=1
errBuild=1000

me=$(basename "$0")
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi

quietLog="./.build/$me.log"
composerDirectory="$(pwd)"
dockerImage=composer:${BUILD_COMPOSER_VERSION:-latest}
cacheDir=.composer

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

# shellcheck source=/dev/null
bin/build/install/apt.sh

usage() {
  local rs=$1
  shift
  exec 1>&2
  consoleError "$*"
  echo
  consoleInfo "$me [ installDirectory ]"
  echo
  consoleInfo "Run validate and install using docker image $dockerImage"
  exit "$rs"
}

while [ $# -gt 0 ]; do
  case $1 in
  *)
    if [ "$composerDirectory" != "." ]; then
      usage "$errArg" "Unknown argument $1"
    fi
    if [ ! -d "$1" ]; then
      usage "$errArg" "Directory does not exist: $1"
    fi
    composerDirectory=$1
    ;;
  esac
  shift
done

[ -d "$composerDirectory/$cacheDir" ] || mkdir -p "$composerDirectory/$cacheDir"

composerArgs=()
composerArgs+=("-v" "$composerDirectory:/app")
composerArgs+=("-v" "$composerDirectory/$cacheDir:/tmp")
composerArgs+=("$dockerImage")
composerArgs+=("--ignore-platform-reqs")

start=$(beginTiming)
consoleInfo -n "Composer ... """
bigText "Install vendor" >>"$quietLog"
#DEBUGGING - remove, why no -q option? we like it quiet
echo Running: docker pull "$dockerImage" >>"$quietLog"

if ! docker pull "$dockerImage" >>"$quietLog" 2>&1; then
  consoleError "Failed to pull image $dockerImage"
  failed "$quietLog"
  exit $errBuild
fi
consoleInfo -n "validating ... "
echo Running: docker run "${composerArgs[@]}" validate >>"$quietLog"
if ! docker run "${composerArgs[@]}" install >>"$quietLog" 2>&1; then
  failed "$quietLog"
  exit $errBuild
fi

composerArgs+=("install")
consoleInfo -n "installing ... "
echo Running: docker run "${composerArgs[@]}" >>"$quietLog"
if ! docker run "${composerArgs[@]}" >>"$quietLog" 2>&1; then
  failed "$quietLog"
  exit $errBuild
fi
reportTiming "$start" OK
