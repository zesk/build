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

# Check if text contains mappable tokens
# If any text passed contains a token which can be mapped, succeed.
# Argument: --prefix - Optional. String. Token prefix defaults to `{`.
# Argument: --suffix - Optional. String. Token suffix defaults to `}`.
# Argument: --token - Optional. String. Classes permitted in a token
# Argument: text - Optional. String. Text to search for mapping tokens.
isMappable() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local prefix='{' suffix='}' tokenClasses='[-_A-Za-z0-9:]'

  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --token)
        shift
        tokenClasses="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --prefix)
        shift
        prefix=$(quoteGrepPattern "$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --suffix)
        shift
        suffix=$(quoteGrepPattern "$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      *)
        if printf "%s\n" "$1" | grep -q -e "$prefix$tokenClasses$tokenClasses*$suffix"; then
          return 0
        fi
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done
  return 1
}
_isMappable() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

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

# Usage: {fn} haystack needle ...
# Argument: haystack - Required. String. String to search.
# Argument: needle - Optional. String. One or more strings to find as a substring of `haystack`.
# Exit Code: 0 - IFF ANY needle matches as a substring of haystack
substringFound() {
  local haystack="${1-}"
  shift
  while [ $# -gt 0 ]; do
    if [ -n "$1" ]; then
      ! isSubstring "$1" "$haystack" || return 0
    fi
    shift
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
  local element=${1-} item
  shift || return 1
  for item; do
    [ "${item#*"$element"}" = "$item" ] || return 0
    shift
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
  while [ $# -gt 0 ] && [ ${#words[@]} -lt $wordCount ]; do
    IFS=' ' read -ra argumentWords <<<"${1-}"
    for argumentWord in "${argumentWords[@]+${argumentWords[@]}}"; do
      words+=("$argumentWord")
      if [ ${#words[@]} -ge $wordCount ]; then
        break
      fi
    done
    shift
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
# Argument: --prefix - Optional. String. Token prefix defaults to `{`.
# Argument: --suffix - Optional. String. Token suffix defaults to `}`.
# Argument: --search-filter - Zero or more. Callable. Filter for search tokens. (e.g. `lowercase`)
# Argument: --replace-filter - Zero or more. Callable. Filter for replacement strings. (e.g. `trimSpace`)
mapValue() {
  local usage="_${FUNCNAME[0]}"
  local mapFile searchToken environmentValue searchFilters replaceFilters filter prefix='{' suffix='}'

  mapFile=
  nArguments=$#
  searchFilters=()
  replaceFilters=()
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --prefix)
        shift
        prefix=$(usageArgumentString "$usage" "$argument" "${1-}")
        ;;
      --suffix)
        shift
        suffix=$(usageArgumentString "$usage" "$argument" "${1-}")
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
      searchToken="$prefix$environment$suffix"
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

# List the valid character classes allowed in `isCharacterClass`
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
  local class="${1-}" classes character
  local usage

  usage="_${FUNCNAME[0]}"
  IFS=$'\n' read -r -d '' -a classes < <(characterClasses)
  inArray "$class" "${classes[@]}" || __failArgument "$usage" "Invalid class: $class" || return $?
  shift
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
    if [ "$arg" -eq 0 ]; then
      printf "%s\n" $'\0'
    else
      # shellcheck disable=SC2059
      printf "\\$(printf '%03o' "$arg")"
    fi
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
# Argument: --help - Optional. Flag. Display this help.
# Argument: --class - Optional. Flag. Show class and then characters in that class.
# Argument: --char - Optional. Flag. Show characters and then class for that character.
characterClassReport() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local arg character classList indexList outer matched total classOuter=false outerList innerList nouns outerText width=5
  local savedLimit

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --class)
        classOuter=true
        ;;
      --char)
        classOuter=false
        ;;
      *)
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  classList=()
  for arg in $(characterClasses); do
    classList+=("$arg")
  done

  savedLimit="$(__usageEnvironment "$usage" ulimit -n)" || return $?
  __usageEnvironment "$usage" ulimit -n 10240 || return $?
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
      character="$(characterFromInteger "$outer")" 2>/dev/null
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
        character="$(characterFromInteger "$inner")"
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
  __usageEnvironment "$usage" ulimit -n "$savedLimit" || return $?
}
_characterClassReport() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# See: cannon.sh
# Usage: cannon [ --path directory ] [ --help ] fromText toText [ findArgs ... ]
# Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.
#
# This can break your files so use with caution. Blank searchText is not allowed.
#
# Example:     {fn} master main ! -path '*/old-version/*')
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --path directory - Optional. Directory. Run cannon operation starting in this directory.
# Argument: fromText - Required. String of text to search for.
# Argument: toText - Required. String of text to replace.
# Argument: findArgs ... - Optional. FindArgument. Any additional arguments are meant to filter files.
# Exit Code: 0 - Success
# Exit Code: 1 - --path is not a directory
# Exit Code: 1 - searchText is not blank
# Exit Code: 1 - mktemp failed
# Exit Code: 2 - Arguments are identical
cannon() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local searchQuoted replaceQuoted cannonLog count
  local search="" directory="." replace=""

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --path)
        shift
        directory=$(usageArgumentDirectory "$usage" "$argument" "${1-}")
        ;;
      *)
        if [ -z "$search" ]; then
          search="$(usageArgumentString "$usage" "searchText" "$argument")"
        elif [ -z "$replace" ]; then
          replace="$argument"
          shift
          break
        fi
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done
  searchQuoted=$(quoteSedPattern "$search")
  replaceQuoted=$(quoteSedPattern "$replace")
  [ "$searchQuoted" != "$replaceQuoted" ] || __failArgument "$usage" "from = to \"$search\" are identical" || return $?
  cannonLog=$(__usageEnvironment "$usage" mktemp) || return $?
  if ! find "$directory" -type f ! -path "*/.*/*" "$@" -print0 >"$cannonLog"; then
    printf "%s\n" "$(consoleSuccess "# \"")$(consoleCode "$1")$(consoleSuccess "\" Not found")"
    rm "$cannonLog" || :
    return 0
  fi
  xargs -0 grep -l "$search" <"$cannonLog" >"$cannonLog.found"
  count="$(($(wc -l <"$cannonLog.found") + 0))"
  if [ "$count" -eq 0 ]; then
    consoleInfo "Modified (NO) files"
  else
    local inPlaceArguments
    if [ "$(uname -s)" = "Darwin" ]; then inPlaceArguments=('-i' ''); else inPlaceArguments=('--in-place'); fi
    __usageEnvironment "$usage" xargs sed "${inPlaceArguments[@]}" -e "s/$searchQuoted/$replaceQuoted/g" <"$cannonLog.found" || return $?
    consoleSuccess "Modified $(consoleCode "$count $(plural "$count" file files)")"
  fi
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
  local argument nArguments argumentIndex
  local fieldCount="" fields=()

  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      *)
        [ -z "$fieldCount" ] || __failArgument "$usage" "Only one fieldCount should be provided argument #$argumentIndex: $argument" || return $?
        fieldCount="$(usageArgumentPositiveInteger "$usage" "fieldCount" "$argument")" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(consoleLabel "$argument")" || return $?
  done
  fieldCount=${fieldCount:-1}
  #  awk '{for(i=0;i<'"${fieldCount:-1}"';i++){sub($1 FS,"")}}1'
  while IFS=' ' read -d $'\n' -r -a fields; do
    echo "${fields[@]:$fieldCount}"
  done
}
_removeFields() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  # IDENTICAL usageDocument 1
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
  local item items removed=() separator="" removedFlag=false IFS

  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --test)
        shift
        test=$(usageArgumentCallable "$usage" "$argument" "${1-}") || return $?
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

  newItems=()
  while [ $# -gt 0 ]; do
    IFS="$separator" read -r -a items < <(printf "%s\n" "$1")
    for item in "${items[@]}"; do
      if [ -n "$test" ] && "$test" "$item" || ! tempPath=$(listAppend "$tempPath" "$separator" "$item"); then
        removed+=("$item")
      else
        newItems+=("$item")
      fi
    done
    shift
  done
  IFS="$separator"
  if $removedFlag; then
    printf "%s\n" "${removed[*]}"
  else
    printf "%s\n" "${newItems[*]}"
  fi
}
_listCleanDuplicates() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL mapEnvironment 71

