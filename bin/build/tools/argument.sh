#!/usr/bin/env bash
#
# Argument
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# WIP 2024-07-15
# Idea is to have a central argument manager
# Which uses the comments to specify the arguments automatically

# Generic argument parsing using Bash comments.
#
# Argument formatting (in comments) is as follows:
#
#     Argument: argumentName [ variable ... ] - [ Optional | Required ]. argumentType. Description.`
#
# `...` token means one or more arguments may be passed.
#
# `argumentType` is one of:
#
# - File FileDirectory Directory LoadEnvironmentFile RealDirectory
# - EmptyString String
# - Boolean PositiveInteger Integer UnsignedInteger Number
# - Executable Callable Function
# - URL
#
# And uses the associated `usageArgument` function for validation.
# Usage: {fn} this source [ --none ] [ arguments ... ]
# Argument: this - Required. Function. Function to collect arguments for. Assume usage function is "_$this".
# Argument: source - Required. File. File of the function to collect the specification.
# Argument: --none - Flag. Optional. If specified, state file is deleted prior to return regardless of handling.
# Argument: arguments - Optional. String. One or more arguments to parse.
# Output is a temporary `stateFile` on line 1
_arguments() {
  local usageArguments="_${FUNCNAME[0]}"
  local source="${1-}" this="${2-}"
  local usage="_$this"

  local stateFile checkFunction value clean required flags=() noneFlag=false

  ARGUMENTS="${ARGUMENTS-}"
  shift || __throwArgument "$usageArguments" "Missing this" || return $?
  shift || __throwArgument "$usageArguments" "Missing source" || return $?
  if [ "${1-}" = "--none" ]; then
    shift
    noneFlag=true
  fi
  stateFile=$(__catchEnvironment "$usageArguments" mktemp) || return $?
  spec=$(__catchEnvironment "$usageArguments" _commentArgumentSpecification "$source" "$this") || return $?
  __catchEnvironment "$usageArguments" _commentArgumentSpecificationDefaults "$spec" >"$stateFile" || return $?
  IFS=$'\n' read -d '' -r -a required <"$(__commentArgumentSpecification__required "$spec")" || :

  # Rest is calling function argument usage
  clean=("$stateFile")
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    type="$(_commentArgumentType "$spec" "$stateFile" "$__index" "$argument")" || _clean "$?" "${clean[@]}" || return $?
    case "$type" in
      Flag)
        argumentName="$(_commentArgumentName "$spec" "$stateFile" "$__index" "$argument")" || _clean "$?" "${clean[@]}" || return $?
        __catchEnvironment "$usage" environmentValueWrite "$argumentName" "true" >>"$stateFile" || _clean "$?" "${clean[@]}" || return $?
        if ! inArray "$argumentName" "${flags[@]+"${flags[@]}"}"; then
          flags+=("$argumentName")
        fi
        ;;
      -)
        break
        ;;
      *)
        if _commentArgumentTypeValid "${type#!}"; then
          type="${type#!}"
          argumentName="$(_commentArgumentName "$spec" "$stateFile" "$__index" "$argument")" || _clean "$?" "${clean[@]}" || return $?
        elif _commentArgumentTypeValid "$type"; then
          argumentName="$(_commentArgumentName "$spec" "$stateFile" "$__index" "$argument")" || _clean "$?" "${clean[@]}" || return $?
          shift
          argument="${1-}"
        else
          find "$spec" -type f 1>&2
          dumpPipe stateFile <"$stateFile" 1>&2
          __throwArgument "$usage" "unhandled argument type \"$type\" #$__index: $argument" || _clean "$?" "${clean[@]}" || return $?
        fi
        checkFunction="usageArgument${type}"
        value="$("$checkFunction" "$usage" "$argumentName" "$argument")" || _clean "$?" || return $?
        __catchEnvironment "$usage" environmentValueWrite "$argumentName" "$value" >>"$stateFile" || _clean "$?" || return $?
        ;;
    esac
    shift || __throwArgument "$usage" "missing argument #$__index: $argument" || _clean "$?" "${clean[@]}" || return $?
  done
  stateFile=$(_commentArgumentsRemainder "$usage" "$spec" "$stateFile" "$@") || _clean "$?" "${clean[@]}" || return $?

  if inArray "help" "${flags[@]+"${flags[@]}"}"; then
    # Have to do this as this is run in subprocess - what to do?
    "$usage" 0
    rm -rf "${clean[@]}" || :
    return "$(_code exit)"
  fi
  if $noneFlag; then
    __catchEnvironment "$usageArguments" rm -rf "$stateFile" || return $?
    unset ARGUMENTS || return $?
    return 0
  fi
  if [ "${#flags[@]}" -gt 0 ]; then
    __catchEnvironment "$usage" environmentValueWrite "_flags" "${flags[@]}" >>"$stateFile" || return $?
  fi
  ARGUMENTS="$stateFile" || return $?
}
__arguments() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Handle `exit` -> 0
_argumentReturn() {
  local exitCode="$1"
  [ "$exitCode" -ne "$(_code exit)" ] || exitCode=0
  printf "%d\n" "$exitCode"
}

