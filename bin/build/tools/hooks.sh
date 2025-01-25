#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/hooks.md
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
  local usage="$1" hookName="$2"

  local application=""

  shift 2 || :

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --application)
        shift
        application=$(usageArgumentDirectory "$usage" "home" "${1-}") || return $?
        ;;
      *)
        break
        ;;
    esac
    shift
  done

  local start

  start="$(pwd -P 2>/dev/null)" || __throwEnvironment "$usage" "Failed to get pwd" || return $?
  if [ -z "$application" ]; then
    application=$(gitFindHome "$start") || __throwEnvironment "$usage" "Unable to find git home" || return $?
    application="${application%/}"
    if [ "${start#"$application"}" = "$start" ]; then
      buildEnvironmentContext hookVersionCurrent --application "$application" "${__saved[@]}" || return $?
      return 0
    fi
  fi
  __catchEnvironment "$usage" hookRun --application "$application" "$hookName" "$@" || return $?
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
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
