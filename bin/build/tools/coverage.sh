#!/usr/bin/env bash
#
# coverage.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/coverage.md
# Test: o ./test/tools/coverage-tests.sh
#

# Usage: {fn} [ --target reportFile ] [ --bin binPath ] [ options ] thingToRun
bashCoverage() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local start home target

  # local binPath actualBash

  home=$(__usageEnvironment "$usage" buildHome) || return $?
  # IDENTICAL startBeginTiming 1
  start=$(__usageEnvironment "$usage" beginTiming) || return $?

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --target)
        shift
        target="$(usageArgumentFileDirectory "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        break
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  [ -n "$target" ] || target="$home/coverage.stats"
  consoleInfo "Collecting coverage to $(consoleCode "${target#"$home"}")"
  __usageEnvironment "$usage" __bashCoverageWrapper "$target" "$@" || return $?
  reportTiming "$start" "Coverage completed in"
}
_bashCoverage() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Debugger function tracks coverage calls and stores them in `.coverage`
__bashCoverageMarker() {
  local usage="_${FUNCNAME[0]}"
  local source line home
  export BUILD_HOME

  if [ -z "$1" ]; then
    __failEnvironment "$usage" "target is empty" || return $?
  fi
  if [ -z "$BUILD_HOME" ]; then
    BUILD_HOME=$(__usageEnvironment "$usage" buildHome) || return $?
  fi
  home="${BUILD_HOME%/}/"
  source=${BASH_SOURCE[1]}
  line=${BASH_LINENO[1]}
  source="${source#"$home"}"
  __usageEnvironment "$usage" printf "%s:%d %d %s\n" "$source" "$line" "$$" "$BASH_COMMAND" >>"$1" || return $?
}
___bashCoverageMarker() {
  __bashCoverageEnd
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Utility - start coverage recording
__bashCoverageStart() {
  shopt -s extdebug
  set -o functrace
  # shellcheck disable=SC2064
  trap "__bashCoverageMarker \"$1\"" DEBUG
}

# Utility - stop coverage recording
__bashCoverageEnd() {
  trap - DEBUG
  set +o functrace
  shopt -u extdebug
}

# Utility - cover passed command
__bashCoverageWrapper() {
  local e=0 target="$1" && shift
  __bashCoverageStart "$target"
  "$@" || e=$?
  __bashCoverageEnd
  return $e
}
