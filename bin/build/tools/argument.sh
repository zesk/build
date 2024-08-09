#!/usr/bin/env bash
#
# Argument
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# WIP 2024-07-15
# Idea is to have a central argument manager
# Which uses the comments to specify the arguments automatically

# Generic argument parsing
#
# Argument formatting is as follows:
#
#     # Argument: flag [ variable ... ] - [ Optional | Required ] . type. Description.
#
# Usage:
# Argument: this - Required. Function. Function to collect arguments for. Assume usage function is "_$this".
# Argument: source - Required. File. File of the function to collect the specification.
# Argument: arguments - Optional. String. One or more arguments to parse.
# Output is a temporary `stateFile` on line 1
#
# Type is one of:
#
# - File FileDirectory Directory LoadEnvironmentFile RealDirectory
# - EmptyString String
# - Boolean PositiveInteger Integer UnsignedInteger Number
# - Executable Callable Function
# - URL
#
# And uses the associated `usageArgument` function for validation.
#
_arguments() {
  local usageArguments="_${FUNCNAME[0]}"
  local source="${1-}" this="${2-}"
  local usage="_$this"
  local helpFlag=false
  local argument nArguments argumentIndex
  local stateFile checkFunction value clean required

  shift || __failArgument "$usageArguments" "Missing this" || return $?
  shift || __failArgument "$usageArguments" "Missing source" || return $?
  stateFile=$(__usageEnvironment "$usageArguments" mktemp) || return $?
  spec=$(__usageEnvironment "$usageArguments" _usageArgumentsSpecification "$source" "$this") || return $?
  __usageEnvironment "$usageArguments" _usageArgumentsSpecificationDefaults "$spec" >"$stateFile" || return $?
  IFS=$'\n' read -d '' -r -a required <"$(__usageArgumentsSpecification__required "$spec")"

  # Rest is calling function argument usage
  clean=("$stateFile")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || _clean "$?" "${clean[@]}" || return $?
    case "$argument" in
      # Not same as other --help
      --help)
        helpFlag=true
        ;;
      Flag)
        argumentName="$(_usageArgumentName "$spec" "$argumentIndex" "$argument")"
        __usageEnvironment "$usage" environmentValueWrite "$argumentName" "true" >>"$stateFile"
        ;;
      *)
        type="$(_usageArgumentType "$spec" "$stateFile" "$argumentIndex" "$argument")" || return $?
        if [ "$type" = "--" ]; then
          break
        elif _usageArgumentTypeValid "${type#!}"; then
          type="${type#!}"
        elif _usageArgumentTypeValid "$type"; then
          shift
        else
          find "$spec" -type f 1>&2
          dumpPipe stateFile <"$stateFile" 1>&2
          __failArgument "$usage" "unhandled argument type $type #$argumentIndex: $argument" || return $?
        fi
        checkFunction="usageArgument${argument}"
        value="$("$checkFunction" "$usage" "$argumentName" "${1-}")" || _clean "$?" || return $?
        __usageEnvironment "$usage" environmentValueWrite "$argumentName" "$value" >>"$stateFile" || _clean "$?" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done
  _usageArgumentsRemainder "$spec" "$stateFile" "$@" || return $?
  if $helpFlag; then
    # Have to do this as this is run in subprocess - what to do?
    "$usage" 0 1>&2
    _clean "$?" "${clean[@]}"
    return "$(_code exit)"
  fi
  printf "%s\n" "$stateFile"
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
_usageArgumentsSpecification() {
  local usage="_${FUNCNAME[0]}"
  local functionDefinitionFile="${1-}" functionName="${2-}"
  local cacheDirectory cacheFile argumentIndex argumentDirectory argumentLine

  cacheDirectory=$(__usageEnvironment "$usage" buildCacheDirectory ".arguments") || return $?
  cacheDirectory="$cacheDirectory/$functionName"
  cacheFile="$cacheDirectory/documentation"
  argumentDirectory=$(__usageEnvironment "$usage" requireDirectory "$cacheDirectory/parsed") || return $?
  __usageEnvironment "$usage" touch "$cacheDirectory/.magic" || return $?
  [ -f "$functionDefinitionFile" ] || __failArgument "$usage" "$functionDefinitionFile does not exist" || return $?
  [ -n "$functionName" ] || __failArgument "$usage" "functionName is blank" || return $?
  if [ ! -f "$cacheFile" ] || [ "$(newestFile "$cacheFile" "$functionDefinitionFile")" = "$functionDefinitionFile" ]; then
    __usageEnvironment "$usage" bashDocumentation_Extract "$functionDefinitionFile" "$functionName" >"$cacheFile"
  fi
  argumentsFile="$cacheDirectory/arguments"
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
      __usageEnvironment "$usage" _usageArgumentsSpecificationParseLine "$argumentDirectory" "$argumentId" "${argumentLine[@]+"${argumentLine[@]}"}" || return $?
      argumentId=$((argumentId + 1))
    done <"$argumentsFile"
    __usageEnvironment "$usage" date >"$argumentDirectory/@" || return $?
    __usageArgumentSpecificationMagic "$usage" "$cacheDirectory" 1
  fi
  printf "%s\n" "$cacheDirectory"
}
__usageArgumentsSpecification() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__usageArgumentsSpecification__defaults() {
  printf "%s/%s\n" "$1" "._defaults"
}

