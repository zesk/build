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
# Output is
#
# Type is one of:
#
# - Integer
# - UnsignedInteger
# - Number
# - File
# - FileDirectory
# - Directory
# - String
#
_arguments() {
  local usageArguments="_${FUNCNAME[0]}"
  local this="${1-}" source="${2-}"
  local usage="_$this"
  local argument nArguments argumentIndex
  local stateFile checkFunction value clean

  shift || __usageArgument "$usageArguments" "Missing this" || return $?
  shift || __usageArgument "$usageArguments" "Missing source" || return $?
  stateFile=$(__usageEnvironment "$usageArguments" mktemp) || return $?
  spec=$(__usageEnvironment "$usageArguments" _usageArgumentsSpecification "$this" "$source") || return $?
  # Rest is calling function argument usage
  clean=("$spec" "$stateFile")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || _clean "$?" "${clean[@]}" || return $?
    case "$argument" in
      --help)
        "$usage" 0 && _clean "$?" "${clean[@]}" || return $?
        return $?
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
          __failArgument "$usage" "unhandled argument type $type #$argumentIndex: $argument" || return $?
        fi
        argumentName="$(_usageArgumentName "$spec" "$argumentIndex" "$argument")"
        checkFunction="usageArgument${argument}"
        value="$("$checkFunction" "$usage" "$argumentName" "${1-}")" || _clean "$?" || return $?
        __usageEnvironment "$usage" environmentValueWrite "$argumentName" "$value" >>"$stateFile" || _clean "$?" || return $?
        ;;

    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done
  _usageArgumentsRemainder "$spec" "$stateFile" "$@" || return $?
}
__arguments() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  [ -f "$functionDefinitionFile" ] || __usageArgument "$usage" "$functionDefinitionFile does not exist" || return $?
  [ -n "$functionName" ] || __usageArgument "$usage" "functionName is blank" || return $?
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

# Argument: argumentDirectory - Required. Directory. Directory where the arguments structure is stored.
# Argument: argumentId - Required. Integer. This argument ID.
# Output: nothing
_usageArgumentsSpecificationParseLine() {
  local argumentDirectory="${1-}" argumentId="${2-}"
  local argument argumentIndex
  local required saveRequired argumentType

  [ -d "$argumentDirectory" ] || _argument "$argumentDirectory is not a directory" || return $?
  _integer "$argumentId" || _argument "$argumentId is not an integer" || return $?
  shift 2

  savedLine="$*"
  argumentIndex=
  while [ "$#" -gt 0 ]; do
    argument="$1"
    case "$argument" in
      --* | -[[:alpha:]]*)
        argumentFinder="$argument"
        argumentName="${argument#-}"
        argumentName="${argumentName#-}"
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
        argumentFinder=$argumentIndex
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
  if $required && [ "$argumentType" = "String" ]; then
    argumentType=Required
  fi
  {
    environmentValueWrite argumentName "$argumentName"
    environmentValueWrite argumentType "$argumentType"
    environmentValueWrite argumentId "$argumentIndex"
    environmentValueWrite argumentRequired "$required"
    environmentValueWrite argumentFinder "$argumentFinder"
    environmentValueWrite description "$description"
  } >"$argumentDirectory/$argumentFinder" || _argument "Unable to write $argumentDirectory/$argumentFinder" || return $?
  __environment printf "%s\n" "$argumentName" >>"$argumentDirectory/required" || return $?
}
__usageArgumentsSpecification() {
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
    Required | String)
      return 0
      ;;
    Boolean | PositiveInteger | Integer | UnsignedInteger | Number)
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
  local specification="${1-}" stateFile="${2-}" argumentIndex="${3-}" argumentValue="${4-}" argumentNamed

  __usageArgumentSpecificationMagic "$usage" "$specification" || return $?
  if [ -f "$specification/$argumentValue" ]; then
    environmentValueRead "$specification/$argumentValue" argumentType undefined
    return 0
  fi
  argumentNamed="$(environmentValueRead "$stateFile" argumentNamed "")"
  if [ -z "$argumentNamed" ]; then
    argumentNamed=0
  else
    argumentNamed=$((argumentNamed + 1))
  fi
  if [ ! -f "$specification/$argumentNamed" ]; then
    printf -- "%s" "-"
    return 0
  fi
  prinff "!%s" "$(environmentValueRead "$specification/$argumentNamed" argumentType undefined)"
  environmentValueWrite "$stateFile" argumentNamed "$argumentNamed"
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