# Summary: Convert tokens in files to environment variable values
#
# Map tokens in the input stream based on environment values with the same names.
# Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
# Undefined values are not converted.
# Usage: {fn} [ environmentName ... ]
# TODO: Do this like mapValue
# See: mapValue
# Argument: environmentName - Optional. String. Map this value only. If not specified, all environment variables are mapped.
# Argument: --prefix - Optional. String. Prefix character for tokens, defaults to `{`.
# Argument: --suffix - Optional. String. Suffix character for tokens, defaults to `}`.
# Environment: Argument-passed or entire environment variables which are exported are used and mapped to the destination.
# Example:     printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE
mapEnvironment() {
  local __arg
  local __prefix __suffix __sedFile __ee __e

  __prefix='{'
  __suffix='}'

  while [ $# -gt 0 ]; do
    __arg="$1"
    [ -n "$__arg" ] || _argument "blank argument" || return $?
    case "$__arg" in
      --prefix)
        shift
        [ -n "${1-}" ] || _argument "blank $__arg argument" || return $?
        __prefix="$1"
        ;;
      --suffix)
        shift
        [ -n "${1-}" ] || _argument "blank $__arg argument" || return $?
        __suffix="$1"
        ;;
      *)
        break
        ;;
    esac
    shift || _argument "shift failed after $__arg" || return $?
  done

  __ee=("$@")
  if [ $# -eq 0 ]; then
    while read -r __e; do __ee+=("$__e"); done < <(environmentVariables)
  fi
  __sedFile=$(__environment mktemp) || return $?
  if __environment _mapEnvironmentGenerateSedFile "$__prefix" "$__suffix" "${__ee[@]}" >"$__sedFile"; then
    if ! sed -f "$__sedFile"; then
      cat "$__sedFile" 1>&2
      _environment "sed failed" || return $?
    fi
  fi
  rm -f "$__sedFile" || :
}