__usageArgumentsSpecification__required() {
  printf "%s/%s\n" "$1" "._required"
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
  local argumentDirectory="${1-}" argumentId="${2-}"
  local argument file
  local required saveRequired argumentIndex argumentType argumentName argumentFinder argumentRepeat

  [ -d "$argumentDirectory" ] || _argument "$argumentDirectory is not a directory" || return $?
  _integer "$argumentId" || _argument "$argumentId is not an integer" || return $?
  shift 2

  savedLine="$*"
  argumentIndex=
  argumentRepeat=false
  while [ "$#" -gt 0 ]; do
    argument="$1"
    case "$argument" in
      --* | -[[:alpha:]]*)
        argumentFinder="$argument"
        argumentName="${argument#-}"
        argumentName="${argumentName#-}"
        if [ "${argumentName%...}" != "${argumentName}" ]; then
          argumentRepeat=true
          argumentName="${argumentName%...}"
        fi
        ;;
      ...)
        argumentRepeat=true
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
  file=$(__usageArgumentsSpecification__required "$argumentDirectory")
  __environment printf "" >"$file" || return $?
  if $required; then
    __environment printf "%s\n" "$argumentName" >>"$file" || return $?
  fi
  file=$(__usageArgumentsSpecification__defaults "$argumentDirectory")
  __environment printf "" >"$file" || return $?
  if inArray "$argumentType" "Boolean" "Flag"; then
    __environment environmentValueWrite "$argumentName" false >>"$file" || return $?
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
    File | FileDirectory | Directory | LoadEnvironmentFile | RealDirectory)
      return 0
      ;;
    EmptyString | String)
      return 0
      ;;
    Boolean | PositiveInteger | Integer | UnsignedInteger | Number)
      return 0
      ;;
    Executable | Callable | Function)
      return 0
      ;;
    URL)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

# Usage: specification argumentIndex argumentValue
# Argument: specification - Required. String.
# Argument: argumentIndex - Required. Integer.
# Argument: argumentValue - Optional. String.
_usageArgumentName() {
  local usage="_${FUNCNAME[0]}"
  local specification="${1-}" stateFile="${2-}" argumentIndex="${3-}" argumentValue="${4-}" argumentNamed

  __usageArgumentSpecificationMagic "$usage" "$specification" || return $?
  if [ -f "$specification/$argumentValue" ]; then
    environmentValueRead "$specification/$argumentValue" argumentName not-named
    return 0
  fi
  argumentNamed="$(environmentValueRead "$stateFile" argumentNamed "")"
  if [ -z "$argumentNamed" ]; then
    _environment "No current argument" || return $?
  fi
  environmentValueRead "$specification/$argumentNamed" argumentName not-named
  return 0
}
__usageArgumentName() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: specification - Required. String.
# Argument: stateFile - Required. File.
# Argument: argumentIndex - Required. Integer.
# Argument: argumentValue - Optional. String.
_usageArgumentType() {
  local usage="_${FUNCNAME[0]}"
  local specification="${1-}" stateFile="${2-}" argumentIndex="${3-}" argumentValue="${4-}"
  local argumentNamed argumentRepeat indexSpec

  __usageArgumentSpecificationMagic "$usage" "$specification" || return $?
  if [ -f "$specification/$argumentValue" ]; then
    environmentValueRead "$specification/$argumentValue" argumentType undefined
    return 0
  fi
  argumentNamed="$(environmentValueRead "$stateFile" argumentNamed "")"
  argumentRepeat="$(environmentValueRead "$stateFile" argumentRepeat "")"
  if [ -z "$argumentNamed" ]; then
    argumentNamed=0
  elif [ "$argumentRepeat" != "$argumentNamed" ]; then
    argumentNamed=$((argumentNamed + 1))
  fi
  indexSpec="$specification/#--$argumentNamed"
  printf "%s\n" "$indexSpec" 1>&2
  if [ ! -f "$indexSpec" ]; then
    printf -- "%s" "-"
    return 0
  fi
  printf "%s%s" "$(environmentValueRead "$indexSpec" argumentType undefined)" "$(_choose "$argumentRepeat" '*' '')"
  environmentValueWrite argumentNamed "$argumentNamed" >>"$stateFile"
  if ! $argumentRepeat; then
    argumentRepeat="$(environmentValueRead "$indexSpec" argumentRepeat false)"
    _boolean "$argumentRepeat" || __failEnvironment "$usage" "$indexSpec non-boolean argumentRepeat" || return $?
    if $argumentRepeat; then
      environmentValueWrite argumentRepeat "$argumentNamed" >>"$stateFile"
    fi
  fi
  return 0
}
__usageArgumentType() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: specification - Required. String.
# Argument: stateFile - Required. File.
# Argument: ... - Optional. String. One or more
_usageArgumentsRemainder() {
  local usage="_${FUNCNAME[0]}"
  local specification="${1-}" stateFile="${2-}"

  shift && shift
  __usageArgumentSpecificationMagic "$usage" "$specification" || return $?
  printf "%s\n" "$stateFile" "$@"
}
