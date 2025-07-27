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
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
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
  local usage="_${FUNCNAME[0]}"

  local searchFilters=() replaceFilters=() mapFile="" prefix='{' suffix='}'
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
    # _IDENTICAL_ --handler 4
    --handler)
      shift
      usage=$(usageArgumentFunction "$usage" "$argument" "${1-}") || return $?
      ;;
    --prefix)
      shift
      prefix=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    --suffix)
      shift
      suffix=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    --search-filter)
      shift
      searchFilters+=("$(usageArgumentCallable "$usage" "searchFilter" "${1-}")") || return $?
      ;;
    --replace-filter)
      shift
      replaceFilters+=("$(usageArgumentCallable "$usage" "replaceFilter" "${1-}")") || return $?
      ;;
    *)
      if [ -z "$mapFile" ]; then
        mapFile=$(usageArgumentFile "$usage" "mapFile" "${1-}") || return $?
        shift
        break
      else
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$mapFile" ] || __throwArgument "$usage" "mapFile required" || return $?
  (
    local value environment searchToken environmentValue filter

    value="$*"
    while read -r environment; do
      environmentValue=$(__catch "$usage" environmentValueRead "$mapFile" "$environment") || return $?
      searchToken="$prefix$environment$suffix"
      if [ ${#searchFilters[@]} -gt 0 ]; then
        for filter in "${searchFilters[@]}"; do
          searchToken=$(__catchEnvironment "$usage" "$filter" "$searchToken") || return $?
        done
      fi
      if [ ${#replaceFilters[@]} -gt 0 ]; then
        for filter in "${replaceFilters[@]}"; do
          environmentValue=$(__catchEnvironment "$usage" "$filter" "$environmentValue") || return $?
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

# IDENTICAL mapEnvironment 79

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# Usage: {fn} [ environmentName ... ]
# TODO: Do this like `mapValue`
# See: mapValue
# Argument: environmentName - Optional. String. Map this value only. If not specified, all environment variables are mapped.
# Argument: --prefix - Optional. String. Prefix character for tokens, defaults to `{`.
# Argument: --suffix - Optional. String. Suffix character for tokens, defaults to `}`.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Environment: Argument-passed or entire environment variables which are exported are used and mapped to the destination.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
# Requires: __throwArgument read environmentVariables decorate sed cat rm __throwEnvironment __catchEnvironment _clean
# Requires: usageArgumentString fileTemporaryName
mapEnvironment() {
  local handler="_${FUNCNAME[0]}"
  local __sedFile __prefix='{' __suffix='}'

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ argumentBlankCheck 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --prefix)
      shift
      __prefix="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --suffix)
      shift
      __suffix="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
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
  __catchEnvironment "$__handler" _mapEnvironmentGenerateSedFile "$__prefix" "$__suffix" "${__ee[@]}" >"$__sedFile" || returnClean $? "$__sedFile" || return $?
  __catchEnvironment "$__handler" sed -f "$__sedFile" || __throwEnvironment "$__handler" "$(cat "$__sedFile")" || returnClean $? "$__sedFile" || return $?
  __catchEnvironment "$__handler" rm -f "$__sedFile" || return $?
}
_mapEnvironment() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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

# Usage: cannon [ --path directory ] [ --help ] fromText toText [ findArgs ... ]
# Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.
#
# This can break your files so use with caution. Blank searchText is not allowed.
# The term `cannon` is not a mistake - it will break something at some point.
#
# Example:     {fn} master main ! -path '*/old-version/*')
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --path cannonPath - Optional. Directory. Run cannon operation starting in this directory.
# Argument: fromText - Required. String of text to search for.
# Argument: toText - Required. String of text to replace.
# Argument: findArgs ... - Optional. FindArgument. Any additional arguments are meant to filter files.
# Exit Code: 0 - Success
# Exit Code: 1 - --path is not a directory
# Exit Code: 1 - searchText is not blank
# Exit Code: 1 - fileTemporaryName failed
# Exit Code: 2 - Arguments are identical
# See: cannon.sh
cannon() {
  local usage="_${FUNCNAME[0]}"

  local search="" cannonPath="." replace=""

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
    --path)
      shift
      cannonPath=$(usageArgumentDirectory "$usage" "$argument cannonPath" "${1-}") || return $?
      ;;
    *)
      if [ -z "$search" ]; then
        search="$(usageArgumentString "$usage" "searchText" "$argument")" || return $?
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
  [ "$searchQuoted" != "$replaceQuoted" ] || __throwArgument "$usage" "from = to \"$search\" are identical" || return $?
  cannonLog=$(fileTemporaryName "$usage") || return $?
  if ! find "$cannonPath" -type f ! -path "*/.*/*" "$@" -print0 >"$cannonLog"; then
    printf "%s" "$(decorate success "# \"")$(decorate code "$1")$(decorate success "\" Not found")"
    rm "$cannonLog" || :
    return 0
  fi
  xargs -0 grep -l "$search" <"$cannonLog" >"$cannonLog.found" || :

  local exitCode=0 count

  count="$(($(__catch "$usage" fileLineCount "$cannonLog.found") + 0))" || return $?
  if [ "$count" -eq 0 ]; then
    statusMessage --inline decorate warning "Modified (NO) files"
  else
    __catch "$usage" __xargsSedInPlaceReplace -e "s/$searchQuoted/$replaceQuoted/g" <"$cannonLog.found" || returnClean $? "$cannonLog" || return $?
    statusMessage --inline decorate success "Modified $(decorate code "$count $(plural "$count" file files)")"
    exitCode=1
  fi
  __catchEnvironment "$usage" rm -f "$cannonLog" "$cannonLog.found" || return $?
  return "$exitCode"
}
_cannon() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
