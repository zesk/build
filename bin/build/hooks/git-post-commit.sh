#!/usr/bin/env bash
#
# Part of build system integration with git
#
# This file name MUST be prefixed with `git-` and suffixed with `.sh` and the remainder should
# be the `git` `.git/hook/` name.
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

# IDENTICAL _return 28

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local code="${1:-1}" && shift 2>/dev/null
  isUnsignedInteger "$code" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer \"$code\"" "$@" || return $?
  [ "$code" -gt 0 ] || printf -- "✅ %s\n" "${*-§}" && return 0
  printf -- "❌ [%d] %s\n" "$code" "${*-§}" 1>&2
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

__gitPushHelper() {
  local usage="$1"
  local tempFile

  tempFile=$(fileTemporaryName "$usage") || return $?
  statusMessage --last decorate success "Pushing to remote ..."
  if ! __catchEnvironment "$usage" git push origin 2>&1 | tee "$tempFile" | grep 'remote:' | removeFields 1 | wrapLines "Remote: $(decorate code)" "$(decorate reset)"; then
    if ! grep -q 'up-to-date' "$tempFile"; then
      dumpPipe "git push" <"$tempFile" || :
      __catchEnvironment "$usage" rm -rf "$tempFile" || :
      return 1
    fi
  fi
  __catchEnvironment "$usage" rm -rf "$tempFile" || return $?
}

#
# The `git-post-commit` hook will be installed as a `git` post-commit hook in your project and will
# overwrite any existing `post-commit` hook.
#
# Merges `main` and `staging` and pushes to `origin`
#
# fn: {base}
__hookGitPostCommit() {
  local usage="_${FUNCNAME[0]}" hookName="post-commit" start
  start=$(timingStart) || return $?
  statusMessage --first printf -- "%s %s" "$(decorate info "[$hookName]")" "$(decorate info "Installing ...")"
  __catchEnvironment "$usage" gitInstallHook --copy "$hookName" || return $?
  statusMessage --last printf -- "%s %s" "$(decorate info "[$hookName]")" "$(decorate info "Running ...")"
  __catchEnvironment "$usage" hookRunOptional "$hookName" || return $?
  __gitPushHelper "$usage" || return $?
  # __catchEnvironment "$usage" gitMainly && __gitPushHelper "$usage" || return $?
  statusMessage --last printf -- "%s %s" "$(decorate info "[$hookName]")" "$(timingReport "$start" "completed in")"
}
___hookGitPostCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools "$(__gitHookPath)" __hookGitPostCommit "$@"
