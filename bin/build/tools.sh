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

# IDENTICAL _return 28

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local to=1 icon="✅" code="${1:-1}" && shift 2>/dev/null
  isUnsignedInteger "$code" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer \"$code\"" "$@" || return $?
  [ "$code" -eq 0 ] || icon="❌ [$code]" && to=2
  printf -- "%s %s\n" "$icon" "${*-§}" 1>&"$to"
  return "$code"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} argument ...
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

# Load tools and optionally run a command
__toolsMain() {
  local source="${BASH_SOURCE[0]}" internalError=253
  local toolsPath="${source%/*}/tools"
  local toolsFiles=("../env/BUILD_HOME") toolsList="$toolsPath/tools.conf" toolFile
  local exitCode=0

  export BUILD_HOME
  unset BUILD_HOME

  [ -f "$toolsList" ] || _return $internalError "%s\n" "Missing $toolsList" 1>&2 || return $?
  while read -r toolFile; do [ "$toolFile" != "${toolFile#\#}" ] || toolsFiles+=("$toolFile"); done <"$toolsList"
  toolsFiles+=("platform/$(uname -s)")
  for toolFile in "${toolsFiles[@]}"; do
    # shellcheck source=/dev/null
    source "$toolsPath/$toolFile.sh" || _return $internalError "%s\n" "Loading $toolFile.sh failed" || return $?
  done

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
