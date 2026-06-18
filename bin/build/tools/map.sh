#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
#
#
#  ▛▚▀▖▝▀▖▛▀▖
#  ▌▐ ▌▞▀▌▙▄▘
#  ▘▝ ▘▝▀▘▌
#
# map in this context means converting text using name/value pairs

# IDENTICAL mapFunction 99

# Summary: Convert tokens in input to values
#
# Map tokens in the input stream based on some heuristic.
#
# Converts tokens in the form `{VARIABLE}` to the associated value.
#
# Undefined values are not converted.
#
# See: mapValue mapEnvironment
# Argument: --env-file envFile - File. Optional. Load this environment file prior to processing input.
# Argument: --default defaultString - String. Optional. Default string for tokens. Can use additional tokens: `{prefix}` `{suffix}` `{tokenName}` and `{token}`. Set to `--` to output `token`.
# Argument: --prefix prefixString - String. Optional. Prefix character for tokens, defaults to `{`.
# Argument: --suffix suffixString - String. Optional. Suffix character for tokens, defaults to `}`.
# Argument:  mapFunction ... - Function. Required. Replacement function with arguments. Called as is with three additional arguments: `tokenName` `offset` `total`
#
# `mapFunction` should return non-zero to have the default behavior occur. If a zero exit code is output then some replacement value is assumed to be written to `stdout` by the `mapFunction`.
# The special return code 120 is used to terminate the calling function immediately.
# Return Code: 120 - Map function exited early
# Return Code: 130 - User interrupt (exits early)
# Return Code: 141 - System interrupt (exits early)
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Requires: cat throwEnvironment catchEnvironment
# Requires: throwArgument decorate validate
mapFunction() {
  local handler="_${FUNCNAME[0]}"

  local __prefix='{' __suffix='}' __ee=() __searchFilters=() __replaceFilters=() mapper=() __default="--"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --default) shift && __default=$(validate "$handler" EmptyString "$argument" "${1-}") || return $? ;;
    --prefix) shift && __prefix=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --suffix) shift && __suffix=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --env-file) shift && muzzle validate "$handler" LoadEnvironmentFile "$argument" "${1-}" || return $? ;;
    *) muzzle validate "$handler" Function "mapFunction" "$1" && mapper=("$@") && set -- && break || return $? ;;
    esac
    shift
  done

  [ ${#mapper[@]} -gt 0 ] || throwArgument "$handler" "mapFunction is required" || return $?

  local __counter=0 __checkValue=""
  local __failed=()
  local __value && __value="$(catchEnvironment "$handler" cat)" || return $?
  local __offset=0 __total="${#__value}" && while true; do
    local __remain="${__value#*"$__prefix"}"
    [ "$__remain" != "$__value" ] || break
    local __tokenName="${__remain%%"$__suffix"*}"
    [ "$__tokenName" != "$__remain" ] || break
    local __before="${__value%%"$__prefix"*}"
    __offset=$((__offset + ${#__before}))
    printf -- "%s" "$__before"
    __value="${__value#*"$__suffix"}"
    if [ "${__tokenName#*$'\n'}" != "$__tokenName" ]; then
      # Invalid token name (newline)
      printf -- "%s%s%s" "$__prefix" "$__tokenName" "$__suffix"
      continue
    else
      local __token="$__prefix$__tokenName$__suffix"
      local __returnCode && if [ "${#__failed[@]}" -gt 0 ] && inArray "$__tokenName" "${__failed[@]}"; then
        __returnCode=1
      else
        if "${mapper[@]}" "$__tokenName" "$__offset" "$__total"; then
          __returnCode=0
        else
          __returnCode=$?
          __failed+=("$__tokenName")
        fi
      fi
      case "$__returnCode" in 120 | 130 | 141) return "$__returnCode" ;; esac
      [ "$__returnCode" -gt 0 ] || continue
      case "$__default" in
      "") ;;
      --) printf -- "%s" "$__token" ;;
      *) printf -- "%s" "$(prefix="$__prefix" suffix="$__suffix" tokenName="$__tokenName" token="$__prefix$__tokenName$__suffix" mapEnvironment <<<"$__default")" ;;
      esac
    fi
    __counter=$((__counter + 1))
    if [ $__counter -gt 1000 ]; then
      throwEnvironment "$handler" "Infinite loop found at $__count $__offset of $__total $(dumpPipe "Infinite loop found at $__count $__offset of $__total Remain:" <<<"$__value")" || return $?
    fi
  done
  printf -- "%s" "$__value"
}
_mapFunction() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: `prefix` - Optional prefix for token search, defaults to `{` (same as `map.sh`)
# Argument: `suffix` - Optional suffix for token search, defaults to `}` (same as `map.sh`)
# Environment: None.
# Short description: list mappable variables in a file (without prefix or suffix)
# Depends: sed quoteSedPattern
# shellcheck disable=SC2120
mapTokens() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local prefix prefixQ suffix suffixQ removeQuotesPattern argument

  prefix="${1-"{"}"
  prefixQ=$(quoteSedPattern "$prefix")
  suffix="${2-"}"}"
  suffixQ=$(quoteSedPattern "$suffix")

  removeQuotesPattern="s/.*$prefixQ\([^$suffixQ]*\)$suffixQ.*/\1/g"

  # insert newline before all found prefix
  # insert newline after all found suffix
  # remove lines missing a prefix OR missing a suffix
  # remove all content before prefix and after suffix
  # remaining lines are our raw tokens
  # tokens may be any character except prefix or suffix or nul
  sed -e "s/$prefixQ/\n$(quoteSedReplacement "$prefix")/g" -e "s/$suffixQ/$(quoteSedReplacement "$suffix")\n)/g" | sed -e "/$prefixQ/!d" -e "/$suffixQ/!d" -e "$removeQuotesPattern"
}
_mapTokens() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Maps a string using an environment file
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# Argument: mapFile - File. Required. a file containing bash environment definitions
# Argument: value - String. Optional. One or more values to map using said environment file
# Argument: --prefix - String. Optional. Token prefix defaults to `{`.
# Argument: --suffix - String. Optional. Token suffix defaults to `}`.
# Argument: --search-filter - Zero or more. Callable. Filter for search tokens. (e.g. `stringLowercase`)
# Argument: --replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. `textTrim`)
mapValue() {
  local handler="_${FUNCNAME[0]}"

  local searchFilters=() replaceFilters=() mapFile="" prefix='{' suffix='}'
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --prefix)
      shift
      prefix=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --suffix)
      shift
      suffix=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --search-filter)
      shift
      searchFilters+=("$(validate "$handler" Callable "searchFilter" "${1-}")") || return $?
      ;;
    --replace-filter)
      shift
      replaceFilters+=("$(validate "$handler" Callable "replaceFilter" "${1-}")") || return $?
      ;;
    *)
      if [ -z "$mapFile" ]; then
        mapFile=$(validate "$handler" File "mapFile" "${1-}") || return $?
        shift
        break
      else
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$mapFile" ] || throwArgument "$handler" "mapFile required" || return $?
  (
    local value environment searchToken environmentValue filter

    value="$*"
    while read -r environment; do
      environmentValue=$(catchReturn "$handler" environmentValueRead "$mapFile" "$environment") || return $?
      searchToken="$prefix$environment$suffix"
      if [ ${#searchFilters[@]} -gt 0 ]; then
        for filter in "${searchFilters[@]}"; do
          searchToken=$(catchEnvironment "$handler" "$filter" "$searchToken") || return $?
        done
      fi
      if [ ${#replaceFilters[@]} -gt 0 ]; then
        for filter in "${replaceFilters[@]}"; do
          environmentValue=$(catchEnvironment "$handler" "$filter" "$environmentValue") || return $?
        done
      fi
      value="${value/${searchToken}/${environmentValue}}"
    done < <(environmentNames <"$mapFile")
    printf "%s\n" "$value"
  )
}
_mapValue() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Maps a string using an environment file
#
# Argument: mapFile - File. Required. a file containing bash environment definitions
# Argument: value - String. Optional. One or more values to map using said environment file.
#
mapValueTrim() {
  mapValue --handler "_${FUNCNAME[0]}" --replace-filter textTrim "$@"
}
_mapValueTrim() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL mapEnvironment 63

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# This one does it like `mapValue`
# Environment is accessed via arguments passed or entire exported environment value space are and mapped to the destination.
# See: mapValue
# Argument: environmentVariableName - String. Optional. Map this value only. If not specified, all environment variables are mapped.
# Argument: --prefix - String. Optional. Prefix character for tokens, defaults to `{`.
# Argument: --suffix - String. Optional. Suffix character for tokens, defaults to `}`.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
# Requires: environmentVariables cat throwEnvironment catchEnvironment
# Requires: throwArgument decorate validate
# shellcheck disable=SC2120
mapEnvironment() {
  local handler="_${FUNCNAME[0]}"

  local __prefix='{' __suffix='}' __ee=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --prefix) shift && __prefix=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --suffix) shift && __suffix=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --env-file) shift && muzzle validate "$handler" LoadEnvironmentFile "$argument" "${1-}" || return $? ;;
    *) __ee+=("$(validate "$handler" String "environmentVariableName" "$argument")") || return $? ;;
    esac
    shift
  done

  # If no environment variables are passed on the command line, then use all of them
  local __e
  if [ "${#__ee[@]}" -eq 0 ]; then
    while read -r __e; do __ee+=("$__e"); done < <(environmentVariables)
  fi

  (
    local __value && __value="$(catchEnvironment "$handler" cat)" || return $?
    unset handler
    for __e in "${__ee[@]}"; do
      case "${__e}" in *[!A-Za-z0-9_]*) continue ;; *) ;; esac
      local __search="$__prefix$__e$__suffix"
      local __replace="${!__e-}"
      __value="${__value//"$__search"/$__replace}"
    done
    printf "%s" "$__value"
  )
}
_mapEnvironment() {
  decorateInitialized || decorate info --
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL mapEnvironmentSed 78

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# Uses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination.
# TODO: Do this like `mapValue`
# See: mapValue
# Argument: environmentName - String. Optional. Map this value only. If not specified, all environment variables are mapped.
# Argument: --prefix - String. Optional. Prefix character for tokens, defaults to `{`.
# Argument: --suffix - String. Optional. Suffix character for tokens, defaults to `}`.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
# Requires: throwArgument read environmentVariables decorate sed cat rm throwEnvironment catchEnvironment returnClean
# Requires: validate fileTemporaryName
mapEnvironmentSed() {
  local handler="_${FUNCNAME[0]}"
  local __sedFile __prefix='{' __suffix='}'

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --prefix)
      shift
      __prefix="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    --suffix)
      shift
      __suffix="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    *)
      break
      ;;
    esac
    shift
  done

  local __ee=("$@") __e __handler="$handler"
  # Allows the name `handler` to exist as a variable to map
  unset handler

  if [ $# -eq 0 ]; then
    while read -r __e; do __ee+=("$__e"); done < <(environmentVariables)
  fi
  __sedFile=$(fileTemporaryName "$__handler") || return $?
  catchEnvironment "$__handler" _mapEnvironmentGenerateSedFile "$__prefix" "$__suffix" "${__ee[@]}" >"$__sedFile" || returnClean $? "$__sedFile" || return $?
  catchEnvironment "$__handler" sed -f "$__sedFile" || throwEnvironment "$__handler" "$(cat "$__sedFile")" || returnClean $? "$__sedFile" || return $?
  catchEnvironment "$__handler" rm -f "$__sedFile" || return $?
}
_mapEnvironmentSed() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Helper function
# Requires: printf quoteSedPattern quoteSedReplacement
_mapEnvironmentGenerateSedFile() {
  local __prefix="${1-}" __suffix="${2-}"

  shift 2
  while [ $# -gt 0 ]; do
    case "$1" in
    *[%{}]* | LD_*) ;; # skips
    *)
      printf "s/%s/%s/g\n" "$(quoteSedPattern "$__prefix$1$__suffix")" "$(quoteSedReplacement "${!1-}")"
      ;;
    esac
    shift
  done
}

