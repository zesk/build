#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Shell Dependencies: awk sed date sort printf
#
# Docs: o ./docs/_templates/tools/text.md
# Test: o ./test/tools/text-tests.sh
#
###############################################################################
#
#    ▄                    ▄
#  ▄▄█▄▄   ▄▄▄   ▄   ▄  ▄▄█▄▄
#    █    █▀  █   █▄█     █
#    █    █▀▀▀▀   ▄█▄     █
#    ▀▄▄  ▀█▄▄▀  ▄▀ ▀▄    ▀▄▄
#
#------------------------------------------------------------------------------
#

# Parses text and determines if it's true-ish
#
# Usage: {fn} text
# Exit Code: 0 - true
# Exit Code: 1 - false
# Exit Code: 2 - Neither
# See: lowercase
#
parseBoolean() {
  case "$(lowercase "$1")" in
    y | yes | 1 | true)
      return 0
      ;;
    n | no | 0 | false)
      return 1
      ;;
  esac
  return 2
}

#
# Summary: Quote sed strings for shell use
# Quote a string to be used in a sed pattern on the command line.
# Usage: quoteSedPattern text
# Argument: text - Text to quote
# Output: string quoted and appropriate to insert in a sed search or replacement phrase
# Example:     sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"
#
quoteSedPattern() {
  # IDENTICAL quoteSedPattern 6
  value=$(printf "%s\n" "$1" | sed 's/\([\\.*+?]\)/\\\1/g')
  value="${value//\//\\/}"
  value="${value//[/\\[}"
  value="${value//]/\\]}"
  value="${value//&/\\&}"
  value="${value//$'\n'/\\n}"
  printf "%s\n" "$value"
}

#
# Summary: Quote grep -e patterns for shell use
#
# Usage: {fn} text
# Argument: text - Text to quote
# Output: string quoted and appropriate to insert in a grep search or replacement phrase
# Example:     grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"
#
quoteGrepPattern() {
  value=$(printf "%s\n" "$1" | sed 's/\([\\.*+?]\)/\\\1/g')
  value="${value//[/\\[}"
  value="${value//]/\\]}"
  value="${value//)/\\)}"
  value="${value//(/\\(}"
  value="${value//|/\\|}"
  value="${value//$'\n'/\\n}"
  printf "%s\n" "$value"
}

