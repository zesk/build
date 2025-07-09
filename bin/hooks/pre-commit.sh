#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __source 21

# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Optional. Directory. Path to application root. Defaults to `..`
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: _return
# Security: source
# Exit Code: 253 - source failed to load (internal error)
# Exit Code: 0 - source loaded (and command succeeded)
# Exit Code: ? - All other codes are returned by the command itself
__source() {
  local here="${BASH_SOURCE[0]%/*}" e=253
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  local a=("$@") && set --
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 8

# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 27

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local code="${1:-1}" && shift 2>/dev/null
  isUnsignedInteger "$code" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer \"$code\"" "$@" || return $?
  [ "$code" -eq 0 ] && printf -- "✅ %s\n" "${*-§}" && return 0 || printf -- "❌ [%d] %s\n" "$code" "${*-§}" 1>&2
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
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

__hookPreCommit() {
  local usage="_${FUNCNAME[0]}"
  # gitPreCommitSetup is already called
  local fileCopies nonOriginalWithEOF nonOriginal original

  gitPreCommitListExtension @ | decorate value | decorate wrap "- "
  gitPreCommitHeader sh md json

  statusMessage decorate success Updating help files ...
  __catchEnvironment "$usage" ./bin/update-md.sh --skip-commit || return $?

  statusMessage decorate success Updating _sugar.sh
  original="bin/build/identical/_sugar.sh"
  nonOriginal=bin/build/tools/_sugar.sh

  statusMessage decorate success Making shell files executable ...
  __catchEnvironment "$usage" makeShellFilesExecutable | printfOutputPrefix -- "\n" || return $?

  if [ "$(fileNewest "$original" "$nonOriginal")" = "$nonOriginal" ]; then
    nonOriginalWithEOF=$(fileTemporaryName "$usage") || return $?
    __catchEnvironment "$usage" sed -e 's/IDENTICAL _sugar [0-9][0-9]*/IDENTICAL _sugar EOF/g' -e 's/DO NOT EDIT/EDIT/g' <"$nonOriginal" >"$nonOriginalWithEOF" || return $?
    fileCopies=("$nonOriginalWithEOF" "$original")
    # Can not be trusted to not edit the right one
    if ! diff -q "${fileCopies[@]}" 2>/dev/null; then
      __catchEnvironment "$usage" cp "${fileCopies[@]}" || returnClean "$nonOriginalWithEOF" || return $?
      decorate warning "Someone edited non-original file $nonOriginal"
      touch "${fileCopies[0]}" # make newer
    fi
    rm -f "$nonOriginalWithEOF" || :
  fi
  if gitPreCommitHasExtension sh; then
    local file files=()
    while read -r file; do files+=("$file"); done < <(gitPreCommitListExtension)
    if grep -q '# '"IDENTICAL" "${files[@]}"; then
      if ! bin/build/identical-repair.sh && ! bin/build/identical-repair.sh; then
        __throwEnvironment "$usage" "Identical repair failed twice - manual intervention required" || return $?
      fi
    fi
  fi

}
___hookPreCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. __hookPreCommit "$@"