# Validate spec directory
__commentArgumentSpecificationMagic() {
  local usage="${1-}" specificationDirectory="${2-}"
  local magicFile="$specificationDirectory/.magic"
  if test "${3-}"; then
    __catchEnvironment "$usage" touch "$magicFile" || return $?
  else
    [ -f "$magicFile" ] || __throwEnvironment "$usage" "$specificationDirectory is not magic" || return $?
  fi
}

#
# Generate a specification file for arguments
# Argument: functionDefinitionFile - Required. File. Source file where the function is defined.
# Argument: functionName - Required. String. Function to fetch the specification for.
# Outputs the specification "id" to be used for future calls
# Spec outputs a directory:
# .arguments/functionName/
# .arguments/functionName/documentation
# .arguments/functionName/defaults
# .arguments/functionName/required
# .arguments/functionName/parsed/--help
# .arguments/functionName/parsed/-c
# .arguments/functionName/parsed/--workspace
# .arguments/functionName/parsed/0
# .arguments/functionName/parsed/1
# .arguments/functionName/parsed/2
# .arguments/functionName/.magic
#
_commentArgumentSpecification() {
  local usage="_${FUNCNAME[0]}"
  local functionDefinitionFile="${1-}" functionName="${2-}"
  local functionCache cacheFile argumentIndex argumentDirectory argumentLine

  functionCache=$(__catchEnvironment "$usage" buildCacheDirectory "ARGUMENTS") || return $?
  functionCache="$functionCache/$functionName"

  cacheFile="$functionCache/documentation"
  argumentDirectory=$(__catchEnvironment "$usage" requireDirectory "$functionCache/parsed") || return $?
  __catchEnvironment "$usage" touch "$functionCache/.magic" || return $?
  if [ ! -f "$functionDefinitionFile" ] && ! isAbsolutePath "$functionDefinitionFile"; then
    local home
    home=$(__catchEnvironment "$usage" buildHome) || return $?
    if [ -f "$home/$functionDefinitionFile" ]; then
      functionDefinitionFile="$home/$functionDefinitionFile"
    fi
  fi
  [ -f "$functionDefinitionFile" ] || __throwArgument "$usage" "$functionDefinitionFile does not exist" || return $?
  [ -n "$functionName" ] || __throwArgument "$usage" "functionName is blank" || return $?
  if [ ! -f "$cacheFile" ] || [ "$(newestFile "$cacheFile" "$functionDefinitionFile")" = "$functionDefinitionFile" ]; then
    __catchEnvironment "$usage" bashDocumentation_Extract "$functionDefinitionFile" "$functionName" >"$cacheFile"
    for file in "$(__commentArgumentSpecification__required "$functionCache")" "$(__commentArgumentSpecification__defaults "$functionCache")"; do
      __catchEnvironment "$usage" printf "" >"$file" || return $?
    done
  fi
  argumentsFile="$functionCache/arguments"
  if [ ! -f "$argumentsFile" ] || [ "$(newestFile "$cacheFile" "$argumentsFile")" = "$cacheFile" ]; then
    (
      local argument
      argument=
      # shellcheck source=/dev/null
      source "$cacheFile"
      printf "%s\n" "$argument" >"$argumentsFile"
      rm -rf "${argumentDirectory:?}/*" || :
    ) || __throwEnvironment "$usage" "Loading $cacheFile" || return $?
  fi
  if [ ! -f "$argumentDirectory/@" ]; then
    argumentId=1
    while read -r -a argumentLine; do
      __catchEnvironment "$usage" _commentArgumentSpecificationParseLine "$functionCache" "$argumentId" "${argumentLine[@]+"${argumentLine[@]}"}" || return $?
      argumentId=$((argumentId + 1))
    done <"$argumentsFile"
    __catchEnvironment "$usage" date >"$argumentDirectory/@" || return $?
    __commentArgumentSpecificationMagic "$usage" "$functionCache" 1
  fi
  printf "%s\n" "$functionCache"
}
__commentArgumentSpecification() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__commentArgumentSpecification__defaults() {
  printf "%s/%s\n" "$1" "defaults"
}

