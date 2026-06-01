#!/usr/bin/env bash
#
# Zesk Tools
#
# IDENTICAL licenseHeader 11
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

# IDENTICAL returnMessage 31

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - UnsignedInteger. Required. Exit code to return. Default is 1.
# Argument: message ... - String. Optional. Message to output
# Return Code: exitCode
# Requires: isUnsignedInteger printf returnMessage
returnMessage() {
  local h="_${FUNCNAME[0]}" c="${1:-1}" && shift 2>/dev/null
  if [ "$c" = "--help" ]; then "$h" 0 && return 0 || return $?; fi
  local t="${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> "
  isUnsignedInteger "$c" || returnMessage 2 "$t${h#_} non-integer \"$c\"" "$@" || return $?
  if [ "$c" != "0" ]; then printf "%s%s %s\n" "❌ $t" "[$c]" "${*-§}" 1>&2; else printf "%s %s\n" "✅" "${*-§}"; fi && return "$c"
}
_returnMessage() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Is value an unsigned integer?
# Test if a value is a 0 or greater integer. Leading "+" is ok.
# See: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Argument: value - EmptyString. Value to test if it is an unsigned integer.
# Return Code: 0 - if it is an unsigned integer
# Return Code: 1 - if it is not an unsigned integer
# Requires: returnMessage
isUnsignedInteger() {
  [ $# -eq 1 ] || returnMessage 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
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
    catchReturn "$handler" bashSourcePath --exclude "*/hooks/*" "${BUILD_HOME-}/$prefix/$subdirectory/" || return $?
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
  local internalError=253 toolsPath="$1" && shift
  local start elapsed="undefined"
  printf "" >"${BASH_SOURCE[0]%/*}/../../.tools.times"
  while [ "$#" -gt 0 ]; do
    ! isFunction __timestamp || start=$(__timestamp)
    # shellcheck source=/dev/null
    source "$toolsPath/$1.sh" || returnMessage $internalError "%s\n" "Loading $1.sh failed" || return $?
    ! isFunction __timestamp || elapsed=$(($(__timestamp) - start))
    printf "%s %s\n" "$elapsed" "$1" >>"${BASH_SOURCE[0]%/*}/../../.tools.times"
    shift
  done
  sort -r "${BASH_SOURCE[0]%/*}/../../.tools.times" >"${BASH_SOURCE[0]%/*}/../../.tools.times.sorted"
}

__toolsInitialize() {
  export BUILD_DEBUG BUILD_HOME __BUILD_LOADER
  unset BUILD_HOME
  [ -z "${__BUILD_LOADER-}" ] || unset "${__BUILD_LOADER[@]}"
  __BUILD_LOADER=()
  unset "${FUNCNAME[0]}"
}

# Load tools and optionally run a command
__toolsMain() {
  # COMPILED toolsLoader 21
  local source="${BASH_SOURCE[0]}"
  local toolsPath="${source%/*}/tools" internalError=253
  local toolsFiles=() toolsList="$toolsPath/tools.conf" toolFile
  [ -f "$toolsList" ] || returnMessage $internalError "%s\n" "Missing $toolsList" 1>&2 || return $?
  toolsFiles+=("../env/BUILD_HOME")
  while read -r toolFile; do [ "$toolFile" != "${toolFile#\#}" ] || toolsFiles+=("$toolFile"); done <"$toolsList"
  toolsFiles+=("platform/$(uname -s)")

  local debug=",${BUILD_DEBUG-},"
  if [ "${debug#*,main,}" != "$debug" ]; then
    __toolsTimingLoad "$toolsPath" "${toolsFiles[@]}" || return $?
  else
    # Avoids conflict with aliases with same names as our functions
    shopt -u expand_aliases
    for toolFile in "${toolsFiles[@]}"; do
      # shellcheck source=/dev/null
      source "$toolsPath/$toolFile.sh" || returnMessage $internalError "%s\n" "Loading $toolFile.sh failed" || returnUndo $? shopt -s expand_aliases || return $?
    done
    shopt -s expand_aliases
  fi
  # -- COMPILED toolsLoader END

  local returnCode=0
  # shellcheck source=/dev/null
  if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ] && [ $# -gt 0 ]; then
    export BUILD_HOME
    # Only require when running as a shell command
    set -eou pipefail
    # Run remaining command line arguments
    BUILD_HOME="$BUILD_HOME" "$@" || returnCode=$?
  fi
  return $returnCode
}

__toolsInitialize

# LOAD

__toolsMain "$@"
