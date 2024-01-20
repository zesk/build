#!/usr/bin/env bash
#
# composer.sh
#
# Depends: docker
#
# run composer install
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorArgument 1
errorArgument=2

errorBuild=1000

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

_phpComposerUsage() {
  usageDocument "./bin/build/pipeline/$(basename "${BASH_SOURCE[0]}")" "phpComposer" "$@"
  return "$?"
}

#
# Summary: Run Composer commands on code
#
# Runs composer validate and install on a directory.
#
# If this fails it will output the installation log.
#
# When this tool succeeds the `composer` tool has run on a source tree and the `vendor` directory and `composer.lock` are often updated.
#
# This tools does not install the `composer` binary into the local environment.
# fn: composer.sh
# Usage: composer.sh [ --help ] [ installDirectory ]
#
# Argument: installDirectory - You can pass a single argument which is the directory in your source tree to run composer. It should contain a `composer.json` file.
# Argument: --help - This help
#
# Example:     bin/build/pipeline/composer.sh ./app/
# Local Cache: This tool uses the local `.composer` directory to cache information between builds. If you cache data between builds for speed, cache the `.composer` artifact if you use this tool. You do not need to do this but 2nd builds tend to be must faster with cached data.
#
# Environment: BUILD_COMPOSER_VERSION - String. Default to `latest`. Used to run `docker run composer/$BUILD_COMPOSER_VERSION` on your code
#
phpComposer() {
  local start forceDocker installArgs quietLog dockerImage cacheDir composerBin composerDirectory savedWorking

  dockerImage=composer:${BUILD_COMPOSER_VERSION:-latest}
  composerDirectory=.
  cacheDir=.composer
  forceDocker=
  start=$(beginTiming)

  while [ $# -gt 0 ]; do
    case $1 in
      --docker)
        consoleWarning "Requiring docker composer"
        forceDocker=1
        ;;
      --help)
        _phpComposerUsage 0
        return $?
        ;;
      *)
        if [ "$composerDirectory" != "." ]; then
          _phpComposerUsage "$errorArgument" "Unknown argument $1"
          return $?
        fi
        if [ ! -d "$1" ]; then
          _phpComposerUsage "$errorArgument" "Directory does not exist: $1"
          return $?
        fi
        composerDirectory=$1
        consoleInfo "Using composer directory: $composerDirectory"
        ;;
    esac
    shift
  done

  [ -d "$composerDirectory/$cacheDir" ] || mkdir -p "$composerDirectory/$cacheDir"

  installArgs=("--ignore-platform-reqs")

  quietLog="$(buildQuietLog phpComposer)"
  consoleBoldRed -n "Composer ... "
  bigText "Install vendor" >>"$quietLog"

  if test $forceDocker; then
    consoleWarning -n "pulling ... "
    if ! docker pull "$dockerImage" >>"$quietLog" 2>&1; then
      consoleError "Failed to pull image $dockerImage" 1>&2
      buildFailed "$quietLog" 1>&2
      return $errorBuild
    fi
    composerBin=(docker run)
    composerBin+=("-v" "$composerDirectory:/app")
    composerBin+=("-v" "$composerDirectory/$cacheDir:/tmp")
    composerBin+=("$dockerImage")
  else
    consoleWarning -n "installing ... "
    if ! aptInstall composer composer >>"$quietLog" 2>&1; then
      consoleError "Failed to install composer" 1>&2
      buildFailed "$quietLog" 1>&2
      return $errorBuild
    fi
    composerBin=(composer)
  fi
  consoleInfo -n "validating ... "

  savedWorking="$(pwd)"
  cd "$composerDirectory" || return $?
  printf "%s\n" "Running: ${composerBin[*]} validate" >>"$quietLog"
  if ! "${composerBin[@]}" validate >>"$quietLog" 2>&1; then
    cd "$savedWorking" || :
    buildFailed "$quietLog"
    return $errorBuild
  fi

  consoleInfo -n "installing ... "
  printf "%s\n" "Running: ${composerBin[*]} install ${installArgs[*]}" >>"$quietLog"
  if ! "${composerBin[@]}" install "${installArgs[@]}" >>"$quietLog" 2>&1; then
    cd "$savedWorking" || :
    buildFailed "$quietLog" 1>&2
    return $errorBuild
  fi
  cd "$savedWorking" || :
  reportTiming "$start" "completed in"
}

phpComposer "$@"
