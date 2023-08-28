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
err_build=1000

me=$(basename "$0")
relTop="../.."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi
quietLog="./.build/$me.log"
# shellcheck source=/dev/null
. "./bin/build/colors.sh"

# shellcheck source=/dev/null
. "./bin/build/apt-utils.sh"

[ -d "./.composer" ] || mkdir "./.composer"

dockerImage=composer:latest
composerArgs=()
composerArgs+=("-v" ".:/app")
composerArgs+=("-v" "./.composer:/tmp")
composerArgs+=("$dockerImage")
composerArgs+=("--ignore-platform-reqs")

start=$(beginTiming)
consoleInfo -n "Composer ... "
bigText "Install vendor" >>"$quietLog"
#DEBUGGING - remove, why no -q option? we like it quiet
echo Running: docker pull $dockerImage >>"$quietLog"

if ! docker pull $dockerImage >>"$quietLog" 2>&1; then
  consoleError "Failed to pull image $dockerImage"
  failed "$quietLog"
  exit $err_build
fi
consoleInfo -n "validating ... "
echo Running: docker run "${composerArgs[@]}" validate >>"$quietLog"
if ! docker run "${composerArgs[@]}" install >>"$quietLog" 2>&1; then
  failed "$quietLog"
  exit $err_build
fi

composerArgs+=("install")
consoleInfo -n "installing ... "
echo Running: docker run "${composerArgs[@]}" >>"$quietLog"
if ! docker run "${composerArgs[@]}" >>"$quietLog" 2>&1; then
  failed "$quietLog"
  exit $err_build
fi
reportTiming "$start" OK
