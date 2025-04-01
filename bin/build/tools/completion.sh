#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Completion tools
#

__buildCompletion() {
  export COMP_WORDS COMP_CWORD COMPREPLY

  local item
  local cur="${COMP_WORDS[COMP_CWORD]}" # Current word being completed
  local fun=()

  if [ "$COMP_CWORD" -le 1 ]; then
    fun=(__buildCompletionFunction "$cur")
  else
    fun=(__buildCompletionArguments "${COMP_WORDS[@]}")
  fi
  COMPREPLY=()
  while read -r item; do COMPREPLY+=("$item"); done < <("${fun[@]}")
}

__buildCompletionFunction() {
  if [ -z "$1" ]; then
    buildFunctions
  else
    buildFunctions | grepSafe -e "^$(quoteGrepPattern "$1")"
  fi
}

__buildCompletionArguments() {
  : "TODO"
  # Look at `_arguments` code

}

# Add completion handler for Zesk Build to Bash
# Argument: --quiet - Flag. Optional. Do not output any messages to stdout.
# Argument: --alias name - String. Optional. The name of the alias to create.
# Argument: --reload-alias name - String. Optional. The name of the alias which reloads Zesk Build. (source)
# This has the side effect of turning on the shell option `expand_aliases`
# Shell Option: +expand_aliases
buildCompletion() {
  local usage="_${FUNCNAME[0]}"
  local aliasName="build" reloadAliasName="" quietFlag=false

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
      --quiet)
        quietFlag=true
        ;;
      --alias)
        shift
        aliasName=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      --reload-alias)
        shift
        reloadAliasName=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  complete -F __buildCompletion "$aliasName"

  local home name homeText

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  name="$(decorate info "$(buildEnvironmentGet APPLICATION_NAME)")"
  homeText=$(decorate file "$homeText")

  shopt -s expand_aliases || return $?

  if [ -z "$reloadAliasName" ]; then
    reloadAliasName="${aliasName}Reload"
  fi
  # shellcheck disable=SC2139
  alias "$aliasName"="$home/bin/build/tools.sh"
  # shellcheck disable=SC2139
  alias "$reloadAliasName"="source \"$home/bin/build/tools.sh\" && decorate info \"Reloaded $name @ $homeText\" "
  $quietFlag || printf "%s %s\n" "$(decorate info "Created aliases")" "$(decorate each code "$aliasName" "$reloadAliasName")"
}
_buildCompletion() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