__commentArgumentSpecification__required() {
  printf "%s/%s\n" "$1" "required"
}

# Argument: specification - Required. String.
_commentArgumentSpecificationDefaults() {
  local usage="_${FUNCNAME[0]}"
  local specification="${1-}"

  __commentArgumentSpecificationMagic "$usage" "$specification" || return $?
  file=$(__commentArgumentSpecification__defaults "$specification")
  if [ -f "$file" ]; then
    cat "$file"
  else
    printf "%s\n" "# No defaults"
  fi
}
__commentArgumentSpecificationDefaults() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: argumentDirectory - Required. Directory. Directory where the arguments structure is stored.
# Argument: argumentId - Required. Integer. This argument ID.
# Output: nothing
_commentArgumentSpecificationParseLine() {
  local functionCache="${1-}" argumentId="${2-}"
  local argumentDirectory="${functionCache%/}/parsed"
  local argument file
  local required saveRequired argumentIndex="" argumentType argumentName argumentFinder argumentRepeat=false argumentDefault=""
  local argumentRemainder=false

  [ -d "$argumentDirectory" ] || _argument "$argumentDirectory is not a directory" || return $?
  isUnsignedInteger "$argumentId" || _argument "$argumentId is not an integer" || return $?
  shift 2

  argumentName=
  savedLine="$(_command "$@")"
  while [ "$#" -gt 0 ]; do
    argument="$1"
    case "$argument" in
      --* | -[[:alpha:]]*)
        argumentIndex=
        argumentFinder="$argument"
        argumentName="${argument#-}"
        argumentName="${argumentName#-}"
        if [ "${argumentName%...}" != "${argumentName}" ]; then
          argumentRepeat=true
          argumentName="${argumentName%...}"
        fi
        ;;
      ...)
        if [ -z "$argumentName" ]; then
          argumentRemainder=true
        else
          argumentRepeat=true
        fi
        ;;
      -)
        shift
        break
        ;;
      *)
        if [ -f "$argumentDirectory/index" ]; then
          argumentIndex=$(($(head -n 1 "$argumentDirectory/index") + 1))
        else
          argumentIndex=0
        fi
        argumentFinder="#--$argumentIndex"
        printf "%d\n" "$argumentIndex" >"$argumentDirectory/index"
        argumentName="$argument"
        ;;
    esac
    shift
  done
  # Blank line
  [ $# -eq 0 ] && return 0
  [ $# -ge 1 ] || _argument "$argumentId missing type: $savedLine" || return $?
  saveRequired="${1%.}"
  shift || :
  required=
  if required=$(_commentArgumentParseRequired "$saveRequired"); then
    case "$required" in required) required=true ;; *) required=false ;; esac
  fi
  argumentType="${1%.}"
  if [ -z "$required" ] && ! _commentArgumentTypeValid "$argumentType"; then
    if _commentArgumentTypeValid "$saveRequired"; then
      argumentType=$saveRequired
      required=false
    else
      _argument "Invalid argument type: \"$argumentType\" (Required was \"$saveRequired\")" || return $?
    fi
  else
    shift || :
  fi
  description="$*"
  if ! $argumentRemainder || [ -n "$argumentName" ]; then
    for argument in argumentType argumentName argumentFinder; do
      [ -n "${!argument}" ] || _argument "Require a value for $argument in line: $savedLine" || return $?
    done
    {
      environmentValueWrite argumentName "$argumentName"
      environmentValueWrite argumentRepeat "$argumentRepeat"
      environmentValueWrite argumentType "$argumentType"
      environmentValueWrite argumentId "$argumentIndex"
      environmentValueWrite argumentRequired "$required"
      environmentValueWrite argumentFinder "$argumentFinder"
      environmentValueWrite description "$description"
    } >"$argumentDirectory/$argumentFinder" || _argument "Unable to write $argumentDirectory/$argumentFinder" || return $?
    if $required; then
      __environment printf "%s\n" "$argumentName" >>"$(__commentArgumentSpecification__required "$functionCache")" || return $?
    fi
    if inArray "$argumentType" "Boolean" "Flag"; then
      argumentDefault=false
    fi
    if [ -n "$argumentDefault" ]; then
      __environment environmentValueWrite "$argumentName" "$argumentDefault" >>"$(__commentArgumentSpecification__defaults "$functionCache")" || return $?
    fi
  fi
  if $argumentRemainder; then
    printf "%s\n" true >"$functionCache/remainder"
  fi
}
__commentArgumentSpecificationParseLine() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: text - Optional. String. Text to test
# If starts with "req" then prints "required"
# If starts with "opt" then prints "optional"
# Otherwise fails with return code 1
_commentArgumentParseRequired() {
  local text
  text="$(lowercase "${1-}")"
  if [ "${text#req}" != "$text" ]; then
    printf "%s\n" "required"
  elif [ "${text#opt}" != "$text" ]; then
    printf "%s\n" "optional"
  else
    return 1
  fi
}

