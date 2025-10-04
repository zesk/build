#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/text.md
# Test: ./test/tools/text-tests.sh
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

__textLoader() {
  __functionLoader __shaPipe text "$@"
}

# Extract a range of lines from a file
# Argument: startLine - Integer. Required. Starting line number.
# Argument: endLine - Integer. Required. Ending line number.
# stdin: Reads lines until EOF
# stdout: Outputs the selected lines only
fileExtractLines() {
  local handler="_${FUNCNAME[0]}"

  local start="" end=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$start" ]; then
        start="$(usageArgumentPositiveInteger "$handler" "start" "$1")" || return $?
      elif [ -z "$end" ]; then
        end="$(usageArgumentPositiveInteger "$handler" "end" "$1")" || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  sed -n "${start},${end}p;${end}q"
}
_fileExtractLines() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# `grep` but returns 0 when nothing matches
# See: grep
# Allow blank files or no matches -
# - `grep` - returns 1 - no lines selected
# - `grep` - returns 0 - lines selected
# Return Code: 0 - Normal operation
# Argument: ... - Arguments. Passed directly to `grep`.
# Requires: grep mapReturn
grepSafe() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  grep "$@" || mapReturn $? 1 0 || return $?
}
_grepSafe() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Check if text contains plaintext only
# Argument: text - Required. String. Text to search for mapping tokens.
# No arguments displays help.
# Return code: - `0` - Text is plain
# Return code: - `1` - Text contains non-plain characters
isPlain() {
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0

  while [ $# -gt 0 ]; do
    case "$1" in *[^[:print:]]*) return 1 ;; esac
    shift
  done
  return 0
}
_isPlain() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Check if text contains mappable tokens
# If any text passed contains a token which can be mapped, succeed.
# Argument: --prefix - Optional. String. Token prefix defaults to `{`.
# Argument: --suffix - Optional. String. Token suffix defaults to `}`.
# Argument: --token - Optional. String. Classes permitted in a token
# Argument: text - Optional. String. Text to search for mapping tokens.
# Return code: - `0` - Text contains mapping tokens
# Return code: - `1` - Text does not contain mapping tokens
isMappable() {
  local handler="_${FUNCNAME[0]}"
  local prefix='{' suffix='}' tokenClasses='[-_A-Za-z0-9:]'

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --token) shift && tokenClasses="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $? ;;
    --prefix) shift && prefix=$(quoteGrepPattern "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $? ;;
    --suffix) shift && suffix=$(quoteGrepPattern "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $? ;;
    *)
      if printf "%s\n" "$1" | grep -q -e "$prefix$tokenClasses$tokenClasses*$suffix"; then
        return 0
      fi
      ;;
    esac
    shift
  done
  return 1
}
_isMappable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Parses text and determines if it's true-ish
#
# Usage: {fn} text
# Return Code: 0 - true
# Return Code: 1 - false
# Return Code: 2 - Neither
# Requires: lowercase __help
parseBoolean() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
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
_parseBoolean() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Hide newlines in text (to ensure single-line output or other manipulation)
# Argument: text - String. Required. Text to replace.
# Argument: replace - String. Optional. Replacement string for newlines.
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# stdout: The text with the newline replaced with another character, suitable typically for single-line output
newlineHide() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  local text="${1-}" replace="${2-"␤"}"
  printf -- "%s\n" "${text//$'\n'/$replace}"
}
_newlineHide() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Quote strings for inclusion in shell quoted strings
# Argument: text - Text to quote
# Output: Single quotes are prefixed with a backslash
# Example:     {fn} "Now I can't not include this in a bash string."
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# stdout: The input text properly quoted
escapeQuotes() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  printf %s "$(escapeDoubleQuotes "$(escapeSingleQuotes "$1")")"
}
_escapeQuotes() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Replaces the first and only the first occurrence of a pattern in a line with a replacement string.
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# stdin: Reads lines from stdin until EOF
# stdout: Outputs modified lines
replaceFirstPattern() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/1"
}
_replaceFirstPattern() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Trim whitespace from beginning and end of a stream
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# stdin: Reads lines from stdin until EOF
# stdout: Outputs modified lines
# INTERNAL: Explained
# INTERNAL: 1. `-e :a`: Creates a label `a` for looping
# INTERNAL: 2. `/./,$!d` deletes all lines until the first non-blank line is found (`/./` matches any non-blank line).
# INTERNAL: 3. `/./!{N;ba}`: For blank lines at the end, it appends lines to the pattern space (`N`) until a non-blank line is found, then loops back to label `a`.
trimBoth() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  sed -e :a -e '/./,$!d' -e '/^\n*$/{$d;N;ba' -e '}'
}
_trimBoth() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Removes any blank lines from the beginning of a stream
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# stdin: Reads lines from stdin until EOF
# stdout: Outputs modified lines
trimHead() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  sed -e "/./!d" -e :r -e n -e br
}
_trimHead() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Removes any blank lines from the end of a stream
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# stdin: Reads lines from stdin until EOF
# stdout: Outputs modified lines
trimTail() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  sed -e :a -e '/^\n*$/{$d;N;ba' -e '}'
}
_trimTail() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Ensures blank lines are singular
# Used often to clean up markdown `.md` files, but can be used for any line-based configuration file which allows blank lines.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# stdin: Reads lines from stdin until EOF
# stdout: Outputs modified lines where any blank lines are replaced with a single blank line.
singleBlankLines() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  sed '/^$/N;/^\n$/D'
}
_singleBlankLines() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Trim spaces and only spaces from arguments or a pipe
# Argument: text - Optional. EmptyString. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.
# stdin: Reads lines from stdin until EOF
# stdout: Outputs trimmed lines
# Example:     {fn} "$token"
# Example:     grep "$tokenPattern" | trimSpace > "$tokensFound"
# Summary: Trim whitespace of a bash argument
# Source: https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816
# Credits: Chris F.A. Johnson (2008)
trimSpace() {
  local handler="_${FUNCNAME[0]}"

  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      local var
      var="$1"
      # remove leading whitespace characters
      var="${var#"${var%%[![:space:]]*}"}"
      # remove trailing whitespace characters
      printf -- "%s" "${var%"${var##*[![:space:]]}"}"
      shift
    done
  else
    __catchEnvironment "$handler" awk "{\$1=\$1};NF" || return $?
  fi
}
_trimSpace() {
  true || trimSpace "" # SC2120 fix
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
# Return Code: 0 - If element is found in array
# Return Code: 1 - If element is NOT found in array
# Tested: No
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
# Argument: needle ... - Optional. String. One or more strings to find as a substring of `haystack`.
# Return Code: 0 - IFF ANY needle matches as a substring of haystack
# Return Code: 1 - No needles found in haystack
# Summary: Find whether a substring exists in one or more strings
# Does needle exist as a substring of haystack?
stringContains() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local haystack="${1-}"

  [ -n "$haystack" ] || return 1
  shift
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || continue
    local needle="$1"
    [ "${haystack#*"$needle"}" = "$haystack" ] || return 0
    shift
  done
  return 1
}
_stringContains() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: haystack - Required. String. String to search.
# Argument: needle ... - Optional. String. One or more strings to find as the "start" of `haystack`.
# Return Code: 0 - IFF ANY needle matches as a substring of haystack
# Return Code: 1 - No needles found in haystack
# Summary: Find whether a substring exists as teh beginning of one or more strings
# Does needle exist as a substring of haystack?
stringBegins() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local haystack="${1-}"

  [ -n "$haystack" ] || return 1
  shift
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || continue
    local needle="$1"
    [ "${haystack#"$needle"}" = "$haystack" ] || return 0
    shift
  done
  return 1
}
_stringBegins() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: haystack - Required. String. String to search. (case-insensitive)
# Argument: needle ... - Optional. String. One or more strings to find as the "start" of `haystack` (case-insensitive)
# Return Code: 0 - IFF ANY needle matches as a substring of haystack (case-insensitive)
# Return Code: 1 - No needles found in haystack (case-insensitive)
# Summary: Find whether a substring exists as teh beginning of one or more strings
# Does needle exist as a substring of haystack? (case-insensitive)
stringBeginsInsensitive() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local haystack="${1-}"

  [ -n "$haystack" ] || return 1
  shift
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || continue
    local needle
    needle=$(lowercase "$1") || :
    [ "${haystack#"$needle"}" = "$haystack" ] || return 0
    shift
  done
  return 1
}
_stringBeginsInsensitive() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} haystack needle ...
# Argument: haystack - Required. String. String to search.
# Argument: needle ... - Optional. String. One or more strings to find as a case-insensitive substring of `haystack`.
# Return Code: 0 - IFF ANY needle matches as a substring of haystack
# Return Code: 1 - No needles found in haystack
# Summary: Find whether a substring exists in one or more strings
# Does needle exist as a substring of haystack?
stringContainsInsensitive() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local haystack="${1-}"

  [ -n "$haystack" ] || return 1
  shift
  haystack=$(lowercase "$haystack") || :
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || continue
    local needle
    needle=$(lowercase "$1") || :
    [ "${haystack#*"$needle"}" = "$haystack" ] || return 0
    shift
  done
  return 1
}
_stringContainsInsensitive() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} text prefixText ...
# Argument: text - Optional. String. String to match.
# Argument: prefixText - Required. String. One or more. Does this prefix exist in our `text`?
# Return Code: 0 - If `text` has any prefix
# Does text have one or more prefixes?
beginsWith() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local text="${1-}"
  [ -n "$text" ] || __throwArgument "$handler" "Empty text" || return $?

  shift
  while [ $# -gt 0 ]; do
    if [ -n "$1" ]; then
      [ "${text#"$1"}" = "$text" ] || return 0
    fi
    shift
  done
  return 1
}
_beginsWith() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Check if one string is a substring of another set of strings (case-sensitive)
#
# Usage: {fn} needle [ haystack ... ]
# Argument: needle - Required. String. Thing to search for, not blank.
# Argument: haystack ... - Optional. EmptyString. One or more array elements to match
# Return Code: 0 - If element is a substring of any haystack
# Return Code: 1 - If element is NOT found as a substring of any haystack
# Tested: No
#
isSubstring() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local haystack needle=${1-}
  shift || return 1
  for haystack; do
    [ "${haystack#*"$needle"}" = "$haystack" ] || return 0
    shift
  done
  return 1
}
_isSubstring() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Check if one string is a substring of another set of strings (case-insensitive)
#
# Usage: {fn} needle [ haystack ... ]
# Argument: needle - Required. String. Thing to search for, not blank.
# Argument: haystack ... - Optional. EmptyString. One or more array elements to match
# Return Code: 0 - If element is a substring of any haystack
# Return Code: 1 - If element is NOT found as a substring of any haystack
# Tested: No
#
isSubstringInsensitive() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local element arrayElement

  element="$(lowercase "${1-}")"
  [ -n "$element" ] || __throwArgument "$handler" "needle is blank" || return $?
  shift || return 1
  for arrayElement; do
    arrayElement=$(lowercase "$arrayElement")
    if [ "${arrayElement#*"$element"}" != "$arrayElement" ]; then
      return 0
    fi
  done
  return 1
}
_isSubstringInsensitive() {
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

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
_trimWords() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields
#
# Defaults to first field (fieldIndex of `1`), space separator (separatorChar is ` `)
#
# Argument: fieldIndex - UnsignedInteger. Required. The field to compute the maximum length for
# Argument: separatorChar - String. Required. The separator character to delineate fields
# stdin: Lines are read from standard in and line length is computed for each line
# stdout: `UnsignedInteger`
maximumFieldLength() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local index=$((${1-1} + 0)) separatorChar=${2-}

  if [ -n "$separatorChar" ]; then
    separatorChar=("-F$separatorChar")
  else
    separatorChar=()
  fi
  awk "${separatorChar[@]}" "{ print length(\$$index) }" | sort -rn | head -n 1
}
_maximumFieldLength() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Outputs the maximum line length passed into stdin
# stdin: Lines are read from standard in and line length is computed for each line
# stdout: `UnsignedInteger`
maximumLineLength() {
  local handler="_${FUNCNAME[0]}"
  local max

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  max=0
  while IFS= read -r line; do
    if [ "${#line}" -gt "$max" ]; then
      max=${#line}
    fi
  done
  printf "%d" "$max"
}
_maximumLineLength() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Does a file end with a newline or is empty?
#
# Typically used to determine if a newline is needed before appending a file.
#
# Argument: file ... - File. Required. File to check if the last character is a newline.
# Return Code: 0 - All files ends with a newline
# Return Code: 1 - One or more files ends with a non-newline
# Test: testFileEndsWithNewline
fileEndsWithNewline() {
  local handler="_${FUNCNAME[0]}" one=false

  # _IDENTICAL_ argumentBlankLoopHandler 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      [ -f "$argument" ] || __throwArgument "$handler" "not a file #$__index/$__count ($argument)" || return $?
      one=true
      [ -z "$(tail -c 1 "$argument")" ] || return 1
      ;;
    esac
    shift
  done
  $one || __throwArgument "$handler" "Requires at least one file $(decorate each code -- "${__saved[@]}")" || return $?
}
_fileEndsWithNewline() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# stdout: UnsignedInteger
# Outputs the number of lines read from stdin (or supplied files) until EOF. For multiple files passed on the command line - each one is output separately.
# This is essentially a wrapper around `wc -l` which strips whitespace and does type checking.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: file - Optional. File. Output line count for each file specified. If no files specified, uses stdin.
# stdin: Lines are read from standard in and counted
# stdout: `UnsignedInteger`
fileLineCount() {
  local handler="_${FUNCNAME[0]}"
  local fileArgument=false newlineCheck=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --newline) newlineCheck=true ;;
    *)
      local file total
      file="$(usageArgumentFile "$handler" "$argument" "${1-}")" || return $?
      total=$(__catchEnvironment "$handler" wc -l <"$file" | trimSpace) || return $?
      if $newlineCheck; then
        if [ -s "$file" ]; then
          # File is not empty
          if fileEndsWithNewline "$file"; then
            # newline at EOF
            printf "%d\n" "$total"
          else
            # NO newline at EOF
            printf "%d\n" "$((total + 1))"
          fi
        else
          printf "%d\n" 0
        fi
      else
        printf "%d\n" "$total"
      fi
      fileArgument=true
      ;;
    esac
    shift
  done
  if ! $fileArgument; then
    if $newlineCheck; then
      local temp
      temp=$(fileTemporaryName "$handler") || return $?
      __catchEnvironment "$handler" cat >"$temp" || returnClean $? "$temp" || return $?
      fileLineCount --newline --handler "$handler" "$temp" || return $?
      __catch "$handler" rm -f "$temp" || return $?
    else
      printf "%d\n" "$(__catchEnvironment "$handler" wc -l | trimSpace)" || return $?
    fi
  fi
}
_fileLineCount() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Plural word which includes the numeric prefix and the noun.
# Argument: number - Required. An integer or floating point number
# Argument: singular - Required. The singular form of a noun
# Argument: plural - Optional. The plural form of a noun. If not specified uses `singular` plus an ess.
# Example:     count=$(fileLineCount "$foxSightings") || return $?
# Example:     printf "We saw %s.\n" "$(pluralWord "$count" fox foxes)"
# stdout: `String`. The number (direct) and the plural form for non-1 values. e.g. `$(pluralWord 2 potato potatoes)` = `2 potatoes`
pluralWord() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local word
  word=$(__catch "$handler" plural "$@") || return $?
  printf -- "%s %s\n" "$1" "$word" || return $?
}
_pluralWord() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Outputs the `singular` value to standard out when the value of `number` is one.
# Otherwise, outputs the `plural` value to standard out.
#
# Short description: Output numeric messages which are grammatically accurate
# Argument: number - Required. An integer or floating point number
# Argument: singular - Required. The singular form of a noun
# Argument: plural - Optional. The plural form of a noun. If not specified uses `singular` plus an ess.
#
# Return Code: 1 - If count is non-numeric
# Return Code: 0 - If count is numeric
# Example:     count=$(fileLineCount "$foxSightings") || return $?
# Example:     printf "We saw %d %s.\n" "$count" "$(plural "$count" fox foxes)"
# Example:
# Example:     n=$(($(date +%s)) - start))
# Example:     printf "That took %d %s" "$n" "$(plural "$n" second seconds)"
# stdout: `String`. The plural form for non-1 values. e.g. `$(plural 2 potato potatoes)` = `potatoes`
plural() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local count=${1-} plural="${3-"${2}s"}"
  if [ "$count" -eq "$count" ] 2>/dev/null; then
    if [ "$((${1-} + 0))" -eq 1 ]; then
      printf %s "${2-}"
    else
      printf %s "$plural"
    fi
  elif isNumber "$count"; then
    case "${count#1.}" in
    *[^0]*) printf %s "$plural" ;;
    *) printf %s "${2-}" ;;
    esac
  else
    __throwArgument "$handler" "plural argument: \"$count\" is not numeric" || return $?
    return 1
  fi
}
_plural() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Convert text to lowercase
#
# DOC TEMPLATE: dashDashAllowsHelpParameters 1
# Argument: -- - Optional. Flag. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: text - EmptyString. Required. Text to convert to lowercase
# stdout: `String`. The lowercase version of the `text`.
# Requires: tr
lowercase() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  [ "${1-}" != "--" ] || shift
  while [ $# -gt 0 ]; do
    if [ -n "$1" ]; then
      printf "%s\n" "$1" | tr '[:upper:]' '[:lower:]'
    fi
    shift
  done
}
_lowercase() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Convert text to uppercase
#
# DOC TEMPLATE: dashDashAllowsHelpParameters 1
# Argument: -- - Optional. Flag. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: text - EmptyString. Required. text to convert to uppercase
# stdout: `String`. The uppercase version of the `text`.
# Requires: tr
uppercase() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  [ "${1-}" != "--" ] || shift
  while [ $# -gt 0 ]; do
    if [ -n "$1" ]; then
      printf "%s\n" "$1" | tr '[:lower:]' '[:upper:]'
    fi
    shift
  done
}
_uppercase() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Strip ANSI console escape sequences from a file
# Argument: None.
# Exit Codes: Zero.
# Local Cache: None.
# Environment: None.
# Write Environment: None.
# Credits: commandlinefu tripleee
# Short description: Remove ANSI escape codes from streams
# Source: https://stackoverflow.com/questions/6534556/how-to-remove-and-all-of-the-escape-sequences-in-a-file-using-linux-shell-sc
# Depends: sed
# stdin: arbitrary text which may contain ANSI escape sequences for the terminal
# stdout: the same text with those ANSI escape sequences removed
stripAnsi() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  sed -e $'s,\x1B\[[0-9;]*[a-zA-Z],,g' -e $'s,\x1B\][^\x1B]*\x1B\x5c\x5c,,g'
}
_stripAnsi() {
  true || stripAnsi --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Length of an unformatted string
# Argument: text - EmptyString. Required. text to determine the plaintext length of.
# stdout: `UnsignedInteger`. Length of the plain characters in the input arguments.
plainLength() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local text
  text="$(stripAnsi <<<"$*")"
  printf "%d\n" "${#text}"
}
_plainLength() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff
#
# You can use this as a pipe or pass in arguments which are files to be hashed.
#
# Usage: shaPipe [ filename ... ]
# Argument: filename - One or more filenames to generate a checksum for
# Depends: sha1sum
# Summary: SHA1 checksum of standard input
# Example:     shaPipe < "$fileName"
# Example:     shaPipe "$fileName0" "$fileName1"
# Output: cf7861b50054e8c680a9552917b43ec2b9edae2b
# Environment: DEBUG_SHAPIPE - When set to a truthy value, will output all requested shaPipe calls to log called `shaPipe.log`.
# stdin: any file
# stdout: `String`. A hexadecimal string which uniquely represents the data in `stdin`.
shaPipe() {
  __textLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_shaPipe() {
  # __IDENTICAL__ usageDocument 1
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
# Depends: sha1sum shaPipe
# Summary: SHA1 checksum of standard input
# Example:     cachedShaPipe "$cacheDirectory" < "$fileName"
# Example:     cachedShaPipe "$cacheDirectory" "$fileName0" "$fileName1"
# Output: cf7861b50054e8c680a9552917b43ec2b9edae2b
# stdin: any file
# stdout: `String`. A hexadecimal string which uniquely represents the data in `stdin`.
cachedShaPipe() {
  __textLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_cachedShaPipe() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: randomString [ ... ]
# Depends: sha1sum, /dev/random
# Description: Outputs 40 random hexadecimal characters, lowercase.
# Example:     testPassword="$(randomString)"
# Output: cf7861b50054e8c680a9552917b43ec2b9edae2b
# stdout: `String`. A random hexadecimal string.
randomString() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  head --bytes=64 /dev/random | sha1sum | cut -f 1 -d ' '
}
_randomString() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: stringOffset needle haystack
# Outputs the integer offset of `needle` if found as substring in `haystack`
# If `haystack` is not found, -1 is output
# Argument: offset - Integer. Required.
# Argument: needle - String. Required.
# Argument: haystack - String. Required.
# stdout: `UnsignedInteger`. The offset at which the `needle` was found in `haystack`.
stringOffset() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local length=${#2}
  local substring="${2/${1-}*/}"
  local offset="${#substring}"
  if [ "$offset" -eq "$length" ]; then
    offset=-1
  fi
  printf %d "$offset"
}
_stringOffset() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove fields from left to right from a text file as a pipe
# Usage: {fn} fieldCount < input > output
# Argument: fieldCount - Optional. Integer. Number of field to remove. Default is just first `1`.
# Partial Credit: https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899
# stdin: A file with fields separated by spaces
# stdout: The same file with the first `fieldCount` fields removed from each line.
removeFields() {
  local handler="_${FUNCNAME[0]}"
  local fieldCount=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      [ -z "$fieldCount" ] || __throwArgument "$handler" "Only one fieldCount should be provided argument #$__index: $argument" || return $?
      fieldCount="$(usageArgumentPositiveInteger "$handler" "fieldCount" "$argument")" || return $?
      ;;
    esac
    shift
  done
  fieldCount=${fieldCount:-1}
  sed -r 's/^([^ ]+ +){'"$fieldCount"'}//'
}
_removeFields() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Pipe to output some text before any output, otherwise, nothing is output.
# Argument: ... - Required. Arguments. printf arguments.
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# stdin: text (Optional)
# stdout: printf output and then the stdin text IFF stdin text is non-blank
printfOutputPrefix() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  local output=false
  while read -r line; do
    if ! $output; then
      # shellcheck disable=SC2059
      printf "$@"
      output=true
    fi
    printf -- "%s\n" "$line"
  done
}
_printfOutputPrefix() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Pipe to output some text after any output, otherwise, nothing is output.
# Argument: ... - Required. Arguments. printf arguments.
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# stdin: text (Optional)
# stdout: stdin text and then printf output IFF stdin text is non-blank
printfOutputSuffix() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  local output=false
  while read -r line; do
    if ! $output; then
      output=true
    fi
    printf -- "%s\n" "$line"
  done
  # shellcheck disable=SC2059
  ! $output || printf "$@"
}
_printfOutputSuffix() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Replace all occurrences of a string within another string
# Argument: needle - String. Required. String to replace.
# Argument: replacement - EmptyString.  String to replace needle with.
# Argument: haystack - EmptyString. Optional. String to modify. If not supplied, reads from standard input.
# stdin: If no haystack supplied reads from standard input and replaces the string on each line read.
# stdout: New string with needle replaced
stringReplace() {
  local handler="_${FUNCNAME[0]}"

  local needle="" replacement="" sedCommand="" hasTextArguments=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$needle" ]; then
        needle="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      elif [ -z "$sedCommand" ]; then
        replacement="$(usageArgumentEmptyString "$handler" "$argument" "${1-}")" || return $?
        sedCommand="s/$(quoteSedPattern "$needle")/$(quoteSedReplacement "$replacement")/g"
      else
        sed -e "$sedCommand" <<<"$1"
        hasTextArguments=true
      fi
      ;;
    esac
    shift
  done
  if $hasTextArguments; then
    return 0
  fi
  [ -n "$needle" ] || __throwArgument "$handler" "Missing needle" || return $?
  [ -n "$sedCommand" ] || __throwArgument "$handler" "Missing replacement" || return $?
  sed -e "$sedCommand"
}
_stringReplace() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
