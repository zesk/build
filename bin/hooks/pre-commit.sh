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
# Requires: returnMessage
# Security: source
# Return Code: 253 - source failed to load (internal error)
# Return Code: 0 - source loaded (and command succeeded)
# Return Code: ? - All other codes are returned by the command itself
__source() {
  local here="${BASH_SOURCE[0]%/*}" e=253
  local source="$here/${2:-".."}/${1-}" && shift 2 || returnMessage $e "missing source" || return $?
  [ -d "${source%/*}" ] || returnMessage $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || returnMessage $e "$source not an executable file" "$@" || return $?
  local a=("$@") && set --
  # shellcheck source=/dev/null
  source "$source" || returnMessage $e source "$source" "$@" || return $?
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

__hookPreCommit() {
  local handler="_${FUNCNAME[0]}"
  # gitPreCommitSetup is already called
  local fileCopies nonOriginalWithEOF nonOriginal original

  gitPreCommitListExtension @ | decorate value | decorate wrap "- "
  gitPreCommitHeader sh md json

  statusMessage decorate success Updating help files ...
  catchEnvironment "$handler" ./bin/update-md.sh --skip-commit || return $?

  statusMessage decorate success Updating _sugar.sh
  original="bin/build/identical/_sugar.sh"
  nonOriginal=bin/build/tools/_sugar.sh

  statusMessage decorate success Making shell files executable ...
  catchEnvironment "$handler" makeShellFilesExecutable | printfOutputPrefix -- "\n" || return $?

  if [ "$(fileNewest "$original" "$nonOriginal")" = "$nonOriginal" ]; then
    nonOriginalWithEOF=$(fileTemporaryName "$handler") || return $?
    catchEnvironment "$handler" sed -e 's/IDENTICAL _sugar [0-9][0-9]*/IDENTICAL _sugar EOF/g' -e 's/DO NOT EDIT/EDIT/g' <"$nonOriginal" >"$nonOriginalWithEOF" || return $?
    fileCopies=("$nonOriginalWithEOF" "$original")
    # Can not be trusted to not edit the right one
    if ! diff -q "${fileCopies[@]}" 2>/dev/null; then
      catchEnvironment "$handler" cp "${fileCopies[@]}" || returnClean "$nonOriginalWithEOF" || return $?
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
        throwEnvironment "$handler" "Identical repair failed twice - manual intervention required" || return $?
      fi
    fi
  fi

}
___hookPreCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. __hookPreCommit "$@"
