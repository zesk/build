#!/usr/bin/env bash
#
# Shell tools
#
# Usage: # shellcheck source=/dev/null
# Usage: . ./bin/build/tools.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__function.md
#

# IDENTICAL returnMessage 39

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Return Code: exitCode
# Requires: isUnsignedInteger printf returnMessage
returnMessage() {
  local handler="_${FUNCNAME[0]}"
  local to=1 icon="✅" code="${1:-1}" && shift 2>/dev/null
  if [ "$code" = "--help" ]; then "$handler" 0 && return; fi
  isUnsignedInteger "$code" || returnMessage 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${handler#_} non-integer \"$code\"" "$@" || return $?
  if [ "$code" -gt 0 ]; then icon="❌ [$code]" && to=2; fi
  printf -- "%s %s\n" "$icon" "${*-§}" 1>&"$to"
  return "$code"
}
_returnMessage() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Argument: value - EmptyString. Value to test if it is an unsigned integer.
# Usage: {fn} argument ...
# Return Code: 0 - if it is an unsigned integer
# Return Code: 1 - if it is not an unsigned integer
# Requires: returnMessage
isUnsignedInteger() {
  [ $# -eq 1 ] || returnMessage 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}
_isUnsignedInteger() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL returnMessage

# Loads conditional code based on whether a function is defined yet
# Argument: prefix - ApplicationDirectory. Required. Relative path from the application directory to the subdirectory.
# Argument: testFunction - Function. Required. Function which MUST be defined in the subdirectory sources.
# Argument: subdirectory - RelativeDirectory. Required. Path added to `prefix` to load files.
# Argument: handler - Function. Required. Error handler.
# Argument: function - Function. Required. Function to call; first argument will be `handler`.
# Argument ... - Arguments. Optional. Additional arguments to the function.
__functionLoader() {
  local __saved=("$@") prefix="${1-}" functionName="${2-}" subdirectory="${3-}" handler="${4-}" command="${5-}"
  shift 5 || catchArgument "$handler" "Missing arguments: $(decorate each --count code -- "${__saved[@]}")" || return $?
  export BUILD_HOME
  if ! isFunction "$functionName"; then
    catchReturn "$handler" bashSourcePath "${BUILD_HOME-}/$prefix/$subdirectory/" || return $?
    export __BUILD_LOADER
    __BUILD_LOADER+=("$functionName")
  fi
  "$command" "$handler" "$@" || return $?
}

# Function loader for build tools
# Argument: testFunction - Function. Required. Function which MUST be defined in the subdirectory sources.
# Argument: subdirectory - RelativeDirectory. Required. Path from /bin/build/tools/ to load files.
# Argument: handler - Function. Required. Error handler.
# Argument: function - Function. Required. Function to call; first argument will be `handler`.
# Argument ... - Arguments. Optional. Additional arguments to the function.
__buildFunctionLoader() {
  __functionLoader "bin/build/tools" "$@"
}

__toolsTimingLoad() {
  local internalError=253 production="$1" toolsPath="$2" && shift 2
  local start elapsed="undefined"
  printf "" >"${BASH_SOURCE[0]%/*}/../../.tools.times"
  while [ "$#" -gt 0 ]; do
    [ "$production" = "true" ] || toolFile="${1//-fast/}"
    ! isFunction __timestamp || start=$(__timestamp)
    # shellcheck source=/dev/null
    source "$toolsPath/$toolFile.sh" || returnMessage $internalError "%s\n" "Loading $toolFile.sh failed" || return $?
    ! isFunction __timestamp || elapsed=$(($(__timestamp) - start))
    printf "%s %s\n" "$elapsed" "$toolFile" >>"${BASH_SOURCE[0]%/*}/../../.tools.times"
    shift
  done
  sort -r "${BASH_SOURCE[0]%/*}/../../.tools.times" >"${BASH_SOURCE[0]%/*}/../../.tools.times.sorted"
}

# Load tools and optionally run a command
__toolsMain() {
  export PRODUCTION BUILD_DEBUG

  local source="${BASH_SOURCE[0]}"
  local toolsPath="${source%/*}/tools" internalError=253
  local toolsFiles=() toolsList="$toolsPath/tools.conf" toolFile
  local exitCode=0 production="${PRODUCTION-}" debug="${BUILD_DEBUG-}"

  export BUILD_HOME BUILD_DEBUG
  unset BUILD_HOME

  export __BUILD_LOADER
  [ -z "${__BUILD_LOADER-}" ] || unset "${__BUILD_LOADER[@]}"
  __BUILD_LOADER=()
  [ -f "$toolsList" ] || returnMessage $internalError "%s\n" "Missing $toolsList" 1>&2 || return $?
  toolsFiles+=("../env/BUILD_HOME")
  while read -r toolFile; do [ "$toolFile" != "${toolFile#\#}" ] || toolsFiles+=("$toolFile"); done <"$toolsList"
  toolsFiles+=("platform/$(uname -s)")

  [ -z "$production" ] || [ ! -t 1 ] || production=true
  if [ "${debug#;main;*}" != "$debug" ]; then
    __toolsTimingLoad "$production" "$toolsPath" "${toolsFiles[@]}" || return $?
  else
    # Avoids conflict with aliases with same names as our functions
    shopt -u expand_aliases
    for toolFile in "${toolsFiles[@]}"; do
      [ "$production" = "true" ] || toolFile="${toolFile//-fast/}"
      # shellcheck source=/dev/null
      source "$toolsPath/$toolFile.sh" || returnMessage $internalError "%s\n" "Loading $toolFile.sh failed" || returnUndo $? shopt -s expand_aliases || return $?
    done
    shopt -s expand_aliases
  fi

  # shellcheck source=/dev/null
  if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ] && [ $# -gt 0 ]; then
    # Only require when running as a shell command
    set -eou pipefail
    # Run remaining command line arguments
    BUILD_HOME="$BUILD_HOME" "$@" || exitCode=$?
  fi
  return $exitCode
}

__toolsMain "$@"
