#!/usr/bin/env bash
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/map.md
# Test: ./test/tools/map-tests.sh
#
#  ▛▚▀▖▝▀▖▛▀▖
#  ▌▐ ▌▞▀▌▙▄▘
#  ▘▝ ▘▝▀▘▌
#
# map in this context means converting text using name/value pairs

# Usage: mapTokens prefix suffix < input > output
# Argument: `prefix` - Optional prefix for token search, defaults to `{` (same as `map.sh`)
# Argument: `suffix` - Optional suffix for token search, defaults to `}` (same as `map.sh`)
# Exit Codes: Zero.
# Local Cache: None.
# Environment: None.
# Short description: list mappable variables in a file (without prefix or suffix)
# Depends: sed quoteSedPattern
mapTokens() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
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
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Maps a string using an environment file
#
# Usage: mapValue mapFile [ value ... ]
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: mapFile - Required. File. a file containing bash environment definitions
# Argument: value - Optional. String. One or more values to map using said environment file
# Argument: --prefix - Optional. String. Token prefix defaults to `{`.
# Argument: --suffix - Optional. String. Token suffix defaults to `}`.
# Argument: --search-filter - Zero or more. Callable. Filter for search tokens. (e.g. `lowercase`)
# Argument: --replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. `trimSpace`)
mapValue() {
  local handler="_${FUNCNAME[0]}"

  local searchFilters=() replaceFilters=() mapFile="" prefix='{' suffix='}'
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --prefix)
      shift
      prefix=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --suffix)
      shift
      suffix=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --search-filter)
      shift
      searchFilters+=("$(usageArgumentCallable "$handler" "searchFilter" "${1-}")") || return $?
      ;;
    --replace-filter)
      shift
      replaceFilters+=("$(usageArgumentCallable "$handler" "replaceFilter" "${1-}")") || return $?
      ;;
    *)
      if [ -z "$mapFile" ]; then
        mapFile=$(usageArgumentFile "$handler" "mapFile" "${1-}") || return $?
        shift
        break
      else
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
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
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Maps a string using an environment file
#
# Usage: {fn} mapFile [ value ... ]
# Argument: mapFile - Required. File. a file containing bash environment definitions
# Argument: value - Optional. String. One or more values to map using said environment file.
#
mapValueTrim() {
  mapValue --handler "_${FUNCNAME[0]}" --replace-filter trimSpace "$@"
}
_mapValueTrim() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL mapEnvironment 104

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# Usage: {fn} [ environmentName ... ]
# This one does it like `mapValue`
# See: mapValue
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: environmentVariableName - Optional. String. Map this value only. If not specified, all environment variables are mapped.
# Argument: --prefix - Optional. String. Prefix character for tokens, defaults to `{`.
# Argument: --suffix - Optional. String. Suffix character for tokens, defaults to `}`.
# Argument: --search-filter - Zero or more. Callable. Filter for search tokens. (e.g. `lowercase`)
# Argument: --replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. `trimSpace`)
# Environment: Argument-passed or entire environment variables which are exported are used and mapped to the destination.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
# Requires: environmentVariables cat throwEnvironment catchEnvironment
# Requires: throwArgument decorate usageArgumentString
mapEnvironment() {
  local handler="_${FUNCNAME[0]}"

  local __prefix='{' __suffix='}' __ee=() __searchFilters=() __replaceFilters=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --prefix)
      shift
      __prefix=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --suffix)
      shift
      __suffix=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --search-filter)
      shift
      __searchFilters+=("$(usageArgumentCallable "$handler" "searchFilter" "${1-}")") || return $?
      ;;
    --replace-filter)
      shift
      __replaceFilters+=("$(usageArgumentCallable "$handler" "replaceFilter" "${1-}")") || return $?
      ;;
    --env-file)
      shift
      muzzle usageArgumentLoadEnvironmentFile "$handler" "$argument" "${1-}" || return $?
      ;;
    *)
      __ee+=("$(usageArgumentString "$handler" "environmentVariableName" "$argument")") || return $?
      ;;
    esac
    shift
  done

  # If no environment variables are passed on the command line, then use all of them
  local __e
  if [ "${#__ee[@]}" -eq 0 ]; then
    while read -r __e; do __ee+=("$__e"); done < <(environmentVariables)
  fi

  (
    local __filter __value __handler="$handler"
    unset handler

    __value="$(catchEnvironment "$__handler" cat)" || return $?
    if [ $((${#__replaceFilters[@]} + ${#__searchFilters[@]})) -gt 0 ]; then
      for __e in "${__ee[@]}"; do
        case "${__e}" in *[!A-Za-z0-9_]*) continue ;; *) ;; esac
        local __search="$__prefix$__e$__suffix"
        local __replace="${!__e-}"
        if [ ${#__searchFilters[@]} -gt 0 ]; then
          for __filter in "${__searchFilters[@]}"; do
            __search=$(catchEnvironment "$__handler" "$__filter" "$__search") || return $?
          done
        fi
        if [ ${#__replaceFilters[@]} -gt 0 ]; then
          for __filter in "${__replace[@]}"; do
            __replace=$(catchEnvironment "$__handler" "$__filter" "$__replace") || return $?
          done
        fi
        __value="${__value//"$__search"/$__replace}"
      done
    else
      for __e in "${__ee[@]}"; do
        case "${__e}" in *[!A-Za-z0-9_]*) continue ;; *) ;; esac
        local __search="$__prefix$__e$__suffix"
        local __replace="${!__e-}"
        __value="${__value//"$__search"/$__replace}"
      done
    fi
    printf "%s\n" "$__value"
  )
}
_mapEnvironment() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: cannon [ --path directory ] [ --help ] fromText toText [ findArgs ... ]
# Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.
#
# This can break your files so use with caution. Blank searchText is not allowed.
# The term `cannon` is not a mistake - it will break something at some point.
#
# Example:     {fn} master main ! -path '*/old-version/*')
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: --path cannonPath - Optional. Directory. Run cannon operation starting in this directory.
# Argument: fromText - Required. String of text to search for.
# Argument: toText - Required. String of text to replace.
# Argument: findArgs ... - Optional. FindArgument. Any additional arguments are meant to filter files.
# Return Code: 0 - Success
# Return Code: 1 - --path is not a directory
# Return Code: 1 - searchText is not blank
# Return Code: 1 - fileTemporaryName failed
# Return Code: 2 - Arguments are identical
# See: cannon.sh
cannon() {
  local handler="_${FUNCNAME[0]}"

  local search="" cannonPath="." replace=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --path)
      shift
      cannonPath=$(usageArgumentDirectory "$handler" "$argument cannonPath" "${1-}") || return $?
      ;;
    *)
      if [ -z "$search" ]; then
        search="$(usageArgumentString "$handler" "searchText" "$argument")" || return $?
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
    statusMessage --inline decorate success "Modified $(decorate code "$(pluralWord "$count" file)")"
    exitCode=1
  fi
  returnUndo "$exitCode" "${undo[@]}" || return $?
  return $?
}
_cannon() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