#
# Quote strings for inclusion in shell quoted strings
# Usage: escapeSingleQuotes text
# Argument: text - Text to quote
# Output: Single quotes are prefixed with a backslash
# Example:     escapeSingleQuotes "Now I can't not include this in a bash string."
#
escapeDoubleQuotes() {
  while [ $# -gt 0 ]; do
    printf "%s\n" "${1//\"/\\\"}"
    shift
  done
}

#
# Usage: {fn} [ text }
# Converts strings to shell escaped strings
#
escapeBash() {
  local jqArgs

  jqArgs=(-r --raw-input '@sh')
  if [ $# -gt 0 ]; then
    printf "%s\n" "$@" | jq "${jqArgs[@]}"
  else
    jq "${jqArgs[@]}"
  fi
}

#
# Quote strings for inclusion in shell quoted strings
# Usage: escapeSingleQuotes text
# Argument: text - Text to quote
# Output: Single quotes are prefixed with a backslash
# Example:     escapeSingleQuotes "Now I can't not include this in a bash string."
#
escapeSingleQuotes() {
  printf "%s\n" "$@" | sed "s/'/\\\'/g"
}

#
# Quote strings for inclusion in shell quoted strings
# Usage: escapeSingleQuotes text
# Argument: text - Text to quote
# Output: Single quotes are prefixed with a backslash
# Example:     escapeSingleQuotes "Now I can't not include this in a bash string."
#
escapeQuotes() {
  printf %s "$(escapeDoubleQuotes "$(escapeSingleQuotes "$1")")"
}

#
# Usage: replaceFirstPattern pattern replacement
#
# Replaces the first and only the first occurrence of a pattern in a line with a replacement string.
#
replaceFirstPattern() {
  sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/1"
}

#
# Usage: {fn}
# Removes any blank lines from the beginning of a stream
#
trimHead() {
  sed -e "/./!d" -e :r -e n -e br
}

#
# Usage: {fn}
# Removes any blank lines from the end of a stream
#
trimTail() {
  sed -e :a -e '/^\n*$/{$d;N;ba' -e '}'
}

#
# Usage: {fn}
# Ensures blank lines are singular
#
singleBlankLines() {
  sed '/^$/N;/^\n$/D'
}

#
# Trim spaces and only spaces from arguments or a pipe
# Usage: {fn} text
# Argument: text - Text to remove spaces
# Output: text
# Example:     {fn} "$token"
# Summary: Trim whitespace of a bash argument
# Source: https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816
# Credits: Chris F.A. Johnson (2008)
#
trimSpace() {
  local var
  local usage

  usage="_${FUNCNAME[0]}"

  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      var="$1"
      # remove leading whitespace characters
      var="${var#"${var%%[![:space:]]*}"}"
      # remove trailing whitespace characters
      shift && printf %s "${var%"${var##*[![:space:]]}"}" || __failEnvironment "$usage" "printf failed" || return $?
    done
  else
    awk '{$1=$1};NF'
  fi
}
_trimSpace() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Quote bash strings for inclusion as single-quoted for eval
# Usage: quoteBashString text
# Argument: text - Text to quote
# Output: string quoted and appropriate to assign to a value in the shell
# Depends: sed
# Example:     name="$(quoteBashString "$name")"
quoteBashString() {
  printf "%s\n" "$@" | sed 's/\([$`<>'\'']\)/\\\1/g'
}

#
# Check if an element exists in an array
#
# Usage: inArray element [ arrayElement0 arrayElement1 ... ]
# Argument: `element` - Thing to search for
# Argument: `arrayElement0` - One or more array elements to match
# Example:     if inArray "$thing" "${things[@]}"; then things+=("$thing");
# Example:         things+=("$thing")
# Example:     fi
# Exit Code: 0 - If element is found in array
# Exit Code: 1 - If element is NOT found in array
# Tested: No
#
inArray() {
  local element=${1-} arrayElement
  shift || return 1
  for arrayElement; do
    if [ "$element" == "$arrayElement" ]; then
      return 0
    fi
  done
  return 1
}

#
# Check if one string is a substring of another set of strings (case-sensitive)
#
# Usage: {fn} needle [ haystack ... ]
# Argument: needle - Required. String. Thing to search for, not blank.
# Argument: haystack ... - Optional. EmptyString. One or more array elements to match
# Exit Code: 0 - If element is a substring of any haystack
# Exit Code: 1 - If element is NOT found as a substring of any haystack
# Tested: No
#
isSubstring() {
  local element=${1-} arrayElement
  shift || return 1
  for arrayElement; do
    if [ "${arrayElement#"*$element"}" != "$arrayElement" ]; then
      return 0
    fi
  done
  return 1
}
_isSubstring() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Check if one string is a substring of another set of strings (case-insensitive)
#
# Usage: {fn} needle [ haystack ... ]
# Argument: needle - Required. String. Thing to search for, not blank.
# Argument: haystack ... - Optional. EmptyString. One or more array elements to match
# Exit Code: 0 - If element is a substring of any haystack
# Exit Code: 1 - If element is NOT found as a substring of any haystack
# Tested: No
#
isSubstringInsensitive() {
  local element arrayElement

  element="$(lowercase "${1-}")"
  [ -n "$element" ] || __failArgument "$usage" "needle is blank" || return $?
  shift || return 1
  for arrayElement; do
    if [ "${arrayElement#"*$element"}" != "$arrayElement" ]; then
      return 0
    fi
  done
  return 1
}
_isSubstringInsensitive() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Remove words from the end of a phrase
#
# Usage: trimWords [ wordCount [ word0 ... ] ]
# Argument: `wordCount` - Words to output
# Argument: `word0` - One or more words to output
# Example:     printf "%s: %s\n" "Summary:" "$(trimWords 10 $description)"
# Tested: No
#
trimWords() {
  local wordCount=$((${1-0} + 0)) words=() result
  shift || return 0
  while [ ${#words[@]} -lt $wordCount ]; do
    IFS=' ' read -ra argumentWords <<<"${1-}"
    for argumentWord in "${argumentWords[@]+${argumentWords[@]}}"; do
      words+=("$argumentWord")
      if [ ${#words[@]} -ge $wordCount ]; then
        break
      fi
    done
    shift || break
  done
  result=$(printf '%s ' "${words[@]+${words[@]}}")
  printf %s "${result%% }"
}

#
# Usage: maximumFieldLength [ fieldIndex [ separatorChar ] ] < fieldBasedFile
#
# Given a input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields
#
# Defaults to first field (fieldIndex=1), space separator (separatorChar=" ")
#
# Argument: - `fieldIndex` - The field to compute the maximum length for
# Argument: - `separatorChar` - The separator character to delineate fields
# Argument: - `fieldBasedFile` - A file with fields
# Example:     usageOptions | usageGenerator $(usageOptions | maximumFieldLength 1 ;) ;
#
maximumFieldLength() {
  local index=$((${1-1} + 0)) separatorChar=${2-}

  if [ -n "$separatorChar" ]; then
    separatorChar=("-F$separatorChar")
  else
    separatorChar=()
  fi
  awk "${separatorChar[@]}" "{ print length(\$$index) }" | sort -rn | head -1
}

#
# Usage: {fn}
# Outputs the maximum line length passed into stdin
#
maximumLineLength() {
  local max
  max=0
  while IFS= read -r line; do
    if [ "${#line}" -gt "$max" ]; then
      max=${#line}
    fi
  done
  printf "%d" "$max"
}

#
# Outputs the `singular` value to standard out when the value of `number` is one. Otherwise outputs the `plural` value to standard out.
#
# Short description: Output numeric messages which are grammatically accurate
# Usage: plural number singular plural
# Argument: number - An integer or floating point number
# Argument: singular - The singular form of a noun
# Argument: plural - The plural form of a noun
#
# Exit code: 1 - If count is non-numeric
# Exit code: 0 - If count is numeric
# Example:     count=$(($(wc -l < $foxSightings) + 0))
# Example:     printf "We saw %d %s.\n" "$count" "$(plural $count fox foxes)"
# Example:
# Example:     n=$(($(date +%s)) - start))
# Example:     printf "That took %d %s" "$n" "$(plural "$n" second seconds)"
#
plural() {
  local count=${1-}
  if [ "$count" -eq "$count" ] 2>/dev/null; then
    if [ "$((${1-} + 0))" -eq 1 ]; then
      printf %s "${2-}"
    else
      printf %s "${3-}"
    fi
  else
    printf "%s: %s\n" "plural argument is not numeric" "$count" 1>&2
    return 1
  fi
}

#
# Convert text to lowercase
#
# Usage: {fn} [ text ... ]
# Arguments: text - text to convert to lowercase
#
lowercase() {
  while [ $# -gt 0 ]; do
    if [ -n "$1" ]; then
      printf "%s\n" "$1" | tr '[:upper:]' '[:lower:]'
    fi
    shift
  done
}

#
# Convert text to uppercase
#
# Usage: {fn} [ text ... ]
# Arguments: text - text to convert to uppercase
#
uppercase() {
  while [ $# -gt 0 ]; do
    if [ -n "$1" ]; then
      printf "%s\n" "$1" | tr '[:lower:]' '[:upper:]'
    fi
    shift
  done
}

#
# Strip ANSI console escape sequences from a file
# Usage: stripAnsi < input > output
# Argument: None.
# Exit Codes: Zero.
# Local Cache: None.
# Environment: None.
# Write Environment: None.
# Credits: commandlinefu tripleee
# Short description: Remove ANSI escape codes from streams
# Source: https://stackoverflow.com/questions/6534556/how-to-remove-and-all-of-the-escape-sequences-in-a-file-using-linux-shell-sc
# Depends: sed
#
stripAnsi() {
  sed $'s,\x1B\[[0-9;]*[a-zA-Z],,g'
}

#
# listTokens
# Usage: listTokens prefix suffix < input > output
# Argument: `prefix` - Optional prefix for token search, defaults to `{` (same as `map.sh`)
# Argument: `suffix` - Optional suffix for token search, defaults to `}` (same as `map.sh`)
# Exit Codes: Zero.
# Local Cache: None.
# Environment: None.
# Short description: list mappable variables in a file
# Depends: sed quoteSedPattern
#
listTokens() {
  local prefix suffix removeQuotesPattern

  prefix="$(quoteSedPattern "${1-"{"}")"
  suffix="$(quoteSedPattern "${2-"}"}")"

  removeQuotesPattern="s/.*$prefix\([^$suffix]*\)$suffix.*/\1/g"

  # insert newline before all found prefix
  # insert newline after all found suffix
  # remove lines missing a prefix OR missing a suffix
  # remove all content before prefix and after suffix
  # remaining lines are our raw tokens
  # tokens may be any character except prefix or suffix or nul
  sed -e "s/$prefix/\n$prefix/g" -e "s/$suffix/$suffix\n/g" | sed -e "/$prefix/!d" -e "/$suffix/!d" -e "$removeQuotesPattern"
}

# Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff
#
# You can use this as a pipe or pass in arguments which are files to be hashed.
#
# Usage: shaPipe [ filename ... ]
# Argument: filename - One or more filenames to generate a checksum for
# Depends: shasum
# Summary: SHA1 checksum of standard input
# Example:     shaPipe < "$fileName"
# Example:     shaPipe "$fileName0" "$fileName1"
# Output: cf7861b50054e8c680a9552917b43ec2b9edae2b
# Environment: DEBUG_SHAPIPE - When set to a truthy value, will output all requested shaPipe calls to log called `shaPipe.log`.
#
shaPipe() {
  local usage="_${FUNCNAME[0]}"
  local argument
  if [ -n "$*" ]; then
    while [ $# -gt 0 ]; do
      argument="$1"
      [ -f "$1" ] || __failArgument "$usage" "$1 is not a file" || return $?
      [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
      if test "${DEBUG_SHAPIPE-}"; then
        printf "%s: %s\n" "$(date +"%FT%T")" "$argument" >shaPipe.log
      fi
      shasum <"$argument" | cut -f 1 -d ' '
      shift || __failArgument "$usage" "shift failed" || return $?
    done
  else
    if test "${DEBUG_SHAPIPE-}"; then
      printf "%s: stdin\n" "$(date +"%FT%T")" >shaPipe.log
    fi
    shasum | cut -f 1 -d ' ' || __failEnvironment "$usage" "shasum" || return $?
  fi
}
_shaPipe() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff
#
# You can use this as a pipe or pass in arguments which are files to be hashed.
#
# Speeds up shaPipe using modification dates of the files instead.
#
# The `cacheDirectory`
#
# Usage: cachedShaPipe cacheDirectory [ filename ]
# Argument: cacheDirectory - Optional. Directory. The directory where cache files can be stored exclusively for this function. Supports a blank value to disable caching, otherwise, it must be a valid directory.
# Depends: shasum shaPipe
# Summary: SHA1 checksum of standard input
# Example:     cachedShaPipe "$cacheDirectory" < "$fileName"
# Example:     cachedShaPipe "$cacheDirectory" "$fileName0" "$fileName1"
# Output: cf7861b50054e8c680a9552917b43ec2b9edae2b
#
cachedShaPipe() {
  local usage="_${FUNCNAME[0]}"
  local argument

  local cacheDirectory="${1-}"

  shift || __failArgument "$usage" "Missing cacheDirectory" || return $?

  # Special case to skip caching
  if [ -z "$cacheDirectory" ]; then
    shaPipe "$@"
    return $?
  fi
  cacheDirectory="${cacheDirectory%/}"

  [ -d "$cacheDirectory" ] || __failArgument "$usage" "cachedShaPipe: cacheDirectory \"$cacheDirectory\" is not a directory" || return $?
  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      argument="$1"
      [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
      [ -f "$argument" ] || __failArgument "$usage" "not a file $(consoleLabel "$argument")" || return $?
      cacheFile="$cacheDirectory/${argument#/}"
      __environment requireFileDirectory "$cacheFile" || return $?
      if [ -f "$cacheFile" ] && isNewestFile "$cacheFile" "$1"; then
        printf "%s\n" "$(cat "$cacheFile")"
      else
        shaPipe "$argument" | tee "$cacheFile" || __failEnvironment "$usage" shaPipe "$1" || return $?
      fi
      shift || :
    done
  else
    shaPipe
  fi
}
_cachedShaPipe() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Maps a string using an environment file
#
# Usage: mapValue mapFile [ value ... ]
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: mapFile - Required. File. a file containing bash environment definitions
# Argument: value - Optional. String. One or more values to map using said environment file
# Argument: --search-filter - Zero or more. Callable. Filter for search tokens. (e.g. `lowercase`)
# Argument: --replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. `trimSpace`)
mapValue() {
  local usage="_${FUNCNAME[0]}"
  local mapFile searchToken environmentValue searchFilters replaceFilters filter

  mapFile=
  nArguments=$#
  replaceFilters=()
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --search-filter)
        searchFilters+=("$(usageArgumentCallable "$usage" "searchFilter" "$1")") || return $?
        return $?
        ;;
      --replace-filter)
        replaceFilters+=("$(usageArgumentCallable "$usage" "replaceFilter" "$1")") || return $?
        return $?
        ;;
      *)
        if [ -z "$mapFile" ]; then
          mapFile=$(usageArgumentFile "$usage" "mapFile" "${1-}") || return $?
          shift
          break
        else
          __failArgument "$usage" "unknown argument #$argumentIndex: $argument" || return $?
        fi
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done
  [ -n "$mapFile" ] || __failArgument "$usage" "mapFile required" || return $?
  (
    local value environment
    value="$*"
    while read -r environment; do
      environmentValue=$(__usageEnvironment "$usage" environmentValueRead "$mapFile" "$environment") || return $?
      searchToken='{'"$environment"'}'
      if [ ${#searchFilters[@]} -gt 0 ]; then
        for filter in "${searchFilters[@]}"; do
          searchToken=$(__usageEnvironment "$usage" "$filter" "$searchToken") || return $?
        done
      fi
      if [ ${#replaceFilters[@]} -gt 0 ]; then
        for filter in "${replaceFilters[@]}"; do
          environmentValue=$(__usageEnvironment "$usage" "$filter" "$environmentValue") || return $?
        done
      fi
      value="${value/${searchToken}/${environmentValue}}"
    done < <(environmentNames <"$mapFile")
    printf "%s\n" "$value"
  )
}
_mapValue() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Maps a string using an environment file
#
# Usage: {fn} mapFile [ value ... ]
# Argument: mapFile - Required. File. a file containing bash environment definitions
# Argument: value - Optional. String. One or more values to map using said environment file.
#
mapValueTrim() {
  mapValue --replace-filter trimSpace "$@"
}
_mapValueTrim() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: randomString [ ... ]
# Arguments: Ignored
# Depends: shasum, /dev/random
# Description: Outputs 40 random hexadecimal characters, lowercase.
# Example:     testPassword="$(randomString)"
# Output: cf7861b50054e8c680a9552917b43ec2b9edae2b
#
randomString() {
  head --bytes=64 /dev/random | shasum | cut -f 1 -d ' '
}

#
# Usage: stringOffset needle haystack
# Outputs the integer offset of `needle` if found as substring in `haystack`
# If `haystack` is not found, -1 is output
#
stringOffset() {
  local length=${#2}
  local substring="${2/${1-}*/}"
  local offset="${#substring}"
  if [ "$offset" -eq "$length" ]; then
    offset=-1
  fi
  printf %d "$offset"
}

_mapEnvironmentGenerateSedFile() {
  # IDENTICAL _mapEnvironmentGenerateSedFile 11
  local i

  for i in "$@"; do
    case "$i" in
      *[%{}]*) ;;
      LD_*) ;;
      *)
        printf "s/%s/%s/g\n" "$(quoteSedPattern "$prefix$i$suffix")" "$(quoteSedPattern "${!i-}")" || _environment "${FUNCNAME[0]}" || return $?
        ;;
    esac
  done
}

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# Usage: {fn} [ environmentName0 environmentName1 ... ]
# TODO: Do this like mapValue
# See: mapValue
# Argument: environmentName0 - Map this value only. If not specified, all environment variables are mapped.
# Environment: Argument-passed or entire environment variables which are exported are used and mapped to the destination.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
mapEnvironment() {
  # IDENTICAL mapEnvironment 94 137
  local this argument
  local prefix suffix sedFile ee e rs

  this="${FUNCNAME[0]}"
  prefix='{'
  suffix='}'

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || _argument "blank argument" || return $?
    case "$argument" in
      --prefix)
        shift || _argument "$this: missing $argument argument" || return $?
        prefix="$1"
        ;;
      --suffix)
        shift || _argument "$this: missing $argument argument" || return $?
        suffix="$1"
        ;;
      *)
        break
        ;;
    esac
    shift || _argument "shift failed after $argument" || return $?
  done

  ee=("$@")
  if [ $# -eq 0 ]; then
    while read -r e; do ee+=("$e"); done < <(environmentVariables)
    for e in $(environmentVariables); do ee+=("$e"); done
  fi
  sedFile=$(mktemp) || _environment "mktemp failed" || return $?
  rs=0
  if __environment _mapEnvironmentGenerateSedFile "${ee[@]}" >"$sedFile"; then
    if ! sed -f "$sedFile"; then
      rs=$?
      cat "$sedFile" 1>&2
    fi
  else
    rs=$?
  fi
  rm -f "$sedFile" || :
  return $rs
}

characterClasses() {
  printf "%s\n" alnum alpha ascii blank cntrl digit graph lower print punct space upper word xdigit
}

#
# Usage: {fn} className character0 [ character1 ... ]
#
# Poor-man's bash character class matching
#
# Returns true if all `characters` are of `className`
#
# `className` can be one of:
#     alnum   alpha   ascii   blank   cntrl   digit   graph   lower
#     print   punct   space   upper   word    xdigit
#
isCharacterClass() {
  local class="${1-}" character
  local usage

  usage="_${FUNCNAME[0]}"

  case "$class" in
    alnum | alpha | ascii | blank | cntrl | digit | graph | lower | print | punct | space | upper | word | xdigit) ;;
    *)
      __failArgument "$usage" "Invalid class: $class" || return $?
      ;;
  esac
  shift || __failArgument "$usage" "shift failed" || return $?
  while [ $# -gt 0 ]; do
    character="${1:0:1}"
    character="$(escapeBash "$character")"
    # Not sure how you can hack this function with single character eval injections.
    # evalCheck: SAFE 2024-01-29 KMD
    if ! eval "case $character in [[:$class:]]) ;; *) return 1 ;; esac"; then
      return 1
    fi
    shift || __failArgument "$usage" "shift $character failed" || return $?
  done
}
_isCharacterClass() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Does this character match one or more character classes?
#
# Usage: {fn} character [ class0 class1 ... ]
# Argument: character - Required. Single character to test.
# Argument: class0 - Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any).
#
isCharacterClasses() {
  local character class
  local usage

  usage="_${FUNCNAME[0]}"

  character="${1-}"
  [ "${#character}" -eq 1 ] || __failArgument "$usage" "Non-single character: \"$character\"" || return $?
  if ! shift || [ $# -eq 0 ]; then
    __failArgument "$usage" "Need at least one class" || return $?
  fi
  while [ "$#" -gt 0 ]; do
    class="$1"
    if [ "${#class}" -eq 1 ]; then
      if [ "$class" = "$character" ]; then
        return 0
      fi
    elif isCharacterClass "$class" "$character"; then
      return 0
    fi
    shift || __failArgument "$usage" "shift $class failed" || return $?
  done
  return 1
}
_isCharacterClasses() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Given a list of integers, output the character codes associated with them (e.g. `chr` in other languages)
# Credit: dsmsk80
#
# Source: https://mywiki.wooledge.org/BashFAQ/071
characterFromInteger() {
  local usage="_${FUNCNAME[0]}"
  local arg
  while [ $# -gt 0 ]; do
    arg="$1"
    __usageArgument "$usage" isUnsignedInteger "$arg" || return $?
    [ "$arg" -lt 256 ] || __failArgument "$usage" "Integer out of range: \"$arg\"" || return $?
    # shellcheck disable=SC2059
    printf "\\$(printf '%03o' "$arg")"
    shift || __failArgument "$usage" "shift $arg failed" || return $?
  done
}
_characterFromInteger() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} text class0 [ ... ]
# Argument: text - Text to validate
# Argument: class0 - One ore more character classes that the characters in string should match
#
stringValidate() {
  local usage="_${FUNCNAME[0]}"
  local text character

  text="${1-}"
  shift || __failArgument "$usage" "missing text" || return $?
  [ $# -gt 0 ] || __failArgument "$usage" "missing class" || return $?
  for character in $(printf "%s" "$text" | grep -o .); do
    if ! isCharacterClasses "$character" "$@"; then
      return 1
    fi
  done
}
_stringValidate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} [ character ... ]
# Convert one or more characters from their ascii representation to an integer value.
# Requires a single character to be passed
#
characterToInteger() {
  local index

  index=0
  while [ $# -gt 0 ]; do
    index=$((index + 1))
    [ "${#1}" = 1 ] || __failArgument "$usage" "Single characters only (argument #$index): \"$1\" (${#1} characters)" || return $?
    LC_CTYPE=C printf '%d' "'$1" || __failEnvironment "$usage" "Single characters only (argument #$index): \"$1\" (${#1} characters)" || return $?
    shift || __failArgument "$usage" "shift failed" || return $?
  done
}
_characterToInteger() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn}
#
# Write a report of the character classes
#
characterClassReport() {
  local arg character classList indexList outer matched total classOuter outerList innerList nouns outerText width

  classOuter=false
  while [ $# -gt 0 ]; do
    arg="$1"
    [ -n "$arg" ] || __failArgument "$usage" "blank argument" || return $?
    case "$arg" in
      --class)
        classOuter=true
        ;;
      --char)
        classOuter=false
        ;;
    esac
    shift || __failArgument "$usage" "shift $arg failed" || return $?
  done
  classList=()
  for arg in $(characterClasses); do
    classList+=("$arg")
  done
  # shellcheck disable=SC2207
  indexList=($(seq 0 127))

  if $classOuter; then
    outerList=("${classList[@]}")
    innerList=("${indexList[@]}")
    nouns=("character" "characters")
  else
    # shellcheck disable=SC2207
    outerList=("${indexList[@]}")
    innerList=("${classList[@]}")
    nouns=("class" "classes")
  fi
  total=0
  for outer in "${outerList[@]}"; do
    matched=0
    if $classOuter; then
      class="$outer"
      outerText="$(consoleLabel "$(alignRight 10 "$outer")")"
    else
      character=$(characterFromInteger "$outer")
      if ! isCharacterClass print "$character"; then
        outerText="$(printf "x%x " "$outer")"
        outerText="$(alignRight 5 "$outerText")"
        outerText="$(consoleSubtle "$outerText")"
      else
        outerText="$(consoleBlue "$(alignRight 5 "$character")")"
      fi
    fi
    printf "%s: " "$(alignLeft "$width" "$outerText")"
    for inner in "${innerList[@]}"; do
      if $classOuter; then
        character=$(characterFromInteger "$inner")
      else
        class="$inner"
      fi
      if isCharacterClass "$class" "$character"; then
        matched=$((matched + 1))
        if $classOuter; then
          if ! isCharacterClass print "$character"; then
            printf "%s " "$(consoleSubtle "$(printf "x%x" "$inner")")"
          else
            printf "%s " "$(consoleBlue "$(characterFromInteger "$inner")")"
          fi
        else
          printf "%s " "$(consoleBlue "$class")"
        fi
      fi
    done
    printf "[%s %s]\n" "$(consoleBoldMagenta "$matched")" "$(consoleSubtle "$(plural "$matched" "${nouns[@]}")")"
    total=$((total + matched))
  done
  printf "%s total %s\n" "$(consoleBoldRed "$total")" "$(consoleRed "$(plural "$total" "${nouns[@]}")")"
}

#
# fn: cannon.sh
# Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.
#
# This can break your files so use with caution.
#
# Example:     cannon master main ! -path '*/old-version/*')
# _cannon: cannon fromText toText [ findArgs ... ]
# Argument: fromText - Required. String of text to search for.
# Argument: toText - Required. String of text to replace.
# Argument: findArgs ... - Any additional arguments are meant to filter files.
# Exit Code: 0 - Success
# Exit Code: 1 - Arguments are identical
#
#
cannon() {
  local search searchQuoted replace replaceQuoted cannonLog count
  local usage

  usage="_${FUNCNAME[0]}"

  search=
  replace=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      *)
        if [ -z "$search" ]; then
          search="$argument"
        elif [ -z "$replace" ]; then
          replace="$argument"
        else
          break
        fi
        ;;
    esac
    shift
  done
  searchQuoted=$(quoteSedPattern "$search")
  replaceQuoted=$(quoteSedPattern "$replace")
  [ "$searchQuoted" != "$replaceQuoted" ] || __failArgument "$usage" "from = to \"$search\" are identical" || return $?
  cannonLog=$(mktemp)
  if ! find . -type f ! -path '*/.*' "$@" -print0 >"$cannonLog"; then
    printf "%s\n" "$(consoleSucces "# \"")$(consoleCode "$1")$(consoleSuccess "\" Not found")"
    rm "$cannonLog" || :
    return 0
  fi
  xargs -0 grep -l "$search" <"$cannonLog" | tee "$cannonLog.found" | xargs sed -i '' -e "s/$searchQuoted/$replaceQuoted/g"
  count="$(($(wc -l <"$cannonLog.found") + 0))"
  consoleSuccess "Modified $(consoleCode "$count $(plural "$count" file files)")"
  rm -f "$cannonLog" "$cannonLog.found" || :
}
_cannon() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove fields from left to right from a text file as a pipe
# Usage: {fn} fieldCount < input > output
# Argument: fieldCount - Optional. Integer. Number of field to remove. Default is just first `1`.
# Partial Credit: https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899
removeFields() {
  local usage="_${FUNCNAME[0]}"
  local argument

  local fieldCount=1
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      *)
        isUnsignedInteger "$argument" || __failArgument "$usage" "fieldCount should be integer: $(consoleCode "$argument")" || return $?
        [ "$argument" -gt 0 ] || __failArgument "$usage" "fieldCount can not be 0" || return $?
        fieldCount="$argument"
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(consoleLabel "$argument")" || return $?
  done
  awk '{for(i=0;i<'"$fieldCount"';i++){sub($1 FS,"")}}1'
}

# Usage: {fn} separator text0 arg1 ...
# Argument: separator - Required. String. Single character to join elements.
# Argument: text0 - Optional. String. One or more strings to join
joinArguments() {
  local IFS="$1"
  shift || :
  printf "%s" "$*"
}

#
# Usage: {fn} listValue separator [ --first | --last | item ]
# Argument: listValue - Required. Path value to modify.
# Argument: separator - Required. Separator string for item values (typically `:`)
# Argument: --first - Optional. Place any items after this flag first in the list
# Argument: --last - Optional. Place any items after this flag last in the list. Default.
# Argument: item - the path to be added to the `listValue`
#
listAppend() {
  local usage="_${FUNCNAME[0]}"
  local argument listValue="${1-}" separator="${2-}"

  shift 2 || __failArgument "$usage" "Missing arguments" || return $?
  firstFlag=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$1" in
      --first)
        firstFlag=true
        ;;
      --last)
        firstFlag=false
        ;;
      *)
        if [ "$(stringOffset "$argument$separator" "$separator$separator$listValue$separator")" -lt 0 ]; then
          [ -d "$argument" ] || __failEnvironment "$usage" "not a directory $(consoleCode "$argument")" || return $?
          if [ -z "$listValue" ]; then
            listValue="$argument"
          elif "$firstFlag"; then
            listValue="$argument$separator${listValue#"$separator"}"
          else
            listValue="${listValue%"$separator"}$separator$argument"
          fi
        fi
        ;;
    esac
    shift || __failArgument "$usage" "shift $argument" || return $?
  done
  printf "%s\n" "$listValue"
}
_listAppend() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Removes duplicates from a list and maintains ordering.
#
# Usage: {fn} separator listText
# Argument: --help - Optional. Flag. This help.
# Argument: --removed - Optional. Flag. Show removed items instead of the new list.
#
listCleanDuplicates() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local item items removed=() separator="" removedFlag=false

  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --removed)
        removedFlag=true
        ;;
      *)
        if [ -z "$separator" ]; then
          separator="$argument"
        else
          break
        fi
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done

  shift
  newItems=()
  while [ $# -gt 0 ]; do
    IFS="$separator" read -r -a items < <(printf "%s\n" "$1")
    for item in "${items[@]}"; do
      if ! tempPath=$(listAppend "$tempPath" "$separator" "$item"); then
        removed+=("$item")
      else
        newItems+=("$item")
      fi
    done
    if $removedFlag; then
      IFS="$separator" printf "%s\n" "${removed[*]}"
    else
      IFS="$separator" printf "%s\n" "${newItems[*]}"
    fi
  done
}
_listCleanDuplicates() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