# IDENTICAL mapEnvironmentFun 54

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# Uses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination.
# See: mapEnvironment
# See: mapValue
# Argument: environmentName - String. Optional. Map this value only. If not specified, all environment variables are mapped.
# Argument: --env-file envFile - File. Optional. Load this environment file prior to processing input.
# Argument: --prefix - String. Optional. Prefix character for tokens, defaults to `{`.
# Argument: --suffix - String. Optional. Suffix character for tokens, defaults to `}`.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
# Requires: throwArgument decorate
# Requires: validate
mapEnvironmentFun() {
  local handler="_${FUNCNAME[0]}"
  local __aa=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --env-file | --prefix | --suffix) shift && __aa+=("$("$argument" "${1-}")") ;;
    *) break ;;
    esac
    shift
  done

  local onlyList && onlyList=$(listJoin ":" "$@")
  [ -z "$onlyList" ] || onlyList=":$onlyList:"
  mapFunction "${__aa[@]+"${__aa[@]}"}" __mapEnvironmentFun "$onlyList"
}
_mapEnvironmentFun() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Helper function
__mapEnvironmentFun() {
  local __onlyList="$1" && shift
  local __tokenName="$1" && shift
  [ -z "$__onlyList" ] || stringContains "$__onlyList" ":$__tokenName:" || return 1
  [ -n "${!__tokenName+x}" ] || return 1
  printf -- %s "${!__tokenName}"
}

