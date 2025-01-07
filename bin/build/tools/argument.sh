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
  local argument nArguments argumentIndex
  local stateFile checkFunction value clean required flags=() noneFlag=false

  ARGUMENTS="${ARGUMENTS-}"
  shift || __failArgument "$usageArguments" "Missing this" || return $?
  shift || __failArgument "$usageArguments" "Missing source" || return $?
  if [ "${1-}" = "--none" ]; then
    shift
    noneFlag=true
  fi
  stateFile=$(__usageEnvironment "$usageArguments" mktemp) || return $?
  spec=$(__usageEnvironment "$usageArguments" _usageArgumentsSpecification "$source" "$this") || return $?
  __usageEnvironment "$usageArguments" _usageArgumentsSpecificationDefaults "$spec" >"$stateFile" || return $?
  IFS=$'\n' read -d '' -r -a required <"$(__usageArgumentsSpecification__required "$spec")" || :

  # Rest is calling function argument usage
  clean=("$stateFile")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$1"
    type="$(_usageArgumentType "$spec" "$stateFile" "$argumentIndex" "$argument")" || _clean "$?" "${clean[@]}" || return $?
    case "$type" in
      Flag)
        argumentName="$(_usageArgumentName "$spec" "$stateFile" "$argumentIndex" "$argument")" || _clean "$?" "${clean[@]}" || return $?
        __usageEnvironment "$usage" environmentValueWrite "$argumentName" "true" >>"$stateFile" || _clean "$?" "${clean[@]}" || return $?
        if ! inArray "$argumentName" "${flags[@]+"${flags[@]}"}"; then
          flags+=("$argumentName")
        fi
        ;;
      -)
        break
        ;;
      *)
        if _usageArgumentTypeValid "${type#!}"; then
          type="${type#!}"
          argumentName="$(_usageArgumentName "$spec" "$stateFile" "$argumentIndex" "$argument")" || _clean "$?" "${clean[@]}" || return $?
        elif _usageArgumentTypeValid "$type"; then
          argumentName="$(_usageArgumentName "$spec" "$stateFile" "$argumentIndex" "$argument")" || _clean "$?" "${clean[@]}" || return $?
          shift
          argument="${1-}"
        else
          find "$spec" -type f 1>&2
          dumpPipe stateFile <"$stateFile" 1>&2
          __failArgument "$usage" "unhandled argument type \"$type\" #$argumentIndex: $argument" || _clean "$?" "${clean[@]}" || return $?
        fi
        checkFunction="usageArgument${type}"
        value="$("$checkFunction" "$usage" "$argumentName" "$argument")" || _clean "$?" || return $?
        __usageEnvironment "$usage" environmentValueWrite "$argumentName" "$value" >>"$stateFile" || _clean "$?" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || _clean "$?" "${clean[@]}" || return $?
  done
  stateFile=$(_usageArgumentsRemainder "$usage" "$spec" "$stateFile" "$@") || _clean "$?" "${clean[@]}" || return $?

  if inArray "help" "${flags[@]+"${flags[@]}"}"; then
    # Have to do this as this is run in subprocess - what to do?
    "$usage" 0
    rm -rf "${clean[@]}" || :
    return "$(_code exit)"
  fi
  if $noneFlag; then
    __usageEnvironment "$usageArguments" rm -rf "$stateFile" || return $?
    unset ARGUMENTS || return $?
    return 0
  fi
  if [ "${#flags[@]}" -gt 0 ]; then
    __usageEnvironment "$usage" environmentValueWrite "_flags" "${flags[@]}" >>"$stateFile" || return $?
  fi
  ARGUMENTS="$stateFile" || return $?
}
__arguments() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Handle `exit` -> 0
_argumentReturn() {
  local exitCode="$1"
  [ "$exitCode" -ne "$(_code exit)" ] || exitCode=0
  printf "%d\n" "$exitCode"
}

# Validate spec directory
__usageArgumentSpecificationMagic() {
  local usage="${1-}" specificationDirectory="${2-}"
  local magicFile="$specificationDirectory/.magic"
  if test "${3-}"; then
    __usageEnvironment "$usage" touch "$magicFile" || return $?
  else
    [ -f "$magicFile" ] || __failEnvironment "$usage" "$specificationDirectory is not magic" || return $?
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
_usageArgumentsSpecification() {
  local usage="_${FUNCNAME[0]}"
  local functionDefinitionFile="${1-}" functionName="${2-}"
  local functionCache cacheFile argumentIndex argumentDirectory argumentLine

  functionCache=$(__usageEnvironment "$usage" buildCacheDirectory "ARGUMENTS") || return $?
  functionCache="$functionCache/$functionName"

  cacheFile="$functionCache/documentation"
  argumentDirectory=$(__usageEnvironment "$usage" requireDirectory "$functionCache/parsed") || return $?
  __usageEnvironment "$usage" touch "$functionCache/.magic" || return $?
  [ -f "$functionDefinitionFile" ] || __failArgument "$usage" "$functionDefinitionFile does not exist" || return $?
  [ -n "$functionName" ] || __failArgument "$usage" "functionName is blank" || return $?
  if [ ! -f "$cacheFile" ] || [ "$(newestFile "$cacheFile" "$functionDefinitionFile")" = "$functionDefinitionFile" ]; then
    __usageEnvironment "$usage" bashDocumentation_Extract "$functionDefinitionFile" "$functionName" >"$cacheFile"
    for file in "$(__usageArgumentsSpecification__required "$functionCache")" "$(__usageArgumentsSpecification__defaults "$functionCache")"; do
      __usageEnvironment "$usage" printf "" >"$file" || return $?
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
    ) || __failEnvironment "$usage" "Loading $cacheFile" || return $?
  fi
  if [ ! -f "$argumentDirectory/@" ]; then
    argumentId=1
    while read -r -a argumentLine; do
      __usageEnvironment "$usage" _usageArgumentsSpecificationParseLine "$functionCache" "$argumentId" "${argumentLine[@]+"${argumentLine[@]}"}" || return $?
      argumentId=$((argumentId + 1))
    done <"$argumentsFile"
    __usageEnvironment "$usage" date >"$argumentDirectory/@" || return $?
    __usageArgumentSpecificationMagic "$usage" "$functionCache" 1
  fi
  printf "%s\n" "$functionCache"
}
__usageArgumentsSpecification() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__usageArgumentsSpecification__defaults() {
  printf "%s/%s\n" "$1" "defaults"
}

