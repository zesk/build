#!/usr/bin/env bash
#
# php-composer.sh
#
# composer is the binary used to load and manage dependencies in PHP Projects
#
# Copyright &copy; 2025 Market Acumen, Inc.

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
# Example:     phpComposer ./app/
# Local Cache: This tool uses the local `.composer` directory to cache information between builds. If you cache data between builds for speed, cache the `.composer` artifact if you use this tool. You do not need to do this but 2nd builds tend to be must faster with cached data.
#
# Environment: BUILD_COMPOSER_VERSION - String. Default to `latest`. Used to run `docker run composer/$BUILD_COMPOSER_VERSION` on your code
#
# shellcheck disable=SC2120
phpComposer() {
  local usage="_${FUNCNAME[0]}"

  local start dockerImage=composer:${BUILD_COMPOSER_VERSION:-latest} composerDirectory="." cacheDir=".composer" forceDocker=false quietFlag=false
  start=$(timingStart)

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --quiet)
        quietFlag=true
        ;;
      --docker)
        decorate warning "Requiring docker composer"
        forceDocker=true
        ;;
      *)
        [ "$composerDirectory" = "." ] || __throwArgument "$usage" "Unknown argument $1" || return $?
        [ -d "$argument" ] || __throwArgument "$usage" "Directory does not exist: $argument" || return $?
        composerDirectory="$argument"
        statusMessage decorate info "Composer directory: $(decorate file "$composerDirectory")"
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -d "$composerDirectory/$cacheDir" ] || mkdir -p "$composerDirectory/$cacheDir"

  local installArgs=("--ignore-platform-reqs") quietLog

  quietLog="$(__catchEnvironment "$usage" buildQuietLog "$usage")" || return $?
  bigText "Install vendor" >>"$quietLog"

  local butFirst="" composerBin=(composer)
  if $forceDocker; then
    $quietFlag || statusMessage decorate info "Pulling composer ... "
    __catchEnvironmentQuiet "$usage" "$quietLog" docker pull "$dockerImage" || return $?
    composerBin=(docker run)
    composerBin+=("-v" "$composerDirectory:/app")
    composerBin+=("-v" "$composerDirectory/$cacheDir:/tmp")
    composerBin+=("$dockerImage")
    butFirst="Pulled composer image. "
  elif ! whichExists composer; then
    $quietFlag || statusMessage decorate info "Installing composer ... "
    __catchEnvironment "$usage" phpComposerInstall || return $?
    butFirst="Installed composer. "
  fi

  $quietFlag || statusMessage decorate info "${butFirst}Validating ... "

  __catchEnvironment "$usage" muzzle pushd "$composerDirectory" || return $?
  printf "%s\n" "Running: ${composerBin[*]} validate" >>"$quietLog"
  "${composerBin[@]}" validate >>"$quietLog" 2>&1 || _undo $? muzzle popd || buildFailed "$quietLog" || return $?

  $quietFlag || statusMessage decorate info "Application packages ... " || :
  printf "%s\n" "Running: ${composerBin[*]} install ${installArgs[*]}" >>"$quietLog" || :
  "${composerBin[@]}" install "${installArgs[@]}" >>"$quietLog" 2>&1 || _undo $? muzzle popd || buildFailed "$quietLog" || return $?
  __catchEnvironment "$usage" muzzle popd || return $?
  $quietFlag || statusMessage --last timingReport "$start" "${FUNCNAME[0]} completed in" || :
}
_phpComposer() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Install composer for PHP
phpComposerInstall() {
  ! whichExists composer || return 0
  local target="/usr/local/bin/composer"
  local tempBinary="$target.$$"
  __catchEnvironment "$usage" urlFetch "https://getcomposer.org/composer.phar" "$tempBinary" || _clean $? "$tempBinary" || return $?
  __catchEnvironment "$usage" mv -f "$tempBinary" "$target" || _clean $? "$tempBinary" || return $?
  __catchEnvironment "$usage" chmod +x "$target" || _clean $? "$tempBinary" || return $?
}
_phpComposerInstall() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}


# For any project, ensures the `version` field in `composer.json` matches `runHook version-current`
#
# Run as a commit hook for any PHP project or as part of your build or development process
#
# Typically the version is copied in without the leading `v`.
#
# Argument: --version - String. Use this version instead of current version.
# Argument: --home - Directory. Optional. Use this directory for the location of `composer.json`.
# Argument: --status - Flag. Optional. When set, returns 0 when te version was updated successfully and $(_code identical) when the files are the same
# Argument: --quiet - Flag. Optional. Do not output anything to stdout and just do the action and exit.
# Exit Code: 0 - File was updated successfully.
# Exit Code: 1 - Environment error
# Exit Code: 2 - Argument error
# Exit Code: 105 - Identical files (only when --status is passed)
phpComposerSetVersion() {
  local usage="_${FUNCNAME[0]}"
  local home="" aa=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --version)
        shift
        version="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        aa+=(--value "$version")
        ;;
      --status | --quiet)
        aa+=("$argument")
        ;;
      --home)
        shift
        home="$(usageArgumentDirectory "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$home" ] || home=$(__catchEnvironment "$usage" buildHome) || return $?

  local composerJSON="$home/composer.json" decoratedComposerJSON

  decoratedComposerJSON="$(decorate file "$composerJSON")"

  [ -f "$composerJSON" ] || __throwEnvironment "$usage" "No $decoratedComposerJSON" || return $?

  __catchEnvironment "$usage" jsonSetValue "${aa[@]+"${aa[@]}"}" --key version --generator hookVersionCurrent --filter versionNoVee "$composerJSON" || return $?
}
_phpComposerSetVersion() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
