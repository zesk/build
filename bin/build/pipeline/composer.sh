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

# IDENTICAL me 1
me="$(basename "${BASH_SOURCE[0]}")"

_phpComposerUsage() {
  usageDocument "./bin/build/pipeline/$me" "phpComposer" "$@"
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
  local start composerArgs quietLog dockerImage cacheDir composerDirectory

  dockerImage=composer:${BUILD_COMPOSER_VERSION:-latest}
  composerDirectory=.
  cacheDir=.composer

  start=$(beginTiming)

  while [ $# -gt 0 ]; do
    case $1 in
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
        ;;
    esac
    shift
  done

  aptInstall

  if ! composerDirectory=$(realPath "$composerDirectory"); then
    _phpComposerUsage "$errorArgument" "Composer directory issues $composerDirectory"
    return $?
  fi
  [ -d "$composerDirectory/$cacheDir" ] || mkdir -p "$composerDirectory/$cacheDir"

  composerArgs=()
  composerArgs+=("-v" "$composerDirectory:/app")
  composerArgs+=("-v" "$composerDirectory/$cacheDir:/tmp")
  composerArgs+=("$dockerImage")
  composerArgs+=("--ignore-platform-reqs")

  quietLog="$(buildQuietLog phpComposer)"
  consoleInfo -n "Composer ... "
  bigText "Install vendor" >>"$quietLog"
  #DEBUGGING - remove, why no -q option? we like it quiet
  echo Running: docker pull "$dockerImage" >>"$quietLog"

  if ! docker pull "$dockerImage" >>"$quietLog" 2>&1; then
    consoleError "Failed to pull image $dockerImage"
    buildFailed "$quietLog"
    return $errorBuild
  fi
  consoleInfo -n "validating ... "
  echo Running: docker run "${composerArgs[@]}" validate >>"$quietLog"
  if ! docker run "${composerArgs[@]}" install >>"$quietLog" 2>&1; then
    buildFailed "$quietLog"
    return $errorBuild
  fi

  composerArgs+=("install")
  consoleInfo -n "installing ... "
  echo Running: docker run "${composerArgs[@]}" >>"$quietLog"
  if ! docker run "${composerArgs[@]}" >>"$quietLog" 2>&1; then
    buildFailed "$quietLog"
    return $errorBuild
  fi
  reportTiming "$start" OK

}

phpComposer "$@"
