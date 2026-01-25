#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__coverageLoader() {
  __buildFunctionLoader __bashCoverageReport coverage "$@"
}

# Argument: --target reportFile - File. Optional. Write coverage data to this file.
# Argument: thingToRun - Callable. Required. Function to run and collect coverage data.
# Collect code coverage statistics for a code sample
# Convert resulting files using `bashCoverageReport`
# See: bashCoverageReport
bashCoverage() {
  local handler="_${FUNCNAME[0]}"

  local target="" verbose=false

  # IDENTICAL startBeginTiming 1
  local start && start=$(timingStart) || return $?

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose) verbose=true ;;
    --target) shift && target="$(validate "$handler" FileDirectory "$argument" "${1-}")" || return $? ;;
    *) break ;;
    esac
    shift
  done

  local home && home=$(catchReturn "$handler" buildHome) || return $?
  [ -n "$target" ] || target="$home/coverage.stats"
  ! $verbose || decorate info "Collecting coverage to $(decorate code "${target#"$home"}")"
  catchReturn "$handler" __bashCoverageWrapper "$target" "$@" || return $?
  ! $verbose || timingReport "$start" "Coverage completed in"
}
_bashCoverage() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Generate a coverage report using the coverage statistics file
#
# *This is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.*
# Summary: Experimental. Likely abandon.
# Argument: --cache cacheDirectory - Optional. Directory.
# Argument: --target targetDirectory - Optional. Directory.
# Argument: statsFile - File. Required.
# stdin: Accepts a stats file
bashCoverageReport() {
  __coverageLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}

_bashCoverageReport() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Internal: true
# Debugger function tracks coverage calls and stores them in target file (1st argument)
# KISS as this needs to be AFAFP
__bashCoverageMarker() {
  export BUILD_HOME
  local source=${BASH_SOURCE[1]} home="${BUILD_HOME%/}/" command="${BASH_COMMAND//$'\n'/\n}"
  source="${source#"$home"}"
  printf -- "%s:%s %s %s\n" "$source" "${BASH_LINENO[1]}" "${FUNCNAME[1]}" "$command" >>"$1"
  # debuggingStack >>"$1.stack" || return $?
}
___bashCoverageMarker() {
  __bashCoverageEnd
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Utility - cover passed command
#
__bashCoverageWrapper() {
  local e=0 target="$1" && shift
  __bashCoverageStart "$target"
  "$@" || e=$?
  __bashCoverageEnd
  return $e
}

#
# Utility - start coverage recording
#
__bashCoverageStart() {
  shopt -s extdebug
  set -o functrace
  # shellcheck disable=SC2064
  trap "__bashCoverageMarker \"$1\"" DEBUG
}

#
# Utility - stop coverage recording
#
__bashCoverageEnd() {
  trap - DEBUG
  set +o functrace
  shopt -u extdebug
}
