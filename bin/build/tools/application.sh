#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs:  ./docs/_templates/tools/application.md
# Test: ./test/tools/application-tests.sh

__applicationHomeFile() {
  local f
  export HOME
  [ -d "${HOME-}" ] || __failEnvironment "$usage" "HOME needs to be defined to use applicationHome" || return $?
  f="${HOME-}/.applicationHome"
  [ -f "$f" ] || touch "$f"
  printf "%s\n" "$f"
}

__applicationHomeGo() {
  local usage="$1" && shift
  local home label userHome

  home=$(trimSpace "$(head -n 1 "$(__applicationHomeFile)")") || return $?
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
  userHome="${HOME%/}"
  printf "%s %s\n" "$(consoleLabel "$label")" "$(consoleValue "${home//"$userHome"/~}")"
  return 0
}

#
# Set, or cd to current project code home
# Usage: {fn} [ directory ]
#
applicationHome() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local here="" home="" buildTools="bin/build/tools.sh"

  export HOME
  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
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
        [ -z "$here" ] || __failArgument "$usage" "Unknown argument (applicationHome set already to $(consoleCode "$here"))"
        here=$(usageArgumentDirectory "$usage" "directory" "$argument") || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  [ -n "$here" ] || here=$(__usageEnvironment "$usage" pwd) || return $?
  home=$(bashLibraryHome "$buildTools" "$here" 2>/dev/null) || home="$here"
  printf "%s\n" "$home" >"$(__applicationHomeFile)"
  __applicationHomeGo "$usage" "${saved[0]-} Application home set to" || return $?
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
