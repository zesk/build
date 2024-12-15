#!/usr/bin/env bash
#
# Shell tools
#
# Usage: # shellcheck source=/dev/null
# Usage: . ./bin/build/tools.sh
# Depends: -
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__function.md
#

# IDENTICAL _return 24
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  isUnsignedInteger "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf -- "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} argument ...
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
#
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

# DEPRECATED 2024-11-29
_integer() {
  isUnsignedInteger "$@"
}

# Load tools and optionally run a command
__toolsMain() {
  local source="${BASH_SOURCE[0]}" internalError=253
  local toolsPath="${source%/*}/tools"
  local toolsFiles=("../env/BUILD_HOME") toolsList="$toolsPath/tools.conf" toolFile

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
    BUILD_HOME="$BUILD_HOME" "$@"
  fi
}

__toolsMain "$@"
