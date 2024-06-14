#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
#
# Docs: o ./docs/_templates/tools/hook.md
# Test: o ./test/tools/hook-tests.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

#
# Actual implementation of `runHook` and `runOptionalHook`
# See: runHook
#
_runHookWrapper() {
  local usageFunction binary hook whichArgs applicationHome requireHook

  usageFunction="$1"
  shift || :

  requireHook=
  whichArgs=()
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      "$usageFunction" "$errorArgument" "blank argument" || return $?
    fi
    case "$1" in
      --require)
        requireHook=1
        ;;
      --application)
        shift || :
        if ! applicationHome=$(usageArgumentDirectory "$usageFunction" applicationHome "$1"); then
          return $errorArgument
        fi
        whichArgs=(--application "$applicationHome")
        ;;
      *)
        binary="$1"
        shift || :
        if ! hook=$(whichHook "${whichArgs[@]+${whichArgs[@]}}" "$binary"); then
          if test "$requireHook"; then
            # runHook
            "$usageFunction" "$errorArgument" "Hook not found $(consoleCode "$binary")" || return $?
          else
            if buildDebugEnabled; then
              printf "%s %s %s %s\n" "$(consoleWarning "No hook")" "$(consoleCode "$binary")" "$(consoleWarning "in this project:")" "$(consoleCode "$applicationHome")"
            fi
            # runOptionalHook
            return 0
          fi
        fi
        if buildDebugEnabled; then
          consoleSuccess "Running hook $binary $*"
        fi
        "$hook" "$@"
        return $?
        ;;
    esac
    shift || "$usageFunction" "$errorArgument" "No more arguments" || return $?
  done
  "$usageFunction" "$errorArgument" "hookName required" || return $?
}

# Run a hook in the project located at `./bin/hooks/`
#
# See (Hooks documentation)[../hooks/index.md] for standard hooks.
#
# Summary: Run a project hook
# Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at `./bin/hooks/` and are named `hookName` with a `.sh` extension added.
# So the hook for `version-current` would be a file at:
#
#     bin/hooks/version-current.sh
#
# Sample hooks (scripts) can be found in the build source code at `./bin/hooks/`.
#
# Default hooks (scripts) can be found in the current build version at `bin/build/hooks/`
#
# Usage: {fn} [ --application applicationHome ] hookName [ arguments ... ]
# Argument: --application applicationHome - Path. Optional. Directory of alternate application home.
# Argument: hookName - String. Required. Hook name to run.
# Argument: arguments - Optional. Arguments are passed to `hookName`.
# Exit code: Any - The hook exit code is returned if it is run
# Exit code: 1 - is returned if the hook is not found
# Example:     version="$({fn} version-current)"
# See: hooks.md runOptionalHook
# Test: testHookSystem
runHook() {
  _runHookWrapper "_${FUNCNAME[0]}" --require "$@"
}
_runHook() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Identical to `runHook` but returns exit code zero if the hook does not exist.
#
# Usage: {fn} hookName [ arguments ... ]
# Exit code: Any - The hook exit code is returned if it is run
# Exit code: 0 - is returned if the hook is not found
# Example:     if ! {fn} test-cleanup >>"$quietLog"; then
# Example:         buildFailed "$quietLog"
# Example:     fi
# Test: testHookSystem
# See: hooks.md runHook
runOptionalHook() {
  _runHookWrapper "_${FUNCNAME[0]}" "$@"
}
_runOptionalHook() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Does a hook exist in the local project?
#
# Check if one or more hook exists. All hooks must exist to succeed.
# Summary: Determine if a hook exists
# Usage: {fn} [ --application applicationHome ] hookName0 [ hookName1 ... ]
# Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
# Argument: hookName0 - one or more hook names which must exist
# Exit Code: 0 - If all hooks exist
# Test: testHookSystem
hasHook() {
  local binary
  local applicationHome

  applicationHome="."
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      _hasHook "$errorArgument" "blank argument" || return $?
    fi
    case "$1" in
      --application)
        shift || :
        if ! applicationHome=$(usageArgumentDirectory _hasHook applicationHome "$1"); then
          return $errorArgument
        fi
        ;;
      *)
        if ! binary="$(whichHook --application "$applicationHome" "$1")"; then
          return "$errorEnvironment"
        fi
        ;;
    esac
    shift || :
  done
}
_hasHook() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Summary: Find the path to a hook binary file
#
# Does a hook exist in the local project?
#
# Find the path to a hook. The search path is:
#
# - `./bin/hooks/`
# - `./bin/build/hooks/`
#
# If a file named `hookName` with the extension `.sh` is found which is executable, it is output.
# Usage: {fn} [ --application applicationHome ] hookName0 [ hookName1 ... ]
# Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
# Arguments: hookName0 - Required. String. Hook to locate
# Arguments: hookName1 - Optional. String. Additional hooks to locate.
#
# Test: testHookSystem
whichHook() {
  local applicationHome binary p e

  applicationHome="."
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      _whichHook "$errorArgument" "blank argument" || return $?
    fi
    case "$1" in
      --application)
        shift || :
        applicationHome=$(usageArgumentDirectory "_whichHook" applicationHome "$1") || return $?
        ;;
      *)
        for p in "$applicationHome/bin/hooks" "$applicationHome/bin/build/hooks"; do
          for e in "" ".sh"; do
            binary="${p%%/}/$1$e"
            if [ -x "$binary" ]; then
              printf "%s\n" "$binary"
              return 0
            fi
            [ ! -f "$binary" ] || _environment "$binary exists but is not executable and will be ignored" || return $?
          done
        done
        return "$errorArgument"
        ;;
    esac
    shift || :
  done
  return "$errorArgument"
}
_whichHook() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
