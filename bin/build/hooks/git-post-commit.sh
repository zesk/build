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

# IDENTICAL __source 17
# Usage: {fn} source relativeHome  [ command ... ] ]
# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
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

# IDENTICAL __tools 7
# Usage: {fn} [ relativeHome [ command ... ] ]
# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL __where 10
# Summary: Locates application home depending on whether this is running as a git hook or not
# Usage: {fn}
# If current path contains `.git/` then print `../../..` otherwise print `../..`
# Lets us know if default hooks are in starting directory or are running as a git hook
__where() {
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}/"
  [ "${here%%.git/*}" != "$here" ] || printf "%s" "../"
  printf "%s" "../.."
}

# IDENTICAL _return 24
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  isUnsignedInteger "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
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

__gitPushHelper() {
  local usage="$1"
  local tempFile

  tempFile=$(fileTemporaryName "$usage") || return $?
  statusMessage --last decorate success "Pushing to remote ..."
  if ! __usageEnvironment "$usage" git push origin 2>&1 | tee "$tempFile" | grep 'remote:' | removeFields 1 | wrapLines "Remote: $(decorate code)" "$(decorate reset)"; then
    if ! grep -q 'up-to-date' "$tempFile"; then
      dumpPipe "git push" <"$tempFile" || :
      __usageEnvironment "$usage" rm -rf "$tempFile" || :
      return 1
    fi
  fi
  __usageEnvironment "$usage" rm -rf "$tempFile" || return $?
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
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  statusMessage --first printf -- "%s %s" "$(decorate info "[$hookName]")" "$(decorate info "Installing ...")"
  __usageEnvironment "$usage" gitInstallHook --copy "$hookName" || return $?
  statusMessage --last printf -- "%s %s" "$(decorate info "[$hookName]")" "$(decorate info "Running ...")"
  __usageEnvironment "$usage" hookRunOptional "$hookName" || return $?
  __gitPushHelper "$usage" || return $?
  # __usageEnvironment "$usage" gitMainly && __gitPushHelper "$usage" || return $?
  statusMessage --last printf -- "%s %s" "$(decorate info "[$hookName]")" "$(reportTiming "$start" "completed in")"
}
___hookGitPostCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools "$(__where)" __hookGitPostCommit "$@"
