#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/hooks.md
# Test: ./test/tools/hooks-tests.sh

# Runs a hook in the current Zesk Build context
# Usage: {fn} usageFunction hookName [ --help ] [ --home home ] arguments ...
# Argument: usageFunction - Function. Required.
# Argument. hookName. String. Required.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --home home - Optional. Directory. Application home directory.
# Argument: arguments ... - String. Optional. Arguments to `hookName`'s hook.
_hookContextWrapper() {
  local handler="$1" hookName="$2"

  local application=""

  shift 2 || :

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || returnThrowArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --application)
      shift
      application=$(usageArgumentDirectory "$handler" "home" "${1-}") || return $?
      ;;
    *)
      break
      ;;
    esac
    shift
  done

  local start home

  home=$(returnCatch "$handler" buildHome) || return $?
  start="$(pwd -P 2>/dev/null)" || returnThrowEnvironment "$handler" "Failed to get pwd" || return $?
  start=$(catchEnvironment "$handler" realPath "$start") || return $?

  if [ -z "$application" ]; then
    if [ "${start#"$home"}" = "$start" ]; then
      application="$home"
    else
      application=$(returnCatch "$handler" bashLibraryHome "bin/build/tools.sh" "$start") || return $?
      application="${application%/}"
      if [ "${start#"$application"}" = "$start" ]; then
        buildEnvironmentContext "$application" hookRun --application "$application" "$hookName" "$@" || return $?
        return 0
      fi
    fi
  fi
  catchEnvironment "$handler" hookRun --application "$application" "$hookName" "$@" || return $?
}

# Application current version
#
# Extracts the version from the repository
#
# Usage: {fn}  [ --help ] [ --home home ] arguments ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --application application - Optional. Directory. Application home directory.
hookVersionCurrent() {
  _hookContextWrapper "_${FUNCNAME[0]}" "version-current" "$@"
}
_hookVersionCurrent() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Application deployed version
# Usage: {fn}  [ --help ] [ --home home ] arguments ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --application application - Optional. Directory. Application home directory.
hookVersionLive() {
  _hookContextWrapper "_${FUNCNAME[0]}" "version-live" "$@"
}
_hookVersionLive() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
