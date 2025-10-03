#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# DOES NOT USE zesk-build-hook-header because this may be installed as a git hook as well so
# it determines where it is installed and finds the build directory appropriately

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

# IDENTICAL __gitHookPath 12

# Summary: Locates application home depending on whether this is running as a git hook or not
# Usage: {fn}
# If current path contains `.git/` then print `../../..` otherwise print `../..`
# Lets us know if default hooks are in starting directory or are running as a git hook
# Requires: printf
__gitHookPath() {
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}/"
  [ "${here%%.git/*}" != "$here" ] || printf "%s" "../"
  printf "%s" "../.."
}

# IDENTICAL _return 32

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Return Code: exitCode
# Requires: isUnsignedInteger printf _return
returnMessage() {
  local to=1 icon="✅" code="${1:-1}" && shift 2>/dev/null
  isUnsignedInteger "$code" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer \"$code\"" "$@" || return $?
  if [ "$code" -gt 0 ]; then icon="❌ [$code]" && to=2; fi
  printf -- "%s %s\n" "$icon" "${*-§}" 1>&"$to"
  return "$code"
}
_return() {
  returnMessage "$@"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Argument: value - EmptyString. Value to test if it is an unsigned integer.
# Usage: {fn} argument ...
# Return Code: 0 - if it is an unsigned integer
# Return Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

#
# The `git-pre-commit` hook self-installs as a `git` pre-commit hook in your project and will
# overwrite any existing `pre-commit` hook.`
#
# It will:
# 1. Updates the help file templates
# 2. Checks all shell files for errors
# fn: {base}
__hookGitPreCommit() {
  local handler="_${FUNCNAME[0]}" hookName="pre-commit" start

  start=$(timingStart) || return $?

  export BUILD_PRECOMMIT_EXTENSIONS APPLICATION_NAME
  __catch "$handler" buildEnvironmentLoad APPLICATION_NAME BUILD_PRECOMMIT_EXTENSIONS || return $?

  statusMessage --first printf -- "%s %s" "$(decorate info "[$hookName]")" "$(decorate info "Installing ...")"
  __catchEnvironment "$handler" gitInstallHook --copy "$hookName" || return $?
  statusMessage --last printf -- "%s %s" "$(decorate info "[$hookName]")" "$(decorate info "Running ...")"

  __catchEnvironment "$handler" gitPreCommitSetup || return $?
  __catchEnvironment "$handler" hookRunOptional "$hookName" || return $?

  statusMessage --last decorate info "$(lineFill '*' "$APPLICATION_NAME $(decorate magenta "$hookName") $(decorate decoration --)")"

  local extension extensions=()
  read -r -a extensions < <(printf "%s" "${BUILD_PRECOMMIT_EXTENSIONS-}") || :
  for extension in "${extensions[@]+${extensions[@]}}"; do
    statusMessage decorate info "Processing $(decorate code "$extension") ..."
    if gitPreCommitHasExtension "$extension"; then
      __catchEnvironment "$handler" hookRunOptional "pre-commit-$extension" || return $?
    fi
  done

  gitPreCommitCleanup || :
  statusMessage --last printf -- "%s %s" "$(decorate info "[$hookName]")" "$(timingReport "$start" "completed in")"
}
___hookGitPreCommit() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools "$(__gitHookPath)" __hookGitPreCommit "$@"