__usageArgumentsSpecification__required() {
  printf "%s/%s\n" "$1" "required"
}

# Argument: specification - Required. String.
_usageArgumentsSpecificationDefaults() {
  local usage="_${FUNCNAME[0]}"
  local specification="${1-}"

  __usageArgumentSpecificationMagic "$usage" "$specification" || return $?
  file=$(__usageArgumentsSpecification__defaults "$specification")
  if [ -f "$file" ]; then
    cat "$file"
  else
    printf "%s\n" "# No defaults"
  fi
}
__usageArgumentsSpecificationDefaults() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: argumentDirectory - Required. Directory. Directory where the arguments structure is stored.
# Argument: argumentId - Required. Integer. This argument ID.
# Output: nothing
_usageArgumentsSpecificationParseLine() {
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
  if required=$(_usageArgumentParseRequired "$saveRequired"); then
    case "$required" in required) required=true ;; *) required=false ;; esac
  fi
  argumentType="${1%.}"
  if [ -z "$required" ] && ! _usageArgumentTypeValid "$argumentType"; then
    if _usageArgumentTypeValid "$saveRequired"; then
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
      __environment printf "%s\n" "$argumentName" >>"$(__usageArgumentsSpecification__required "$functionCache")" || return $?
    fi
    if inArray "$argumentType" "Boolean" "Flag"; then
      argumentDefault=false
    fi
    if [ -n "$argumentDefault" ]; then
      __environment environmentValueWrite "$argumentName" "$argumentDefault" >>"$(__usageArgumentsSpecification__defaults "$functionCache")" || return $?
    fi
  fi
  if $argumentRemainder; then
    printf "%s\n" true >"$functionCache/remainder"
  fi
}
__usageArgumentsSpecificationParseLine() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: text - Optional. String. Text to test
# If starts with "req" then prints "required"
# If starts with "opt" then prints "optional"
# Otherwise fails with return code 1
_usageArgumentParseRequired() {
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
_usageArgumentTypeValid() {
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
_usageArgumentName() {
  local usage="_${FUNCNAME[0]}"
  local specification="${1-}" stateFile="${2-}" argumentIndex="${3-}" argumentValue="${4-}" argumentNamed

  __usageArgumentSpecificationMagic "$usage" "$specification" || return $?
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
__usageArgumentName() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__usageArgumentTypeFromSpec() {
  local usage="$1" specification="$2" argumentType argumentRepeat="${4-}"

  argumentType=$(__usageEnvironment "$usage" environmentValueRead "$specification" argumentType undefined)
  [ -n "$argumentRepeat" ] || argumentRepeat=$(__usageEnvironment "$usage" environmentValueRead "$specification" argumentRepeat false)
  __usageEnvironment "$usage" printf "%s%s%s" "$3" "$argumentType" "$(_choose "$argumentRepeat" '*' '')" || return $?
}

# Argument: specification - Required. String.
# Argument: stateFile - Required. File.
# Argument: argumentIndex - Required. Integer.
# Argument: argumentValue - Optional. String.
_usageArgumentType() {
  local usage="_${FUNCNAME[0]}"
  local specification="${1-}" stateFile="${2-}" argumentIndex="${3-}" argumentValue="${4-}"
  local argumentNamed argumentRepeat argumentSpec

  __usageArgumentSpecificationMagic "$usage" "$specification" || return $?
  specification="$specification/parsed"
  argumentSpec="$specification/$argumentValue"
  if [ -f "$argumentSpec" ]; then
    __usageArgumentTypeFromSpec "$usage" "$argumentSpec" "" || return $?
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
    isBoolean "$argumentRepeat" || __failEnvironment "$usage" "$argumentSpec non-boolean argumentRepeat" || return $?
    if $argumentRepeat; then
      {
        __usageEnvironment "$usage" environmentValueWrite argumentRepeatName "$argumentNamed"
      } >>"$stateFile" || return $?
    fi
  fi
  __usageArgumentTypeFromSpec "$usage" "$argumentSpec" "!" "$argumentRepeat" || return $?
  return 0
}
__usageArgumentType() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: specification - Required. String.
# Argument: stateFile - Required. File.
# Argument: ... - Optional. String. One or more
_usageArgumentsRemainder() {
  local usage="$1" specification="$2" stateFile="$3" name value

  shift && shift && shift
  __usageArgumentSpecificationMagic "$usage" "$specification" || return $?
  while read -d '' -r name; do
    value="$(__usageEnvironment "$usage" environmentValueRead "$stateFile" "$name" "")"
    if [ -z "$value" ]; then
      __failArgument "$usage" "$name is required" || return $?
    fi
  done <"$(__usageArgumentsSpecification__required "$specification")"
  if [ $# -gt 0 ]; then
    if [ -f "$specification/remainder" ]; then
      __usageEnvironment "$usage" environmentValueWrite _remainder "$@" >>"$stateFile" || return $?
    else
      __failArgument "$usage" "Unknown arguments $#: $(_command "$@")" || return $?
    fi
  fi
  printf "%s\n" "$stateFile" "$@"
}