# Is the argument type valid?
_commentArgumentTypeValid() {
  local type="${1-}"
  case "$type" in
    # File system
    File | FileDirectory | Directory | LoadEnvironmentFile | RealDirectory)
      return 0
      ;;
    # Strings
    EmptyString | String | EnvironmentVariable)
      return 0
      ;;
    # Types
    Boolean | PositiveInteger | Integer | UnsignedInteger | Number)
      return 0
      ;;
    # Functional
    Executable | Callable | Function)
      return 0
      ;;
    # Internet
    URL)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

# Usage: specification argumentIndex argumentValue
# Argument: specification - Required. File.
# Argument: stateFile - Required. File.
# Argument: argumentIndex - Required. Integer.
# Argument: argumentValue - Optional. String.
_commentArgumentName() {
  local usage="_${FUNCNAME[0]}"
  local specification="${1-}" stateFile="${2-}" argumentIndex="${3-}" argumentValue="${4-}" argumentNamed

  __commentArgumentSpecificationMagic "$usage" "$specification" || return $?
  specification="$specification/parsed"
  if [ -f "$specification/$argumentValue" ]; then
    environmentValueRead "$specification/$argumentValue" argumentName not-named
    return 0
  fi
  argumentNamed="$(environmentValueRead "$stateFile" argumentNamed "")"
  if [ -z "$argumentNamed" ]; then
    _environment "No current argument" || return $?
  fi
  if isUnsignedInteger "$argumentNamed"; then
    environmentValueRead "$specification/#--$argumentNamed" argumentName not-named
  fi
  return 0
}
___commentArgumentName() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_commentArgumentTypeFromSpec() {
  local usage="$1" specification="$2" argumentType argumentRepeat="${4-}"

  argumentType=$(__catchEnvironment "$usage" environmentValueRead "$specification" argumentType undefined)
  [ -n "$argumentRepeat" ] || argumentRepeat=$(__catchEnvironment "$usage" environmentValueRead "$specification" argumentRepeat false)
  __catchEnvironment "$usage" printf "%s%s%s" "$3" "$argumentType" "$(_choose "$argumentRepeat" '*' '')" || return $?
}

