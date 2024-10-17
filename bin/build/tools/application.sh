#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs:  ./docs/_templates/tools/application.md
# Test: ./test/tools/application-tests.sh

__applicationHomeFile() {
  local f="${HOME=}/.applicationHome"
  [ -d "${HOME-}" ] || __failEnvironment "$usage" "HOME needs to be defined to use applicationHome" || return $?
  [ -f "$f" ] || touch "$f"
  printf "%s\n" "$f"
}

__applicationHomeGo() {
  local usage="$1" && shift
  local home label

  home=$(trimSpace "$(head -n 1 "$(__applicationHomeFile "$usage")")") || return $?
  if [ -z "$home" ]; then
    __failEnvironment "$usage" "No code home set, try $(consoleCode "applicationHome")" || return $?
  fi
  [ -d "$home" ] || __failEnvironment "$usage" "Application home directory deleted $(consoleCode "$home")" || return $?
  __usageEnvironment "$usage" cd "$home" || return $?
  label="Working in"
  if [ $# -gt 0 ]; then
    label="${*-}"
    [ -n "$label" ] || return 0
  fi
  printf "%s %s\n" "$(consoleLabel "$label")" "$(consoleValue "${home##"${HOME%/}/"}")"
  return 0
}

#
# Set, or cd to current project code home
# Usage: {fn} [ directory ]
#
applicationHome() {
  local usage="_${FUNCNAME[0]}" buildTools="bin/build/tools.sh"
  local argument nArguments argumentIndex saved here

  if [ $# -eq 0 ]; then
    here=$(__usageEnvironment "$usage" pwd) || return $?
    if ! home=$(bashLibraryHome "$buildTools" "$here"); then
      home="$here"
    fi
    printf "%s\n" "$home" >"$(__applicationHomeFile)"
    __applicationHomeGo "$usage" "Application home is current directory"
  else
    saved=("$@")
    nArguments=$#
    while [ $# -gt 0 ]; do
      argumentIndex=$((nArguments - $# + 1))
      argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
      case "$argument" in
        # IDENTICAL --help 4
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
          here=$(usageArgumentDirectory "$usage" "applicationHome" "$1") || return $?
          if ! home=$(bashLibraryHome "$buildTools" "$here"); then
            home="$here"
          fi
          printf "%s\n" "$home" >"$(__applicationHomeFile)"
          __applicationHomeGo "$usage" "Application home set to"
          ;;
      esac
      # IDENTICAL argument-esac-shift 1
      shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
    done
  fi
}
_applicationHome() {
  # IDENTICAL usageDocument 1
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
  alias "$goAlias"='applicationHome --go' || __failEnvironment "$usage" "alias $goAlias failed" || return $?
  # shellcheck disable=SC2139
  alias "$setAlias"=applicationHome || __failEnvironment "$usage" "alias $setAlias failed" || return $?
}
_applicationHomeAliases() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
