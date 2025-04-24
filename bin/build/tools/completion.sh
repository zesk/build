#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Completion tools
#

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

  if [ "$COMP_CWORD" -eq 2 ]; then
    previous=""
  fi

  if [ -n "$command" ]; then
    id=$(__buildCompletionFunctionID "$usage" "$command") || return $?
    if [ -n "$id" ]; then
      _commentArgumentSpecificationComplete "$id" "$previous" "$word"
    else
      printf "%s\n" "function not found"
    fi
  fi

  printf "%s\n" "#$COMP_CWORD" "${COMP_WORDS[@]}" "previous:$previous" "word:$word" >"$(buildHome)/.completion-debug"
}

__buildCompletionFunctionID() {
  local cache usage="$1" command="$2"

  cache="$(buildCacheDirectory "COMPLETION")"
  if [ -f "$cache/$command" ]; then
    cat "$cache/$command"
  else
    local home source

    home=$(__catchEnvironment "$usage" buildHome) || return $?
    echo HERE
    source=$(__catchEnvironment "$usage" bashDocumentation_FindFunctionDefinitions "$home" "$command" | grepSafe -v "/identical" | head -n 1) || return $?
    if [ -n "$source" ]; then
      id=$(__catchEnvironment "$usage" _commentArgumentSpecification "$source" "$command") || return $?
      if [ -n "$id" ]; then
        printf "%s\n" "$id" | tee "$cache/$command"
      fi
    else
      printf "%s\n" "No source for $command: $home"
    fi
  fi
}

# Non-empty string
__completionTypeString() {
  printf "%s\n" "$@"
}

# Any value passes
__completionTypeEmptyString() {
  printf "%s\n" "$@" '""'
}

# Arrays can be zero-length so any value passes
__completionTypeArray() {
  printf "%s\n" "$@"
}

# Lists can be zero-length so any value passes
__completionTypeList() {
  printf "%s\n" "$@"
}

# `:`-delimited list
__completionTypeColonDelimitedList() {
  printf "%s\n" "$@"

}

# `,`-delimited list
__completionTypeCommaDelimitedList() {
  printf "%s\n" "$@"
}

# unsigned integer is greater than or equal to zero
__completionTypeUnsignedInteger() {
  local value="" i
  local digits=(0 1 2 3 4 5 6 7 8 9)
  if isUnsignedInteger "${1-}"; then
    value="$1"
    printf "%d\n" "$value"
  fi
  for i in "${digits[@]}"; do
    printf "%s%d\n" "$value" "$i"
  done
}

__completionTypePositiveInteger() {
  local value="" i
  local digits=(0 1 2 3 4 5 6 7 8 9)
  if isPositiveInteger "${1-}"; then
    value="$1"
    printf "%d\n" "$value"
  fi
  for i in "${digits[@]}"; do
    printf "%s%d\n" "$value" "$i"
  done
}

__completionTypeInteger() {
  local value="" i
  local digits=(0 1 2 3 4 5 6 7 8 9)
  if isInteger "${1-}"; then
    value="$1"
    printf "%d\n" "$value"
  fi
  for i in "${digits[@]}"; do
    printf "%s%d\n" "$value" "$i"
  done
}

__completionTypeNumber() {
  local value="" i
  local digits=(0 1 2 3 4 5 6 7 8 9)
  if isNumber "${1-}"; then
    value="$1"
    printf "%d\n" "$value"
  fi
  for i in "${digits[@]}"; do
    printf "%s%d\n" "$value" "$i"
  done
}

__completionTypeFunction() {
  local pattern
  if [ -n "${1-}" ]; then
    pattern=$(quoteGrepPattern "$1")
  else
    pattern="."
  fi
  declare -F | removeFields 2 | grep -e "^$pattern"
}

__completionTypeCallable() {
  __completionTypeFunction "$@"
  __completionTypeExecutable "$@"
}

__completionTypeExecutable() {
  comgen -A command "$@"
}

__completionTypeApplicationDirectory() {
  local search="$1" home
  home="$(buildHome)"
  home="${home%/}/"
  search="${search#"$home"}"
  search="$home${search%/}"
  search="${search%/}"
  compgen -A directory "$search" | cut -c "$((${#home} + 1))"-
  compgen -A directory "$search/" | cut -c "$((${#home} + 1))"-
}

__completionTypeApplicationFile() {
  local search="$1" home
  home="$(buildHome)"
  home="${home%/}/"
  search="${search#"$home"}"
  search="$home${search%/}"
  search="${search%/}"
  compgen -A file "$search" | cut -c "$((${#home} + 1))"-
  compgen -A file "$search/" | cut -c "$((${#home} + 1))"-
}

__completionTypeApplicationDirectoryList() {
  local search="$1" home
  home="$(buildHome)"
  home="${home%/}/"
  search="${search#"$home"}"
  search="$home${search%/}"
  search="${search%/}"
  compgen -A directory "$search" | cut -c "$((${#home} + 1))"-
  compgen -A directory "$search/" | cut -c "$((${#home} + 1))"-
}

# Strict boolean `false` or `true`
__completionTypeBoolean() {
  printf "%s\n" "true" "false"
}

# Boolean-like value
__completionTypeBooleanLike() {
  printf "%s\n" "true" "false" "yes" "no" "0" "1"
}

# Date formatted like YYYY-MM-DD
__completionTypeDate() {
  dateValid "${1-}" || __throwValidate || return $?
  printf "%s\n" "${1-}"
}

# List of directories separated by `:`
__completionTypeDirectoryList() {
  compgen -A directory "$@"
}

# A valid environment variable name
__completionTypeEnvironmentVariable() {
  comgen -A export
}

# Validates a value is not blank and exists in the file system
__completionTypeExists() {
  compgen -A file "$@"
}

# A file exists
__completionTypeFile() {
  compgen -A file "$@"
}

# A directory exists
__completionTypeDirectory() {
  compgen -A directory "$@"
}

# A link exists
__completionTypeLink() {
  find "${1-.}" -type l
}

# A file directory exists (file may exist or not)
__completionTypeFileDirectory() {
  compgen -A directory "$@"
}

# A real path for a directory
__completionTypeRealDirectory() {
  compgen -A directory "$@"
}

# A real path for a file
__completionTypeRealFile() {
  compgen -A file "$@"
}

# A path which is on a remote system
__completionTypeRemoteDirectory() {
  [ "${1:0:1}" = "/" ] || __throwValidate "begins with a slash" || return $?
  printf "%s\n" "${1%/}"
}

# An URL
__completionTypeURL() {
  urlValid "${1-}" || __throwValidate "invalid url" || return $?
  printf "%s\n" "${1-}"
}

# output arguments to stderr and return the argument error
# Return: 2
# Exit Code: 2 - Argument error
__throwValidate() {
  printf -- "%s\n" "$@" 1>&2
  return 2
}
