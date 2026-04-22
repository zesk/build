#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

#
# Write a value to a state file as NAME="value"
# Argument: name - String. Required. Name to write.
# Argument: value - EmptyString. Optional. Value to write.
# Argument: ... - EmptyString. Optional. Additional values, when supplied, write this value as an array.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
environmentValueWrite() {
  local handler="_${FUNCNAME[0]}" name
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local value replace="\"$'\n'\""

  name=$(validate "$handler" EnvironmentVariable "name" "${1-}") || return $?
  shift
  [ $# -ge 1 ] || throwArgument "$handler" "value required" || return $?
  if [ $# -eq 1 ]; then
    value="${1-}"
    value="$(declare -p value)"
    [ "${value#*$'\n'}" = "$value" ] || value=${value//$'\n'/"$replace"}
    __environmentValueWrite "$name" "$value" || return $?
  else
    environmentValueWriteArray "$name" "$@"
  fi
}
_environmentValueWrite() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Write an array value as NAME=([0]="a" [1]="b" [2]="c")
# Supports empty arrays
# Bash outputs on different versions:
#
#     declare -a foo='([0]="a" [1]="b" [2]="c")'
#     declare -a foo=([0]="a" [1]="b" [2]="c")
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: value ... - Arguments. Optional. Array values as arguments.
# Argument: --help - Flag. Optional. Display this help.
environmentValueWriteArray() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local name value result search="'" replace="'\''"

  name=$(validate "$handler" EnvironmentVariable "name" "${1-}") || return $?
  shift
  if [ $# -eq 0 ]; then
    printf "%s=%s\n" "$name" "()"
  else
    value=("$@")
    result="$(__environmentValueClean "$(declare -pa value)")" || return $?
    if [ "${result:0:1}" = "'" ]; then
      result="$(stringUnquote \' "$result")"
      printf "%s=%s\n" "$name" "${result//"$replace"/$search}"
    else
      printf "%s=%s\n" "$name" "$result"
    fi
  fi
}
_environmentValueWriteArray() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Utility function to strip "declare value=" from a string
__environmentValueClean() {
  printf -- "%s\n" "${1#declare*value=}"
}

# Utility function to write a value
__environmentValueWrite() {
  printf "%s=%s\n" "$1" "$(__environmentValueClean "$2")" || return $?
}

# Argument: stateFile - EnvironmentFile. Required. File to read a value from.
# Argument: name - EnvironmentVariable. Required. Variable to read.
# Argument: default - EmptyString. Optional. Default value of the environment variable if it does not exist.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 1 - If value is not found and no default argument is supplied (2 arguments)
# Return Code: 0 - If value
environmentValueRead() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local stateFile name default="${3---}" value
  stateFile=$(validate "$handler" File "stateFile" "${1-}") || return $?
  name=$(validate "$handler" EnvironmentVariable "name" "${2-}") || return $?
  [ $# -le 3 ] || throwArgument "$handler" "Extra arguments: $#" || return $?
  if ! value="$(grep -e "^$(quoteGrepPattern "$name")=" "$stateFile" | tail -n 1 | cut -c $((${#name} + 2))-)" || [ -z "$value" ]; then
    if [ $# -le 2 ]; then
      return 1
    fi
    printf -- "%s\n" "$default"
  else
    declare "$name=$default"
    declare "$name=$(__stringUnquote "$value")"
    printf -- "%s\n" "${!name-}"
  fi
}
_environmentValueRead() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Convert an array value which was loaded already
# Argument: encodedValue - String. Required. Value to convert to tokens, one per line
# stdout: Array values separated by newlines
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
environmentValueConvertArray() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local value prefix='([0]="' suffix='")'

  value=$(__stringUnquote "${1-}")
  [ "$value" != "()" ] || return 0 # Empty array
  if [ "${value#*=}" != "$value" ]; then
    [ "${value#"$prefix"}" != "$value" ] || throwArgument "$handler" "Not an array value (prefix: \"${value:0:4}\")" || return $?
    [ "${value%"$suffix"}" != "$value" ] || throwArgument "$handler" "Not an array value (suffix)" || return $?
    declare -a "value=$value"
  else
    local n=$((${#value} - 1))
    if [ "${value:0:1}${value:0:1}${value:$n:1}" = "()" ]; then
      IFS=" " read -r -d'' -a value <<<"${value:1:$((n - 1))}"
    fi
  fi
  printf -- "%s\n" "${value[@]+"${value[@]}"}"
}
_environmentValueConvertArray() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Read an array value from a state file
# Argument: stateFile - File. Required. File to access, must exist.
# Argument: name - EnvironmentVariable. Required. Name to read.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Outputs array elements, one per line.
environmentValueReadArray() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local stateFile="${1-}" name value

  name=$(validate "$handler" EnvironmentVariable "name" "${2-}") || return $?
  value=$(catchReturn "$handler" environmentValueRead "$stateFile" "$name" "") || return $?
  environmentValueConvertArray "$value" || return $?
}
_environmentValueReadArray() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Example:     {fn} < "$stateFile"
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# List names of environment values set in a bash state file
environmentNames() {
  [ $# -eq 0 ] || helpArgument --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  environmentLines | cut -f 1 -d =
}
_environmentNames() {
  true || environmentNames --help
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Example:     {fn} < "$stateFile"
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# List lines of environment values set in a bash state file
environmentLines() {
  [ $# -eq 0 ] || helpArgument --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  grepSafe -e "^[A-Za-z][A-Z0-9_a-z]*="
}
_environmentLines() {
  true || environmentLines --help
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Safely load an environment from stdin (no code execution)
# Argument: --verbose - Flag. Optional. Output errors with variables.
# Argument: --debug - Flag. Optional. Debugging mode, for developers probably.
# Argument: --prefix - String. Optional. Prefix each environment variable defined with this string. e.g. `NAME` -> `DSN_NAME` for `--prefix DSN_`
# Argument: --context - String. Optional. Name of the context for debugging or error messages. (e.g. what is this doing for whom and why)
# Argument: --ignore environmentName - String. Optional. Environment value to ignore on load.
# Argument: --secure environmentName - String. Optional. If found, entire load fails.
# Argument: --secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the `--ignore` list.
# Argument: --execute arguments ... - Callable. Optional. All additional arguments are passed to callable after loading environment.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 2 - if file does not exist; outputs an error
# Return Code: 0 - if files are loaded successfully
environmentLoad() {
  local handler="_${FUNCNAME[0]}"

  local ff=() required=true ignoreList=() secureList=()
  local verboseMode=false debugMode=false hasOne=false execCommand=() variablePrefix="" context=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose)
      verboseMode=true
      ! $debugMode || printf -- "VERBOSE MODE on (Call: %s)\n" "$(decorate each code "${handler#_}" "${__saved[@]}")"
      ;;
    --debug)
      debugMode=true
      verboseMode=true
      statusMessage decorate info "Debug mode enabled"
      ;;
    --secure)
      shift
      secureList+=("$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --prefix)
      shift
      variablePrefix="$(validate "$handler" EnvironmentVariable "$argument" "${1-}")" || return $?
      ;;
    --secure-defaults)
      read -d "" -r -a secureList < <(environmentSecureVariables) || :
      ;;
    --ignore)
      shift
      ignoreList+=("$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --require)
      required=true
      ! $debugMode || printf -- "Current: %s\n" "$argument"
      ;;
    --optional)
      required=false
      ! $debugMode || printf -- "Current: %s\n" "$argument"
      ;;
    --context)
      shift
      context="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ! $debugMode || printf -- "Context: %s\n" "$context"
      ;;
    --execute)
      shift
      binary=$(validate "$handler" Callable "$argument" "${1-}") || return $?
      shift
      execCommand=("$binary" "$@")
      break
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local name value environmentLine toExport=() line=1

  while read -r environmentLine; do
    ! $debugMode || printf "%s:%d: %s" "$context" "$line" "$(decorate code "$environmentLine")"
    name="${environmentLine%%=*}"
    # Skip comments
    if [ -z "$name" ] || [ "$name" != "${name###}" ]; then
      continue
    fi
    name="$variablePrefix$name"
    # Skip "bad" variables
    if ! environmentVariableNameValid "$name"; then
      ! $verboseMode || decorate warning "$(decorate code "$name") invalid name ($context:$line)"
      continue
    fi
    # Skip insecure variables
    [ "${#secureList[@]}" -eq 0 ] || ! inArray "$name" "${secureList[@]}" || throwEnvironment "$handler" "${environmentFile} contains secure value $(decorate BOLD red "$name") [$(decorate each --count code "${secureList[@]}")]" || return $?
    # Ignore stuff as a feature
    if [ "${#ignoreList[@]}" -gt 0 ] && inArray "$name" "${ignoreList[@]}"; then
      ! $debugMode || decorate warning "$(decorate code "$name") is ignored ($context:$line)"
      continue
    fi
    # Load and stringUnquote value
    value="$(__stringUnquote "${environmentLine#*=}")"
    # SECURITY CHECK
    toExport+=("$name=$value")
    ! $debugMode || printf "toExport: %s=%s\n" "$name" "$value"
    line=$((line + 1))
  done

  if [ "${#toExport[@]}" -gt 0 ]; then
    for value in "${toExport[@]}"; do
      name=${value%%=*}
      value=${value#*=}
      # NAME must pass validation above
      ! $debugMode || printf "EXPORTING: %s=%s\n" "$name" "$value"
      export "${name?}"="$value"
    done
  fi

  if [ ${#execCommand[@]} -gt 0 ]; then
    ! $debugMode || printf "RUNNING: %s" "$*"
    catchEnvironment "$handler" "${execCommand[@]}" || return $?
  fi
}
_environmentLoad() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Safely load an environment file (no code execution)
# Argument: --prefix - EnvironmentVariable|Blank. Optional. All subsequent environment variables are prefixed with this prefix.
# Argument: --require - Flag. Optional. All subsequent environment files on the command line will be required.
# Argument: --optional - Flag. Optional. All subsequent environment files on the command line will be optional. (If they do not exist, no errors.)
# Argument: --verbose - Flag. Optional. Output errors with variables in files.
# Argument: environmentFile - Required. Environment file to load. For `--optional` files the directory must exist.
# Argument: --ignore environmentName - String. Optional. Environment value to ignore on load.
# Argument: --secure environmentName - String. Optional. If found in a loaded file, entire file fails.
# Argument: --secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the `--ignore` list.
# Argument: --execute arguments ... - Callable. Optional. All additional arguments are passed to callable after loading environment files.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 2 - if file does not exist; outputs an error
# Return Code: 0 - if files are loaded successfully
environmentFileLoad() {
  local handler="_${FUNCNAME[0]}"

  local ff=() environmentFile required=true
  local verboseMode=false debugMode=false hasOne=false execCommand=() variablePrefix="" ee=() pp=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose)
      verboseMode=true
      ee+=("$argument")
      ! $debugMode || printf -- "VERBOSE MODE on (Call: %s)\n" "$(decorate each code "${handler#_}" "${__saved[@]}")"
      ;;
    --debug)
      debugMode=true
      verboseMode=true
      ee+=("$argument")
      statusMessage decorate info "Debug mode enabled"
      ;;
    --secure-defaults)
      ee+=("$argument")
      ;;
    --ignore | --secure)
      shift
      ee+=("$argument" "${1-}")
      ;;
    --prefix)
      shift
      pp=("$argument" "${1-}")
      ;;
    --require)
      required=true
      ! $debugMode || printf -- "Current: %s\n" "$argument"
      ;;
    --optional)
      required=false
      ! $debugMode || printf -- "Current: %s\n" "$argument"
      ;;
    --execute)
      shift
      binary=$(validate "$handler" Callable "$argument" "${1-}") || return $?
      shift
      execCommand=("$binary" "$@")
      break
      ;;
    *)
      hasOne=true
      if $required; then
        ! $debugMode || printf -- "Loading required file: %s\n" "$argument"
        environmentFile="$(validate "$handler" File "environmentFile" "$argument")" || return $?
        ff+=("$environmentFile") || return $?
      else
        ! $verboseMode || statusMessage decorate info "Loading optional file: $(decorate file "$argument")"
        environmentFile=$(validate "$handler" FileDirectory "environmentFile" "$argument") || return $?
        if [ -f "$environmentFile" ]; then
          ff+=("$environmentFile")
        else
          ! $debugMode || printf -- "Optional file does not exist: %s\n" "$environmentFile"
        fi
      fi
      ;;
    esac
    shift
  done
  $hasOne || throwArgument "$handler" "Requires at least one environmentFile" || return $?

  # If all files are optional, do nothing
  [ "${#ff[@]}" -gt 0 ] || return 0

  ! $debugMode || printf -- "Files to actually load: %d %s\n" "${#ff[@]}" "${ff[*]}"
  for environmentFile in "${ff[@]}"; do
    ! $debugMode || printf "%s lines:\n%s\n" "$(decorate code "$environmentFile")" "$(environmentLines <"$environmentFile")"
    catchReturn "$handler" environmentLoad --context "$environmentFile" "${pp[@]+"${pp[@]}"}" "${ee[@]+"${ee[@]}"}" < <(environmentLines <"$environmentFile") || return $?
  done
  if [ ${#execCommand[@]} -gt 0 ]; then
    ! $debugMode || printf "RUNNING: %s" "${execCommand[*]}"
    catchEnvironment "$handler" "${execCommand[@]}" || return $?
  fi
}
_environmentFileLoad() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
