#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# DOES NOT USE zesk-build-hook-header because this may be installed as a git hook as well so
# it determines where it is installed and finds the build directory appropriately

# IDENTICAL __source 19

# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: _return
# Security: source
__source() {
  local me="${BASH_SOURCE[0]}" e=253
  local here="${me%/*}" a=()
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  while [ $# -gt 0 ]; do a+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 8

# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source _return
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL __where 12

# Summary: Locates application home depending on whether this is running as a git hook or not
# Usage: {fn}
# If current path contains `.git/` then print `../../..` otherwise print `../..`
# Lets us know if default hooks are in starting directory or are running as a git hook
# Requires: printf
__where() {
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}/"
  [ "${here%%.git/*}" != "$here" ] || printf "%s" "../"
  printf "%s" "../.."
}

# IDENTICAL _return 26

# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Required. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local r="${1-:1}" && shift 2>/dev/null
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
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
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
  local usage="_${FUNCNAME[0]}" hookName="pre-commit" start

  start=$(timingStart) || return $?

  export BUILD_PRECOMMIT_EXTENSIONS APPLICATION_NAME
  __catchEnvironment "$usage" buildEnvironmentLoad APPLICATION_NAME BUILD_PRECOMMIT_EXTENSIONS || return $?

  statusMessage --first printf -- "%s %s" "$(decorate info "[$hookName]")" "$(decorate info "Installing ...")"
  __catchEnvironment "$usage" gitInstallHook --copy "$hookName" || return $?
  statusMessage --last printf -- "%s %s" "$(decorate info "[$hookName]")" "$(decorate info "Running ...")"

  __catchEnvironment "$usage" gitPreCommitSetup || return $?
  __catchEnvironment "$usage" hookRunOptional "$hookName" || return $?

  statusMessage --last decorate info "$(lineFill '*' "$APPLICATION_NAME $(decorate magenta "$hookName") $(decorate decoration)")"

  local extension extensions=()
  read -r -a extensions < <(printf "%s" "${BUILD_PRECOMMIT_EXTENSIONS-}") || :
  for extension in "${extensions[@]+${extensions[@]}}"; do
    statusMessage decorate info "Processing $(decorate code "$extension") ..."
    if gitPreCommitHasExtension "$extension"; then
      __catchEnvironment "$usage" hookRunOptional "pre-commit-$extension" || return $?
    fi
  done

  gitPreCommitCleanup || :
  statusMessage --last printf -- "%s %s" "$(decorate info "[$hookName]")" "$(timingReport "$start" "completed in")"
}
___hookGitPreCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools "$(__where)" __hookGitPreCommit "$@"