# Helper function
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

# IDENTICAL quoteSedPattern 27

# Summary: Quote sed search strings for shell use
# Quote a string to be used in a sed pattern on the command line.
# Usage: quoteSedPattern text
# Argument: text - Text to quote
# Output: string quoted and appropriate to insert in a sed search or replacement phrase
# Example:     sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"
# needSlash='$.*/[\]^'
quoteSedPattern() {
  local value
  value=$(printf -- "%s\n" "${1-}" | sed 's~\([][$/'$'\t''^\\.*+?]\)~\\\1~g')
  value="${value//$'\n'/\\n}"
  printf "%s\n" "$value"
}

# Summary: Quote sed replacement strings for shell use
# Usage: quoteSedReplacement text separatorChar
# Argument: text - Text to quote
# Output: string quoted and appropriate to insert in a sed search or replacement phrase
# Example:     sed "s/$(quoteSedPattern "$1")/$(quoteSedReplacement "$2")/g"
# needSlash='$.*/[\]^'
quoteSedReplacement() {
  local value separator="${2-/}"
  value=$(printf -- "%s\n" "${1-}" | sed 's~\([\&'"$separator"']\)~\\\1~g')
  value="${value//$'\n'/\\n}"
  printf "%s\n" "$value"
}

# Usage: {fn} printfArguments
# Pipe to output some text before any output, otherwise, nothing is output.
printfOutputPrefix() {
  local prefixed=false
  while read -r line; do
    if ! $prefixed; then
      # shellcheck disable=SC2059
      printf "$@"
      prefixed=true
    fi
    printf "%s\n" "$line"
  done
}

# Usage: {fn} printfArguments
# Pipe to output some text after any output, otherwise, nothing is output.
printfOutputSuffix() {
  local output=false
  while read -r line; do
    if ! $output; then
      output=true
    fi
    printf "%s\n" "$line"
  done
  # shellcheck disable=SC2059
  ! $output || printf "$@"
}

# Unquote a string
# Argument: quote - String. Required. Must match beginning and end of string.
# Argument: value - String. Required. Value to unquote.
unquote() {
  local quote="$1" value="$2"
  if [ "$value" != "${value#"$quote"}" ] && [ "$value" != "${value%"$quote"}" ]; then
    value="${value#"$quote"}"
    value="${value%"$quote"}"
  fi
  printf "%s\n" "$value"
}

# Primary case to unquote quoted things "" ''
__unquote() {
  local value="${1-}"
  case "${value:0:1}" in
    "'") value="$(unquote "'" "$value")" ;;
    '"') value="$(unquote '"' "$value")" ;;
    *) ;;
  esac
  printf "%s\n" "$value"
}
