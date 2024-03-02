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

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

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
  value=$(printf %s "$1" | sed 's/\([\\.*+?]\)/\\\1/g')
  value="${value//\//\\/}"
  value="${value//[/\\[}"
  value="${value//]/\\]}"
  value="${value//$'\n'/\\n}"
  printf %s "$value"
}

#
# Quote strings for inclusion in shell quoted strings
# Usage: escapeSingleQuotes text
# Argument: text - Text to quote
# Output: Single quotes are prefixed with a backslash
# Example:     escapeSingleQuotes "Now I can't not include this in a bash string."
#
escapeDoubleQuotes() {
  printf %s "${1//\"/\\\"}"
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
  printf %s "$1" | sed "s/'/\\\'/g"
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
  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      var="$1"
      # remove leading whitespace characters
      var="${var#"${var%%[![:space:]]*}"}"
      # remove trailing whitespace characters
      if ! shift || ! printf %s "${var%"${var##*[![:space:]]}"}"; then
        _trimSpace "$errorEnvironment" "printf failed"
      fi
    done
  else
    awk '{$1=$1};NF'
  fi
}
_trimSpace() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Deprecated: 2024-02
# trimSpace handles both cases now.
# Usage: trimSpace < file > output
# Summary: Trim whitespace in a pipeline
# Depends: awk
# See: trimSpace
#
trimSpacePipe() {
  trimSpace "$@"
}

#
# Quote bash strings for inclusion as single-quoted for eval
# Usage: quoteBashString text
# Argument: text - Text to quote
# Output: string quoted and appropriate to assign to a value in the shell
# Depends: sed
# Example:     name="$(quoteBashString "$name")"
quoteBashString() {
  printf '%s' "$1" | sed 's/\([$`<>'\'']\)/\\\1/g'
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
# Usage: lowercase [ text ... ]
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

  prefix="$(quoteSedPattern "${1-{}")"
  suffix="${2-\\}}"

  removeQuotesPattern="s/.*$prefix\([a-zA-Z0-9_]*\)$suffix.*/\1/g"

  # insert newline after all found suffix
  # remove lines missing a prefix and missing a suffix
  # remove all content before prefix and after suffix
  # remaining lines are our tokens
  sed "s/$suffix/$suffix\n/g" | sed -e "/$prefix/!d" -e "/$suffix/!d" -e "$removeQuotesPattern"
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
  if [ -n "$*" ]; then
    while [ $# -gt 0 ]; do
      if [ ! -f "$1" ]; then
        consoleError "$1 is not a file" 1>&2
        return "$errorArgument"
      fi
      if test "${DEBUG_SHAPIPE-}"; then
        printf "%s: %s\n" "$(date +"%FT%T")" "$1" >shaPipe.log
      fi
      shasum <"$1" | cut -f 1 -d ' '
      shift
    done
  else
    if test "${DEBUG_SHAPIPE-}"; then
      printf "%s: stdin\n" "$(date +"%FT%T")" >shaPipe.log
    fi
    shasum | cut -f 1 -d ' '
  fi
}

# Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff
#
# You can use this as a pipe or pass in arguments which are files to be hashed.
#
# Speeds up shaPipe using modification dates of the files instead.
#
# The cacheDirectory
#
# Usage: cachedShaPipe cacheDirectory [ filename ]
# Argument: cacheDirectory - The directory where cache files can be stored exclusively for this function. Supports a blank value to disable caching, otherwise, it must be a valid directory.
# Depends: shasum
# Summary: SHA1 checksum of standard input
# Example:     cachedShaPipe "$cacheDirectory" < "$fileName"
# Example:     cachedShaPipe "$cacheDirectory" "$fileName0" "$fileName1"
# Output: cf7861b50054e8c680a9552917b43ec2b9edae2b
#
cachedShaPipe() {
  local cacheDirectory="${1%%/}"

  # Special case to skip caching
  shift
  if [ -z "$cacheDirectory" ]; then
    shaPipe "$@"
    return $?
  fi

  if [ ! -d "$cacheDirectory" ]; then
    consoleError "cachedShaPipe: cacheDirectory \"$cacheDirectory\" is not a directory" 1>&2
    return $errorArgument
  fi
  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      if [ ! -f "$1" ]; then
        consoleError "$1 is not a file" 1>&2
        return "$errorArgument"
      fi
      cacheFile="$cacheDirectory/${1##/}"
      if ! requireFileDirectory "$cacheFile"; then
        return "$errorEnvironment"
      fi
      if [ -f "$cacheFile" ] && isNewestFile "$cacheFile" "$1"; then
        printf "%s\n" "$(cat "$cacheFile")"
      else
        shaPipe "$1" | tee "$cacheFile"
      fi
      shift
    done
  else
    shaPipe
  fi

}

# Maps a string using an environment file
#
# Usage: mapValue mapFile [ value ... ]
# Argument: mapFile - a file containing bash environment definitions
# Argument: value - One or more values to map using said environment file
#
mapValue() {
  local name value searchToken mapFile="${1-}"

  shift
  if [ ! -f "$mapFile" ]; then
    consoleError "mapValue - \"$mapFile\" is not a file" 1>&2
    return $errorArgument
  fi
  (
    set -a
    # shellcheck source=/dev/null
    source "$mapFile"
    set +a
    value="$*"
    while read -r name; do
      searchToken='{'"$name"'}'
      value="${value/${searchToken}/${!name-}}"
    done < <(environmentVariables)
    printf "%s" "$value"
  )
}

# Maps a string using an environment file
#
# Usage: mapValue mapFile [ value ... ]
# Argument: mapFile - a file containing bash environment definitions
# Argument: value - One or more values to map using said environment file
#
mapValueTrim() {
  local name value replace searchToken mapFile="${1-}"

  shift
  if [ ! -f "$mapFile" ]; then
    consoleError "mapValue - \"$mapFile\" is not a file" 1>&2
    return $errorArgument
  fi
  (
    set -a
    # shellcheck source=/dev/null
    source "$mapFile"
    set +a
    value="$*"
    while read -r name; do
      searchToken='{'"$name"'}'
      replace="$(trimSpace "${!name-}")"
      value="${value/${searchToken}/${replace}}"
    done < <(environmentVariables)
    printf "%s" "$value"
  )
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
  # IDENTICAL _mapEnvironmentGenerateSedFile 12
  local sedFile=$1 value

  shift
  for i in "$@"; do
    case "$i" in
      *[%{}]*) ;;
      LD_*) ;;
      *)
        printf "s/%s/%s/g\n" "$(quoteSedPattern "$prefix$i$suffix")" "$(quoteSedPattern "${!i-}")" >>"$sedFile"
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
  # IDENTICAL mapEnvironment 745 786
  local prefix suffix sedFile ee e rs

  prefix='{'
  suffix='}'

  while [ $# -gt 0 ]; do
    case $1 in
      --prefix)
        shift || usage $errorArgument "--prefix missing a value"
        prefix="$1"
        ;;
      --suffix)
        shift || usage $errorArgument "--suffix missing a value"
        suffix="$1"
        ;;
      *)
        break
        ;;
    esac
    shift
  done

  sedFile=$(mktemp)

  if [ $# -eq 0 ]; then
    ee=()
    for e in $(environmentVariables); do
      ee+=("$e")
    done
    _mapEnvironmentGenerateSedFile "$sedFile" "${ee[@]}"
  else
    _mapEnvironmentGenerateSedFile "$sedFile" "$@"
  fi

  if ! sed -f "$sedFile"; then
    rs=$?
    cat "$sedFile" 1>&2
    rm "$sedFile"
    return $rs
  fi
  rm "$sedFile"
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
  local class="${1-}"
  case "$class" in
    alnum | alpha | ascii | blank | cntrl | digit | graph | lower | print | punct | space | upper | word | xdigit) ;;
    *)
      _isCharacterClass "$errorArgument" "Invalid class: $class" || return $?
      ;;
  esac
  shift || _isCharacterClass "$errorArgument" "shift failed" || return $?
  while [ $# -gt 0 ]; do
    # Not sure how you can hack this function with single character eval injections.
    # evalCheck: SAFE 2024-01-29 KMD
    if ! eval "case $(escapeBash "${1:0:1}") in [[:$class:]]) ;; *) return 1 ;; esac"; then
      return 1
    fi
    shift
  done
}
_isCharacterClass() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Given a list of integers, output the character codes associated with them
# Credit: dsmsk80
# See: chr
# Source: https://mywiki.wooledge.org/BashFAQ/071
characterFromInteger() {
  while [ $# -gt 0 ]; do
    if ! isUnsignedInteger "$1"; then
      _characterFromInteger "$errorArgument" "Not integer: \"$1\"" || return $?
    fi
    if [ "$1" -ge 256 ]; then
      _characterFromInteger "$errorArgument" "Integer out of range: \"$1\"" || return $?
    fi
    # shellcheck disable=SC2059
    printf "\\$(printf '%03o' "$1")"
    shift || :
  done
}
_characterFromInteger() {
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
    if [ "${#1}" != 1 ]; then
      _characterToInteger "$errorArgument" "Single characters only (argument #$index): \"$1\" (${#1} characters)" || return $?
    fi
    if ! LC_CTYPE=C printf '%d' "'$1"; then
      _characterToInteger "$errorEnvironment" "Single characters only (argument #$index): \"$1\" (${#1} characters)" || return $?
    fi
    shift || :
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
  local arg character class index matched total

  while [ $# -gt 0 ]; do
    arg="$1"
    if [ -z "$arg" ]; then
      _characterClassReport "$errorArgument" "blank argument" || return $?
    fi
    shift || _characterClassReport "$errorArgument" "shift $arg failed" || return $?
  done
  total=0
  for class in $(characterClasses); do
    matched=0
    printf "%s: " "$(consoleLabel "$(alignLeft 10 "$class")")"
    for index in $(seq 0 127); do
      character=$(characterFromInteger "$index")
      if isCharacterClass "$class" "$character"; then
        matched=$((matched + 1))
        if ! isCharacterClass print "$character"; then
          consoleSubtle -n "$(printf "x%x " "$index")"
        else
          printf "%s " "$(consoleBlue "$(characterFromInteger "$index")")"
        fi
      fi
    done
    printf "[%s %s]\n" "$(consoleBoldMagenta "$matched")" "$(consoleSubtle "$(plural "$matched" character characters)")"
    total=$((total + matched))
  done
  printf "%s total %s\n" "$(consoleBoldRed "$total")" "$(consoleRed "$(plural "$total" character characters)")"
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
  local search searchQuoted replaceQuoted cannonLog count

  if [ -z "${1-}" ]; then
    _cannon "$errorArgument" "Empty search string"
    return $?
  fi
  search=${1-}
  searchQuoted=$(quoteSedPattern "$search")
  shift || _cannon "$errorArgument" "Missing replacement argument"
  if [ -z "${1-}" ]; then
    _cannon "$errorArgument" "Empty replacement string"
    return $?
  fi
  replaceQuoted=$(quoteSedPattern "${1-}")
  shift || _cannon "$errorArgument" "shift fail" || return $?
  if [ "$searchQuoted" = "$replaceQuoted" ]; then
    _cannon "$errorArgument" "from to \"$search\" are identical"
  fi

  cannonLog=$(mktemp)
  if ! find . -type f ! -path '*/.*' "$@" -print0 >"$cannonLog"; then
    printf "%s\n" "$(consoleSucces "# \"")$(consoleCode "$1")$(consoleSuccess "\" Not found")"
    rm "$cannonLog" || :
    return 0
  fi
  xargs -0 grep -l "$search" <"$cannonLog" | tee "$cannonLog.found" | xargs sed -i '' -e "s/$searchQuoted/$replaceQuoted/g"
  count="$(wc -l <"$cannonLog.found" | trimSpace)"
  consoleSuccess "Modified $(consoleCode "$count $(plural "$count" file files)")"
  rm -f "$cannonLog" "$cannonLog.found" || :

}
_cannon() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
