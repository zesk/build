#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Argument: variableName ... - String. Required. Exit status 0 if all variables names are valid ones.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Validates zero or more environment variable names.
#
# - alpha
# - digit
# - underscore
#
# First letter MUST NOT be a digit
environmentVariableNameValid() {
  local handler="_${FUNCNAME[0]}"
  local name
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || return 1
    case "$1" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *[!A-Za-z0-9_]*)
      return 1
      ;;
    *)
      case "${1:0:1}" in
      [A-Za-z_]) ;;
      *) return 1 ;;
      esac
      ;;
    esac
    shift
  done
}
_environmentVariableNameValid() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List environment variables related to security
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
environmentSecureVariables() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf -- "%s\n" PATH LD_LIBRARY USER HOME HOSTNAME LANG PS1 PS2 PS3 CWD PWD SHELL SHLVL TERM TMPDIR VISUAL EDITOR
}
_environmentSecureVariables() {
  true || environmentSecureVariables --help
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Display and validate application variables.
# Return Code: 1 - If any required application variables are blank, the function fails with an environment error
# Return Code: 0 - All required application variables are non-blank
# Argument: environmentName - EnvironmentVariable. Optional. A required environment variable name
# Argument: -- - Separator. Optional. Separates requires from optional environment variables
# Argument: optionalEnvironmentName - EnvironmentVariable. Optional. An optional environment variable name.
environmentFileShow() {
  local handler="_${FUNCNAME[0]}"
  local name
  local width=40
  local extras=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --)
      shift
      break
      ;;
    *)
      extras+=("$(validate "$handler" EnvironmentVariable "variableName" "$argument")") || return $?
      ;;
    esac
    shift
  done
  local buildEnvironment=("$@")

  IFS=$'\n' read -d '' -r -a variables < <(environmentApplicationVariables) || :
  for name in "${variables[@]+"${variables[@]}"}" "${extras[@]+"${extras[@]}"}"; do
    environmentVariableNameValid "$name" || catchArgument "$handler" "Invalid environment name $(decorate code "$name")" 1>&2
  done
  export "${variables[@]}"

  catchEnvironment "$handler" muzzle environmentApplicationLoad || return $?

  environmentVariableNameValid "$@" || catchArgument "$handler" "Invalid variable name" || return $?

  printf -- "%s %s %s %s%s\n" "$(decorate info "Application")" "$(decorate magenta "$APPLICATION_VERSION")" "$(decorate info "on")" "$(decorate BOLD red "$APPLICATION_BUILD_DATE")" "$(decorate info "...")"
  if buildDebugEnabled; then
    decorate pair "$width" Checksum "$APPLICATION_ID"
    decorate pair "$width" Tag "$APPLICATION_TAG"
    decorate pair "$width" Timestamp "$BUILD_TIMESTAMP"
  fi
  local name missing=()
  for name in "${variables[@]}"; do
    if [ -z "${!name:-}" ]; then
      decorate pair "$width" "$name" "** No value **" 1>&2
      missing+=("$name")
    else
      decorate pair "$width" "$name" "${!name}"
    fi
  done
  for name in "${buildEnvironment[@]+"${buildEnvironment[@]}"}"; do
    if [ -z "${!name:-}" ]; then
      decorate pair "$width" "$name" "** Blank **"
    else
      decorate pair "$width" "$name" "${!name}"
    fi
  done
  [ ${#missing[@]} -eq 0 ] || throwEnvironment "$handler" "Missing environment $(decorate each code "${missing[@]}")" || return $?
}
_environmentFileShow() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL environmentVariables 19

# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
# Requires: declare grep cut bashDocumentation __help
environmentVariables() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  {
    declare -px | grep 'declare -x ' | cut -f 1 -d "=" | cut -f 3 -d " " && declare -ax | grep 'declare -ax ' | cut -f 1 -d '=' | cut -f 3 -d " "
  } | catchReturn "$handler" sort -u || return $?
}
_environmentVariables() {
  true || environmentVariables --help
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Parse variables from an environment variable stream
#
# Extracts lines with `NAME=value`
#
# Details:
# - Remove `export ` from lines
# - Skip lines containing `read -r`
# - Anything before a `=` is considered a variable name
# - Returns a sorted, unique list
# stdin: Environment File
# stdout: EnvironmentVariable. One per line.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
environmentParseVariables() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  grepSafe -e '^\(export \)\?\s*[A-Za-z_][A-Za-z_0-9]*=' | grep -v 'read -r' | sed 's/^export[[:space:]][[:space:]]*//g' | cut -f 1 -d = | sort -u
}
_environmentParseVariables() {
  true || environmentParseVariables --help || return $?
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Clean *most* exported variables from the current context except a few important ones:
# - BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4
# Calls unset on any variable in the global environment and exported.
# Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line
# Argument: keepEnvironment - EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.
environmentClean() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local finished=false variable keepers=(PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4 BUILD_HOME "$@")
  while ! $finished; do
    read -r variable || finished=true
    [ -n "$variable" ] || continue
    ! inArray "$variable" "${keepers[@]}" || continue
    unset "${variable?}" 2>/dev/null || :
  done < <(environmentVariables)
}
_environmentClean() {
  true || environmentClean --help
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output all exported environment variables, hiding secure ones and ones prefixed with underscore.
# Any values which contain a newline are also skipped.
#
# See: environmentSecureVariables
# Requires: throwArgument decorate environmentSecureVariables grepSafe env textRemoveFields
# Argument: --underscore - Flag. Optional. Include environment variables which begin with underscore `_`.
# Argument: --skip-prefix prefixString - String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive).
# Argument: --secure - Flag. Optional. Include environment variables which are in `environmentSecureVariables`
# Argument: variable ... - String. Optional. Output these variables explicitly.
environmentOutput() {
  local handler="_${FUNCNAME[0]}"
  local __handler="$handler"
  local __skipSecure=true __skipUnderscore=true __variables=() __skipPrefix=() __debugFlag=false __skipNames=()
  local __written=("")

  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local __argument="$1" __index=$((__count - $# + 1))
    [ -n "$__argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$__argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --underscore) __skipUnderscore=false ;;
    --skip) shift && __skipNames+=("$(validate "$handler" String "$__argument" "${1-}")") || return $? ;;
    --skip-prefix) shift && __skipPrefix+=("$(validate "$handler" String "$__argument" "${1-}")") || return $? ;;
    --secure) __skipSecure=false ;;
    --debug) __debugFlag=true ;;
    *) __variables+=("$(validate "$handler" "EnvironmentVariable" "variable" "$__argument")") || return $? ;;
    esac
    shift
  done

  if $__skipSecure; then
    local __secureVariable && while read -r __secureVariable; do __written+=("$__secureVariable"); done < <(environmentSecureVariables)
  fi
  if $__skipUnderscore; then
    __skipPrefix+=('_')
  fi
  local __name __value __finished=false
  while IFS='=' read -r __name __value; do
    ! $__debugFlag || printf "%s\n" "# ARRAY: $__name"
    [ "${#__skipPrefix[@]}" -eq 0 ] || ! stringBegins "$__name" "${__skipPrefix[@]}" || continue
    [ "${#__skipNames[@]}" -eq 0 ] || ! inArray "$__name" "${__skipNames[@]}" || continue
    [ "${#__written[@]}" -eq 0 ] || ! inArray "$__name" "${__written[@]}" || continue
    catchReturn "$__handler" printf "%s=%s\n" "$__name" "$(stringUnquote "'" "$__value")" || return $?
    __written+=("$__name")
  done < <(declare -ax | textRemoveFields 2)
  ! $__debugFlag || printf "%s\n" "# above is arrays"
  while ! $__finished; do
    IFS="=" read -r -d $'\0' __name __value || __finished=true
    [ -n "$__name" ] && [ "${__name%\%}" = "$__name" ] || continue
    [ "${#__skipPrefix[@]}" -eq 0 ] || ! stringBegins "$__name" "${__skipPrefix[@]}" || continue
    [ "${#__skipNames[@]}" -eq 0 ] || ! inArray "$__name" "${__skipNames[@]}" || continue
    [ "${#__written[@]}" -eq 0 ] || ! inArray "$__name" "${__written[@]}" || continue
    catchReturn "$__handler" environmentValueWrite "$__name" "$__value" || return $?
    __written+=("$__name")
  done < <(env -0)
  ! $__debugFlag || printf "%s\n" "# above is env -0"
  [ ${#__variables[@]} -eq 0 ] || for __name in "${__variables[@]}"; do
    [ "${#__skipPrefix[@]}" -eq 0 ] || ! stringBegins "$__name" "${__skipPrefix[@]}" || continue
    [ "${#__written[@]}" -eq 0 ] || ! inArray "$__name" "${__written[@]}" || continue
    __value="${!__name-}"
    catchReturn "$__handler" environmentValueWrite "$__name" "$__value" || return $?
    __written+=("$__name")
  done
  ! $__debugFlag || printf "%s\n" "# above is argument variables"
}
_environmentOutput() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
