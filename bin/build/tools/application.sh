#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs:  ./documentation/source/tools/application.md
# Test: ./test/tools/application-tests.sh

__applicationHomeFile() {
  local f home

  home=$(__environment buildEnvironmentGetDirectory XDG_STATE_HOME) || return $?
  f="$home/.applicationHome"
  [ -f "$f" ] || __environment touch "$f" || return $?
  printf "%s\n" "$f"
}

__applicationHomeGo() {
  local usage="$1" && shift
  local file home label userHome oldHome=""

  file=$(__environment __applicationHomeFile) || return $?
  home=$(trimSpace "$(__environment head -n 1 "$file")") || return $?
  if [ -z "$home" ]; then
    __throwEnvironment "$usage" "No code home set, try $(decorate code "applicationHome")" || return $?
  fi
  [ -d "$home" ] || __throwEnvironment "$usage" "Application home directory deleted $(decorate code "$home")" || return $?

  oldHome=$(__catchEnvironment "$usage" buildHome) || return $?

  if [ -d "$oldHome" ] && [ "$oldHome" != "$home" ]; then
    hookSourceOptional --application "$oldHome" project-deactivate || :
  fi
  __catchEnvironment "$usage" cd "$home" || return $?
  label="Working in"
  if [ $# -gt 0 ]; then
    label="${*-}"
    [ -n "$label" ] || return 0
  fi
  userHome="${HOME%/}"
  printf "%s %s\n" "$(decorate label "$label")" "$(decorate value "${home//"$userHome"/~}")"
  hookSourceOptional --application "$home" project-activate || :
  return 0
}

#
# Set, or cd to current application home directory.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: directory - Directory. Optional. Set the application home to this directory.
# Argument: --go - Flag. Optional. Change to the current saved application home directory.
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
# Argument: goAlias - String. Alias for `applicationHome --go`. Default is `g`.
# Argument: setAlias - String. Alias for `applicationHome`. Default is `G`.
applicationHomeAliases() {
  local usage="_${FUNCNAME[0]}"
  local goAlias="" setAlias=""

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
    *)
      if [ -z "$goAlias" ]; then
        goAlias=$(usageArgumentString "$usage" "goAlias" "$argument") || return $?
      elif [ -z "$setAlias" ]; then
        setAlias=$(usageArgumentString "$usage" "setAlias" "$argument") || return $?
      else
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ -n "$goAlias" ] || goAlias="g"
  [ -n "$setAlias" ] || setAlias="G"

  # shellcheck disable=SC2139
  alias "$goAlias"='applicationHome --go' || __throwEnvironment "$usage" "alias $goAlias failed" || return $?
  # shellcheck disable=SC2139
  alias "$setAlias"=applicationHome || __throwEnvironment "$usage" "alias $setAlias failed" || return $?
}
_applicationHomeAliases() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
