#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs:  ./docs/_templates/tools/application.md
# Test: ./test/tools/application-tests.sh

__applicationHomeFile() {
  local f
  export HOME
  [ -d "${HOME-}" ] || __throwEnvironment "$usage" "HOME needs to be defined to use applicationHome" || return $?
  f="${HOME-}/.applicationHome"
  [ -f "$f" ] || touch "$f"
  printf "%s\n" "$f"
}

__applicationHomeGo() {
  local usage="$1" && shift
  local home label userHome

  home=$(trimSpace "$(head -n 1 "$(__applicationHomeFile)")") || return $?
  if [ -z "$home" ]; then
    __throwEnvironment "$usage" "No code home set, try $(decorate code "applicationHome")" || return $?
  fi
  [ -d "$home" ] || __throwEnvironment "$usage" "Application home directory deleted $(decorate code "$home")" || return $?
  __catchEnvironment "$usage" cd "$home" || return $?
  label="Working in"
  if [ $# -gt 0 ]; then
    label="${*-}"
    [ -n "$label" ] || return 0
  fi
  userHome="${HOME%/}"
  printf "%s %s\n" "$(decorate label "$label")" "$(decorate value "${home//"$userHome"/~}")"
  return 0
}

#
# Set, or cd to current project code home
# Usage: {fn} [ directory ]
#
applicationHome() {
  local usage="_${FUNCNAME[0]}"

  local here="" home="" buildTools="bin/build/tools.sh"

  export HOME

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
      --go)
        shift
        __applicationHomeGo "$usage" "$@"
        return 0
        ;;
      *)
        [ -z "$here" ] || __throwArgument "$usage" "Unknown argument (applicationHome set already to $(decorate code "$here"))"
        here=$(usageArgumentDirectory "$usage" "directory" "$argument") || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ -n "$here" ] || here=$(__catchEnvironment "$usage" pwd) || return $?
  home=$(bashLibraryHome "$buildTools" "$here" 2>/dev/null) || home="$here"
  printf "%s\n" "$home" >"$(__applicationHomeFile)"
  __applicationHomeGo "$usage" "${__saved[0]-} Application home set to" || return $?
}
_applicationHome() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Set aliases `G` and `g` default for `applicationHome`
# Localize as you wish for your own shell
#
applicationHomeAliases() {
  local usage="_${FUNCNAME[0]}"
  local goAlias="${1-g}" setAlias="${2-G}"
  # shellcheck disable=SC2139
  alias "$goAlias"='applicationHome --go' || __throwEnvironment "$usage" "alias $goAlias failed" || return $?
  # shellcheck disable=SC2139
  alias "$setAlias"=applicationHome || __throwEnvironment "$usage" "alias $setAlias failed" || return $?
}
_applicationHomeAliases() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
