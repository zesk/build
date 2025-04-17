#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Completion tools
#

# compgen: usage: compgen [-abcdefgjksuv] [-o option] [-A action] [-G globpat] [-W wordlist] [-P prefix] [-S suffix] [-X filterpat] [-F function] [-C command] [word]
#
# -a means names of aliases (-A alias)
# -b means names of shell builtins (-A builtin)
# -c means names of all commands (-A command)
# -d means names of directories (-A directory)
# -e means names of exported shell variables (-A export)
# -f means names of files (-A file)
# -g means names of groups (-A group)
# -j means names of jobs (-A job)
# -k means names of shell reserved words (-A keyword)
# -s means names of services (-A service)
# -u means names of user names (-A user)
# -v means names of shell variables (-A variable)

__buildCompletion() {
  export COMP_WORDS COMP_CWORD COMPREPLY

  local item
  local cur="${COMP_WORDS[COMP_CWORD]}" # Current word being completed
  local fun=()

  if [ "$COMP_CWORD" -le 1 ]; then
    fun=(__buildCompletionFunction "$cur")
  else
    fun=(__buildCompletionArguments)
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
  local usage="_return"

  export COMP_WORDS COMP_CWORD COMPREPLY

  [ "$COMP_CWORD" -ge 2 ] || __throwArgument "$usage" "ONLY call for arguments once function selected" || return $?

  local command="${COMP_WORDS[1]}"
  local word="${COMP_WORDS[COMP_CWORD]-}"
  local previous="${COMP_WORDS[COMP_CWORD - 1]}"
  local home source

  if [ "$COMP_CWORD" -eq 2 ]; then
    previous=""
  fi

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  source=$(__catchEnvironment "$usage" bashDocumentation_FindFunctionDefinitions "$home" "$command" | grep -v "/identical" | head -n 1) || return $?

  id=$(__catchEnvironment "$usage" _commentArgumentSpecification "$source" "$command") || return $?

  _commentArgumentSpecificationComplete "$id" "$previous" "$word"
  printf "%s\n" "#$COMP_CWORD" "${COMP_WORDS[@]}" "previous:$previous" "word:$word" >"$(buildHome)/.completion-debug"
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
  homeText="$(decorate code "$home")"

  shopt -s expand_aliases || return $?

  if [ -z "$reloadAliasName" ]; then
    reloadAliasName="${aliasName}Reload"
  fi
  # shellcheck disable=SC2139
  alias "$aliasName"="$home/bin/build/tools.sh"

  local reloadCode="source \"$home/bin/build/tools.sh\" && decorate info \"Reloaded $name @ $homeText\""

  # shellcheck disable=SC2139
  alias "$reloadAliasName"="$reloadCode"

  $quietFlag || printf "%s %s\n" "$(decorate info "Created aliases")" "$(decorate each code "$aliasName" "$reloadAliasName")"
}
_buildCompletion() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