# Summary: Replace text `fromText` with `toText` in files
# Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.
#
# This can break your files so use with caution. Blank `searchText` is **not allowed**.
# The term `textCannon` is not a mistake - it will break something at some point.
#
# Example:     {fn} master main ! -path '*/old-version/*')
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# Argument: --path cannonPath - Directory. Optional. Run textCannon operation starting in this directory.
# Argument: fromText - Required. String of text to search for.
# Argument: toText - Required. String of text to replace.
# Argument: findArgs ... - Arguments. Optional. Any additional arguments are meant to filter files.
# Return Code: 0 - Success, no files changed
# Return Code: 3 - At least one or more files were modified successfully
# Return Code: 1 - --path is not a directory
# Return Code: 1 - searchText is not blank
# Return Code: 1 - `fileTemporaryName` failed
# Return Code: 2 - Arguments are identical
textCannon() {
  local handler="_${FUNCNAME[0]}"

  local search="" cannonPath="." replace=""

  # _IDENTICAL_ argumentBlankLoopHandler 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --path)
      shift
      cannonPath=$(validate "$handler" Directory "$argument cannonPath" "${1-}") || return $?
      ;;
    *)
      if [ -z "$search" ]; then
        search="$(validate "$handler" String "searchText" "$argument")" || return $?
      elif [ -z "$replace" ]; then
        replace="$argument"
        shift
        break
      fi
      ;;
    esac
    shift
  done

  local searchQuoted replaceQuoted cannonLog

  searchQuoted=$(quoteSedPattern "$search")
  replaceQuoted=$(quoteSedPattern "$replace")
  [ "$searchQuoted" != "$replaceQuoted" ] || throwArgument "$handler" "from = to \"$search\" are identical" || return $?
  cannonLog=$(fileTemporaryName "$handler") || return $?
  local undo=(muzzle popd -- rm -f "$cannonLog" "$cannonLog.found" --)
  catchEnvironment "$handler" muzzle pushd "$cannonPath" || return $?
  if ! find "." -type f ! -path "*/.*/*" "$@" -print0 >"$cannonLog"; then
    printf "%s" "$(decorate success "# \"")$(decorate code "$1")$(decorate success "\" Not found")"
    returnUndo 0 "${undo[@]}"
    return $?
  fi
  xargs -0 grep -l "$search" <"$cannonLog" >"$cannonLog.found" || :

  local exitCode=0 count

  count="$(($(catchReturn "$handler" fileLineCount "$cannonLog.found") + 0))" || returnUndo 0 "${undo[@]}" || return $?
  if [ "$count" -eq 0 ]; then
    statusMessage --inline decorate warning "Modified (NO) files"
  else
    catchReturn "$handler" __xargsSedInPlaceReplace -e "s/$searchQuoted/$replaceQuoted/g" <"$cannonLog.found" || returnUndo 0 "${undo[@]}" || return $?
    statusMessage --inline decorate success "Modified $(decorate code "$(localePluralWord "$count" file)")"
    exitCode=3
  fi
  returnUndo "$exitCode" "${undo[@]}" || return $?
  return $?
}
_textCannon() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
