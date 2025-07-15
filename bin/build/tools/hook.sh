#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
#
# Docs: o ./documentation/source/tools/hook.md
# Test: o ./test/tools/hook-tests.sh

#
# Actual implementation of `hookRun` and `hookRunOptional`
# See: hookRun
#
# BUILD_DEBUG: hook - `hookRun` and `hookSource` and optional versions of the same functions will output additional debugging information
__hookRunner() {
  local usage="${1-}" && shift

  local requireHook=false sourceHook=false

  # Parse internal flags first (this is so users can not accidentally use these, only us)

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    --require)
      requireHook=true
      ;;
    --source)
      sourceHook=true
      ;;
    --)
      shift
      break
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  # Parse user flags first (this is so users can not accidentally use these, only us)

  local applicationHome="" whichArgs=() nextSource=""
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --next)
      shift
      whichArgs+=("$argument" "$(usageArgumentFile "$usage" "$argument" "${1-}")") || return $?
      ;;
    --application)
      shift || :
      applicationHome=$(usageArgumentDirectory "$usage" applicationHome "${1-}") || return $?
      whichArgs+=(--application "$applicationHome")
      ;;
    *)
      local hook binary="$argument"
      shift
      if ! hook=$(whichHook "${whichArgs[@]+${whichArgs[@]}}" "$binary"); then
        if $requireHook; then
          # hookRun
          __throwArgument "$usage" "Hook not found $(decorate code "$binary")" || return $?
        else
          if buildDebugEnabled; then
            printf "%s %s %s %s\n" "$(decorate warning "No hook")" "$(decorate code "$binary")" "$(decorate warning "in this project:")" "$(decorate code "$applicationHome")"
          fi
          # hookRunOptional
          return 0
        fi
      fi
      if buildDebugEnabled hook; then
        statusMessage decorate success "Running hook $(decorate code "$binary") $*"
      fi
      if "$sourceHook"; then
        set --
        __catchEnvironment "$usage" source "$hook" || return $?
      else
        "$hook" "$@" || return $?
      fi
      return 0
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  __throwArgument "$usage" "No hook name passed (Arguments: $(decorate each code "${__saved[@]}"))" || return $?
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
# Argument: --next scriptName - File. Optional. Run the script found *after* the named script, if any. Allows easy chaining of scripts.
# Argument: hookName - String. Required. Hook name to run.
# Argument: arguments - Optional. Arguments are passed to `hookName`.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Exit code: Any - The hook exit code is returned if it is run
# Exit code: 1 - is returned if the hook is not found
# Example:     version="$({fn} version-current)"
# See: hooks.md hookRunOptional hookRun hookSource hookSourceOptional
# Test: testHookSystem
# Environment: BUILD_HOOK_DIRS
hookRun() {
  __hookRunner "_${FUNCNAME[0]}" --require -- "$@"
}
_hookRun() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Identical to `hookRun` but returns exit code zero if the hook does not exist.
#
# Usage: {fn} [ --application applicationHome ] hookName [ arguments ... ]
# Argument: --next scriptName - File. Optional. Run the script found *after* the named script, if any. Allows easy chaining of scripts.
# Argument: --application applicationHome - Path. Optional. Directory of alternate application home.
# Argument: hookName - String. Required. Hook name to run.
# Argument: arguments - Optional. Arguments are passed to `hookName`.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Exit code: Any - The hook exit code is returned if it is run
# Exit code: 1 - is returned if the hook is not found
# Example:     version="$({fn} version-current)"
# See: hooks.md hookRunOptional hookRun
# Test: testHookSystem
# Environment: BUILD_HOOK_DIRS
hookRunOptional() {
  __hookRunner "_${FUNCNAME[0]}" -- "$@"
}
_hookRunOptional() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
# See: hooks.md hookRunOptional
# Test: testHookSystem
# Environment: BUILD_HOOK_DIRS
hookSource() {
  __hookRunner "_${FUNCNAME[0]}" --source --require -- "$@"
}
_hookSource() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Identical to `hookRun` but returns exit code zero if the hook does not exist.
#
# Usage: {fn} hookName [ arguments ... ]
# Exit code: Any - The hook exit code is returned if it is run
# Exit code: 0 - is returned if the hook is not found
# Example:     if ! {fn} test-cleanup >>"$quietLog"; then
# Example:         buildFailed "$quietLog"
# Example:     fi
# Test: testHookSystem
# See: hooks.md hookRun
hookSourceOptional() {
  __hookRunner "_${FUNCNAME[0]}" --source -- "$@"
}
_hookSourceOptional() {
  # __IDENTICAL__ usageDocument 1
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
# Environment: BUILD_HOOK_DIRS
hasHook() {
  local usage="_${FUNCNAME[0]}"

  local applicationHome

  applicationHome="$(__catchEnvironment "$usage" buildHome)" || return $?
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    # _IDENTICAL_ --handler 4
    --handler)
      shift
      usage=$(usageArgumentFunction "$usage" "$argument" "${1-}") || return $?
      ;;
    --application)
      shift || :
      applicationHome=$(usageArgumentDirectory "$usage" applicationHome "${1-}") || return $?
      ;;
    *)
      local binary
      binary="$(whichHook --application "$applicationHome" "$argument")" || return 1
      [ -n "$binary" ] || return 1
      ;;
    esac
    shift
  done
}
_hasHook() {
  # __IDENTICAL__ usageDocument 1
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
# Argument: hookName0 - Required. String. Hook to locate
# Argument: hookName1 - Optional. String. Additional hooks to locate.
#
# Test: testHookSystem
whichHook() {
  local usage="_${FUNCNAME[0]}"
  local applicationHome hookPaths=() hookExtensions=() nextSource=""

  export BUILD_HOOK_DIRS
  __catchEnvironment "$usage" buildEnvironmentLoad BUILD_HOOK_DIRS BUILD_HOOK_EXTENSIONS || return $?

  IFS=":" read -r -a hookPaths <<<"$BUILD_HOOK_DIRS" || :
  [ ${#hookPaths[@]} -gt 0 ] || __throwEnvironment "$usage" "BUILD_HOOK_DIRS is blank" || return $?

  IFS=":" read -r -a hookExtensions <<<"$BUILD_HOOK_EXTENSIONS" || :
  [ ${#hookExtensions[@]} -gt 0 ] || __throwEnvironment "$usage" "BUILD_HOOK_EXTENSIONS is blank" || return $?

  applicationHome="$(__catchEnvironment "$usage" buildHome)" || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    # _IDENTICAL_ --handler 4
    --handler)
      shift
      usage=$(usageArgumentFunction "$usage" "$argument" "${1-}") || return $?
      ;;
    --application)
      shift
      applicationHome=$(usageArgumentDirectory "$usage" "$argument" "${1-}") || return $?
      ;;
    --next)
      shift
      nextSource=$(usageArgumentFile "$usage" "$argument" "${1-}") || return $?
      nextSource=$(__catchEnvironment "$usage" realPath "$nextSource") || return $?
      ;;
    *)
      local hookPath
      for hookPath in "${hookPaths[@]}"; do
        local appPath="${applicationHome%/}/${hookPath%/}"
        [ -d "$appPath" ] || continue
        local extension
        for extension in "${hookExtensions[@]}"; do
          extension="${extension#.}"
          [ -z "$extension" ] || extension=".$extension"
          local binary="$appPath/$argument$extension"
          if [ -x "$binary" ]; then
            if [ -n "$nextSource" ]; then
              if [ "$binary" = "$nextSource" ]; then
                nextSource=""
              fi
              break
            fi
            printf "%s\n" "$binary"
            return 0
          fi
          [ ! -f "$binary" ] || _environment "$binary exists but is not executable and will be ignored" || return $?
        done
      done
      return 1
      ;;
    esac
    shift
  done
  __throwArgument "$usage" "no arguments" || return $?
}
_whichHook() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