# Argument: specification - Required. String.
# Argument: stateFile - Required. File.
# Argument: argumentIndex - Required. Integer.
# Argument: argumentValue - Optional. String.
_commentArgumentType() {
  local usage="_${FUNCNAME[0]}"
  local specification="${1-}" stateFile="${2-}" argumentIndex="${3-}" argumentValue="${4-}"
  local argumentNamed argumentRepeat argumentSpec

  __commentArgumentSpecificationMagic "$usage" "$specification" || return $?
  specification="$specification/parsed"
  argumentSpec="$specification/$argumentValue"
  if [ -f "$argumentSpec" ]; then
    _commentArgumentTypeFromSpec "$usage" "$argumentSpec" "" || return $?
    return 0
  fi
  argumentNamed="$(environmentValueRead "$stateFile" argumentNamed "")"
  argumentRepeatName="$(environmentValueRead "$stateFile" argumentRepeatName false)"
  if [ -z "$argumentNamed" ]; then
    argumentNamed=0
  elif [ "$argumentRepeatName" != "$argumentNamed" ]; then
    argumentNamed=$((argumentNamed + 1))
  fi
  argumentSpec="$specification/#--$argumentNamed"
  if [ ! -f "$argumentSpec" ]; then
    printf -- "%s" "-"
    return 0
  fi
  environmentValueWrite argumentNamed "$argumentNamed" >>"$stateFile"
  if [ -z "$argumentRepeatName" ]; then
    argumentRepeat="$(environmentValueRead "$argumentSpec" argumentRepeat false)"
    isBoolean "$argumentRepeat" || __throwEnvironment "$usage" "$argumentSpec non-boolean argumentRepeat" || return $?
    if $argumentRepeat; then
      {
        __catchEnvironment "$usage" environmentValueWrite argumentRepeatName "$argumentNamed"
      } >>"$stateFile" || return $?
    fi
  fi
  _commentArgumentTypeFromSpec "$usage" "$argumentSpec" "!" "$argumentRepeat" || return $?
  return 0
}
__commentArgumentType() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: specification - Required. String.
# Argument: stateFile - Required. File.
# Argument: ... - Optional. String. One or more
_commentArgumentsRemainder() {
  local usage="$1" specification="$2" stateFile="$3" name value

  shift && shift && shift
  __commentArgumentSpecificationMagic "$usage" "$specification" || return $?
  while read -d '' -r name; do
    value="$(__catchEnvironment "$usage" environmentValueRead "$stateFile" "$name" "")"
    if [ -z "$value" ]; then
      __throwArgument "$usage" "$name is required" || return $?
    fi
  done <"$(__commentArgumentSpecification__required "$specification")"
  if [ $# -gt 0 ]; then
    if [ -f "$specification/remainder" ]; then
      __catchEnvironment "$usage" environmentValueWrite _remainder "$@" >>"$stateFile" || return $?
    else
      __throwArgument "$usage" "Unknown arguments $#: $(_command "$@")" || return $?
    fi
  fi
  printf "%s\n" "$stateFile" "$@"
}

# IDENTICAL __help 30
# Usage: {fn} [ --only ] usageFunction arguments
# Simple help argument handler.
#
# Easy `--help` handler for any function useful when it's the only option.
#
# Useful for utilities which single argument types, single arguments, and no arguments (except for `--help`)
#
# Oddly one of the few functions we can not offer the `--help` flag for.
#
# Argument: --only - Flag. Optional. Must be first parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
# Example:     __help "_${FUNCNAME[0]}" "$@" || return 0
# Example:     __help "$usage" "$@" || return 0
# Example:     [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ $# -eq 0 ] || __help --only "$usage" "$@" || return 0
# Depends: __throwArgument
__help() {
  local usage="${1-}" && shift
  if [ "$usage" = "--only" ]; then
    usage="${1-}" && shift
    [ "$#" -eq 1 ] && [ "$1" = "--help" ] || __throwArgument "$usage" "Only argument allowed is \`--help\`" || return $?
  fi
  while [ $# -gt 0 ]; do
    if [ "$1" = "--help" ]; then
      "$usage" 0
      return 1
    fi
    shift
  done
  return 0
}
