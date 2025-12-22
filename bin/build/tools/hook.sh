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
# See: hookRun hookRunOptional hookSource hookSourceOptional
__hookRunner() {
  local handler="${1-}" && shift

  local requireHook=false sourceHook=false

  # Parse internal flags first (this is so users can not accidentally use these, only us)

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
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
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  # Parse user flags first (this is so users can not accidentally use these, only us)

  local applicationHome="" whichArgs=() nextSource="" ww=()
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --next)
      shift
      whichArgs+=("$argument" "$(usageArgumentFile "$handler" "$argument" "${1-}")") || return $?
      ;;
    --extensions) shift && ww+=("$argument" "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $? ;;
    --application)
      shift && applicationHome=$(usageArgumentDirectory "$handler" applicationHome "${1-}") || return $?
      whichArgs+=(--application "$applicationHome")
      ;;
    *)
      local hook binary="$argument"
      shift
      if ! hook=$(whichHook "${ww[@]+"${ww[@]}"}" "${whichArgs[@]+${whichArgs[@]}}" "$binary"); then
        if $requireHook; then
          # hookRun
          throwArgument "$handler" "Hook not found $(decorate code "$binary")" || return $?
        else
          if buildDebugEnabled hook; then
            printf "%s %s %s %s\n" "$(decorate warning "No hook")" "$(decorate code "$binary")" "$(decorate warning "in this project:")" "$(decorate code "$applicationHome")"
          fi
          # hookRunOptional
          return 0
        fi
      fi
      if "$sourceHook"; then
        set -- "$@"
        # shellcheck disable=SC1090
        source "$hook" || throwEnvironment "$handler" "source $hook failed" || return $?
      else
        command env HOME="$HOME" PATH="$PATH" BUILD_HOME="$BUILD_HOME" "$hook" "$@" || return $?
      fi
      return 0
      ;;
    esac
    shift
  done
  throwArgument "$handler" "No hook name passed (Arguments: $(decorate each code "${__saved[@]}"))" || return $?
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
# Argument: --extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
# Argument: --next scriptName - File. Optional. Run the script found *after* the named script, if any. Allows easy chaining of scripts.
# Argument: hookName - String. Required. Hook name to run.
# Argument: ... - Arguments. Optional. Any arguments to the hook. See each hook implementation for details.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Return Code: Any - The hook exit code is returned if it is run
# Return Code: 1 - is returned if the hook is not found
# Example:     version="$({fn} version-current)"
# See: hooks.md hookRunOptional hookRun hookSource hookSourceOptional
# Test: testHookSystem
# Environment: BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG
# BUILD_DEBUG: hook - `hookRun` and `hookSource` and optional versions of the same functions will output additional debugging information
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
# Argument: --extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
# Argument: hookName - String. Required. Hook name to run.
# Argument: ... - Arguments. Optional. Any arguments to the hook. See each hook implementation for details.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Return Code: Any - The hook exit code is returned if it is run
# Return Code: 1 - is returned if the hook is not found
# Example:     version="$({fn} version-current)"
# See: hooks.md hookRunOptional hookRun
# Test: testHookSystem
# Environment: BUILD_HOOK_EXTENSIONS
# Environment: BUILD_HOOK_DIRS
# BUILD_DEBUG: hook - `hookRun` and `hookSource` and optional versions of the same functions will output additional debugging information
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
# Argument: --extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
# Argument: hookName ... - String. Required. Hook to source.
# Return Code: Any - The hook exit code is returned if it is run
# Return Code: 1 - is returned if the hook is not found
# Example:     version="$({fn} version-current)"
# See: hooks.md hookRunOptional
# Test: testHookSystem
# Environment: BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG
# BUILD_DEBUG: hook - `hookRun` and `hookSource` and optional versions of the same functions will output additional debugging information
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
# Argument: --application applicationHome - Path. Optional. Directory of alternate application home.
# Argument: --extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
# Argument: hookName ... - String. Required. Hook to source (if it exists).
# Return Code: Any - The hook exit code is returned if it is run
# Return Code: 0 - is returned if the hook is not found
# Example:     if ! {fn} test-cleanup >>"$quietLog"; then
# Example:         buildFailed "$quietLog"
# Example:     fi
# Test: testHookSystem
# See: hooks.md hookRun
# Environment: BUILD_HOOK_EXTENSIONS
# Environment: BUILD_HOOK_DIRS
# Environment: BUILD_DEBUG
# BUILD_DEBUG: hook - `hookRun` and `hookSource` and optional versions of the same functions will output additional debugging information
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
# Argument: --extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
# Argument: --next scriptName - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts.
# Argument: hookName0 - one or more hook names which must exist
# Return Code: 0 - If all hooks exist
# Test: testHookSystem
# Environment: BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG
hasHook() {
  local handler="_${FUNCNAME[0]}"

  local applicationHome="" ww=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --extensions) shift && ww+=(--extensions "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $? ;;
    --debug) ww+=("$argument") ;;
    --next) shift && ww+=("$argument" "$(usageArgumentFile "$handler" "$argument" "${1-}")") || return $? ;;
    --application) shift && applicationHome=$(usageArgumentDirectory "$handler" applicationHome "${1-}") || return $? ;;
    *)
      local binary
      [ -n "$applicationHome" ] || applicationHome="$(catchReturn "$handler" buildHome)" || return $?
      binary="$(whichHook "${ww[@]+${ww[@]}}" --application "$applicationHome" "$argument")" || return 1
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
# Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
# Argument: --extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
# Argument: --next scriptName - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts.
# Argument: hookName0 - Required. String. Hook to locate
# Argument: hookName1 - Optional. String. Additional hooks to locate.
# Environment: BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG
# Test: testHookSystem
whichHook() {
  local handler="_${FUNCNAME[0]}"
  local applicationHome="" hookPaths=() hookExtensions=() nextSource="" debugFlag=false extensionText=""

  local __saved=("$@") __count=$#
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --application) shift && applicationHome=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $? ;;
    --extensions) shift && extensionText=$(usageArgumentString "$handler" "$argument" "${1-}") || return $? ;;
    --next)
      shift
      nextSource=$(usageArgumentFile "$handler" "$argument" "${1-}") || return $?
      nextSource=$(catchEnvironment "$handler" realPath "$nextSource") || return $?
      ;;
    --debug) debugFlag=true ;;
    *)
      [ -n "$applicationHome" ] || applicationHome="$(catchReturn "$handler" buildHome)" || return $?

      if [ "${#hookPaths[@]}" -eq 0 ]; then
        IFS=":" read -r -a hookPaths < <(buildEnvironmentGet --application "$applicationHome" BUILD_HOOK_DIRS) || :
        [ ${#hookPaths[@]} -gt 0 ] || throwEnvironment "$handler" "BUILD_HOOK_DIRS is blank" || return $?
      fi
      if [ "${#hookExtensions[@]}" -eq 0 ]; then
        [ -n "$extensionText" ] || extensionText="$(buildEnvironmentGet --application "$applicationHome" BUILD_HOOK_EXTENSIONS)"
        IFS=":" read -r -a hookExtensions <<<"$extensionText"
        [ ${#hookExtensions[@]} -gt 0 ] || throwEnvironment "$handler" "BUILD_HOOK_EXTENSIONS is blank" || return $?
      fi

      local hookPath
      ! $debugFlag || decorate info "Hook paths ${#hookPaths[@]} x extensions ${#hookExtensions[@]}" 1>&2
      for hookPath in "${hookPaths[@]}"; do
        local appPath
        pathIsAbsolute "$hookPath" && appPath="$hookPath" || appPath="${applicationHome%/}/${hookPath%/}"
        if [ -d "$appPath" ]; then
          ! $debugFlag || decorate info "Examining path: $appPath" 1>&2
        else
          ! $debugFlag || decorate info "Not a directory path: $appPath" 1>&2
          continue
        fi

        local extension
        for extension in "${hookExtensions[@]}"; do
          extension="${extension#.}"
          [ -z "$extension" ] || extension=".$extension"
          local binary="$appPath/$argument$extension"
          if [ -x "$binary" ]; then
            if [ -n "$nextSource" ]; then
              if [ "$binary" = "$nextSource" ]; then
                nextSource=""
                ! $debugFlag || decorate info "$binary matched NEXT" 1>&2
              else
                ! $debugFlag || decorate info "$binary did not match $nextSource" 1>&2
              fi
              break
            fi
            printf "%s\n" "$binary"
            return 0
          else
            ! $debugFlag || decorate info "$binary $([ -f "$binary" ] && printf "not executable" || printf "not found")" 1>&2
          fi
          [ ! -f "$binary" ] || returnEnvironment "$binary exists but is not executable and will be ignored" || return $?
        done
      done
      ! $debugFlag || decorate info "no more paths" 1>&2
      return 1
      ;;
    esac
    shift
  done
  throwArgument "$handler" "no arguments" || return $?
}
_whichHook() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
