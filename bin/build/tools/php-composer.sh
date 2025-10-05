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
  local handler="_${FUNCNAME[0]}"

  local start dockerImage=composer:${BUILD_COMPOSER_VERSION:-latest} composerDirectory="." cacheDir=".composer" forceDocker=false quietFlag=false
  start=$(timingStart)

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --quiet)
      quietFlag=true
      ;;
    --docker)
      decorate warning "Requiring docker composer"
      forceDocker=true
      ;;
    *)
      [ "$composerDirectory" = "." ] || throwArgument "$handler" "Unknown argument $1" || return $?
      [ -d "$argument" ] || throwArgument "$handler" "Directory does not exist: $argument" || return $?
      composerDirectory="$argument"
      statusMessage decorate info "Composer directory: $(decorate file "$composerDirectory")"
      break
      ;;
    esac
    shift
  done

  [ -d "$composerDirectory/$cacheDir" ] || mkdir -p "$composerDirectory/$cacheDir"

  local installArgs=("--ignore-platform-reqs") quietLog

  quietLog="$(catchReturn "$handler" buildQuietLog "$handler")" || return $?
  printf "%s\n" "Install vendor" >>"$quietLog"

  local butFirst="" composerBin=(composer)
  if $forceDocker; then
    $quietFlag || statusMessage decorate info "Pulling composer ... "
    catchEnvironmentQuiet "$handler" "$quietLog" docker pull "$dockerImage" || return $?
    composerBin=(docker run)
    composerBin+=("-v" "$composerDirectory:/app")
    composerBin+=("-v" "$composerDirectory/$cacheDir:/tmp")
    composerBin+=("$dockerImage")
    butFirst="Pulled composer image. "
  elif ! whichExists composer; then
    $quietFlag || statusMessage decorate info "Installing composer ... "
    catchEnvironment "$handler" phpComposerInstall || return $?
    butFirst="Installed composer. "
  fi

  $quietFlag || statusMessage decorate info "${butFirst}Validating ... "

  catchEnvironment "$handler" muzzle pushd "$composerDirectory" || return $?
  printf "%s\n" "Running: ${composerBin[*]} validate" >>"$quietLog"
  "${composerBin[@]}" validate >>"$quietLog" 2>&1 || returnUndo $? muzzle popd || buildFailed "$quietLog" || return $?

  $quietFlag || statusMessage decorate info "Application packages ... " || :
  printf "%s\n" "Running: ${composerBin[*]} install ${installArgs[*]}" >>"$quietLog" || :
  "${composerBin[@]}" install "${installArgs[@]}" >>"$quietLog" 2>&1 || returnUndo $? muzzle popd || buildFailed "$quietLog" || return $?
  catchEnvironment "$handler" muzzle popd || return $?
  $quietFlag || statusMessage --last timingReport "$start" "${FUNCNAME[0]} completed in" || :
}
_phpComposer() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Install composer for PHP
phpComposerInstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  ! whichExists composer || return 0
  catchReturn "$handler" phpInstall || return $?
  local target="/usr/local/bin/composer"
  local tempBinary="$target.$$"
  catchReturn "$handler" urlFetch "https://getcomposer.org/composer.phar" "$tempBinary" || returnClean $? "$tempBinary" || return $?
  catchEnvironment "$handler" mv -f "$tempBinary" "$target" || returnClean $? "$tempBinary" || return $?
  catchEnvironment "$handler" chmod +x "$target" || returnClean $? "$tempBinary" || return $?
}
_phpComposerInstall() {
  # __IDENTICAL__ usageDocument 1
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
# Argument: --status - Flag. Optional. When set, returns 0 when te version was updated successfully and $(returnCode identical) when the files are the same
# Argument: --quiet - Flag. Optional. Do not output anything to stdout and just do the action and exit.
# Return Code: 0 - File was updated successfully.
# Return Code: 1 - Environment error
# Return Code: 2 - Argument error
# Return Code: 105 - Identical files (only when --status is passed)
phpComposerSetVersion() {
  local handler="_${FUNCNAME[0]}"
  local home="" aa=() version=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --version)
      shift
      version="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      aa+=(--value "$version")
      ;;
    --status | --quiet)
      aa+=("$argument")
      ;;
    --home)
      shift
      home="$(usageArgumentDirectory "$handler" "$argument" "${1-}")" || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ -n "$home" ] || home=$(catchReturn "$handler" buildHome) || return $?

  local composerJSON="$home/composer.json" decoratedComposerJSON

  decoratedComposerJSON="$(decorate file "$composerJSON")"

  [ -f "$composerJSON" ] || throwEnvironment "$handler" "No $decoratedComposerJSON" || return $?

  catchEnvironment "$handler" jsonSetValue "${aa[@]+"${aa[@]}"}" --key version --generator hookVersionCurrent --filter versionNoVee "$composerJSON" || return $?
}
_phpComposerSetVersion() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
