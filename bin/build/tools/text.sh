#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends on no other .sh files
# Shell Dependencies: awk sed date echo sort printf
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


#
# Quote sed strings for shell use
# Usage: quoteSedPattern text
# Argument: text - Text to quote
# Output: string quoted and appropriate to insert in a sed search or replacement phrase
# Example: sed "s/$(quoteSedPattern "$search")/HIDE/g"
#
quoteSedPattern() {
    # IDENTICAL quoteSedPattern 2
    value=$(printf %s "$1" | sed 's/\([.*+?]\)/\\\1/g')
    value="${value//\//\\\\\/}"
    value="${value//[/\\[}"
    value="${value//]/\\]}"
    printf %s "${value//$'\n'/\\n}"
}

#
# Quote strings for inclusion in shell quoted strings
# Usage: escapeSingleQuotes text
# Argument: text - Text to quote
# Output: Single quotes are prefixed with a backslash
# Example: escapeSingleQuotes "Now I can't not include this in a bash string."
#
escapeSingleQuotes() {
    printf %s "${1//\'/\\\'}"
}

#
# Strip whitespace in input stream
# Removes leading and trailing spaces in input, also removes blank lines I think
# Usage: stripWhitespace < file > output
# Arguments: None
#
stripWhitespace() {
    awk '{$1=$1};NF'
}

#
# Quote bash strings for inclusion as single-quoted for eval
# Usage: quoteBashString text
# Argument: text - Text to quote
# Output: string quoted and appropriate to assign to a value in the shell
# Example: name="$(quoteBashString "$name")"
quoteBashString() {
    printf '%s' "$1" | sed 's/\([$`<>'\'']\)/\\\1/g'
}
#
# Usage: repeat count string [ ... ]
# Argument: count - Required, integer count of times to repeat
# Argument: string - The ext string to repeat
# Argument: ... - Additional arguments are output using shell expansion of `$*`
#
repeat() {
    local count=$((${1:-2} + 0))

    shift
    while [ $count -gt 0 ]; do
        echo -n "$*"
        count=$((count - 1))
    done
}

#
# echoBar character offset
#
echoBar() {
    local c="${1:-=}"
    local n=$(($(consoleColumns) / ${#c}))
    local delta=$((${2:-0} + 0))

    n=$((n + delta))
    repeat "$n" "$c"
}

#
# Prefix each line with the arguments passed
#
# Usage: prefixLines string < fileToPrefixLines
# Exit Code: 0
# Argument: `string` - Prefix each line with this string
# Example: cat "$file" | prefixLines "$(consoleCode)"
# Example: cat "$errors" | prefixLines "    ERROR: "
#
prefixLines() {
    local prefix="$*"
    while IFS= read -r line; do
        printf "%s%s\n" "$prefix" "$line"
    done
}

###############################################################################
#
#    ▐     ▗
# ▞▀▘▜▀ ▙▀▖▄ ▛▀▖▞▀▌▞▀▘
# ▝▀▖▐ ▖▌  ▐ ▌ ▌▚▄▌▝▀▖
# ▀▀  ▀ ▘  ▀▘▘ ▘▗▄▘▀▀
#
#------------------------------------------------------------------------------
#

#
# Check if an element exists in an array
#
# Usage: inArray element [ arrayElement0 arrayElement1 ... ]
# Argument: `element` - Thing to search for
# Argument: `arrayElement0` - One or more array elements to match
# Example: if inArray "$thing" "${things[@]}"; then things+=("$thing");
# Example:     things+=("$thing")
# Example: fi
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
# Remove words
#
# Usage: inArray element [ arrayElement0 arrayElement1 ... ]
# Argument: `element` - Thing to search for
# Argument: `arrayElement0` - One or more array elements to match
# Example: if inArray "$thing" "${things[@]}"; then things+=("$thing");
# Example:     things+=("$thing")
# Example: fi
# Exit Code: 0 - If element is found in array
# Exit Code: 1 - If element is NOT found in array
# Reviewed: 2023-11-13
# Tested: No
#
trimWords() {
    local wordCount=$((${1-0} + 0)) words=()
    shift || return 0
    while [ ${#words[@]} -lt $wordCount ]; do
        IFS=' ' read -ra argumentWords <<<"$1"
        for argumentWord in "${argumentWords[@]}"; do
            words+=("$argumentWord")
            if [ ${#words[@]} -ge $wordCount ]; then
                printf "%s " "${words[@]}"
                return 0
            fi
        done
        shift || return 0
    done
    printf "%s\n" "${words[@]}"
}

#
#  urlParse url
#
urlParse() {
    local url=$1 name user password host

    name=${url##*/}
    # strip ?
    name=${name%%\?*}
    # strip #
    name=${name%%#*}

    # extract scheme before ://
    scheme=${url%%://*}
    # user is after scheme
    user=${url##*://}
    # before password
    user=${user%%:*}

    password=${url%%@*}
    password=${password##*:}

    host=${url##*@}
    host=${host%%/*}

    port=${host##*:}
    if [ "$port" = "$host" ]; then
        port=
    fi
    host=${host%%:*}

    if [ "$scheme" = "$url" ] || [ "$user" = "$url" ] || [ "$password" = "$url" ] || [ "$host" = "$url" ]; then
        echo "url=$url" 1>&2
        echo "failed=1" 1>&2
        return 1
    fi
\
    echo "scheme=$scheme"
    echo "url=$url"
    echo "name=$name"
    echo "user=$user"
    echo "password=$password"
    echo "host=$host"
    echo "port=$port"
}

#
#  urlParseItem url name
#
urlParseItem() {
    local name user password host port
    eval "$(urlParse "$1")"
    echo "${!2}"
}

#
# Usage: maximumFieldLength [ fieldIndex [ separatorChar ] ] < fieldBasedFile
#
# Given a input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields
#
# Defaults to first field (fieldIndex=1), space separator (separatorChar=" ")
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
# Output singular or plural noun based on number
#
# Usage: plural number singular plural
# Argument: number - An integer or floating point number
# Argument: singular - The singular form of a noun
# Argument: plural - The plural form of a noun
#
# Example: count=$(($(wc -l < $foxSightings) + 0))
# Example: printf "We saw %d %s.\n" "$count" "$(plural $count fox foxes)"
#
# Exit code: 1 - If count is non-numeric
# Exit code: 0 - If count is numeric
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
# Converts a date (YYYY-MM-DD) to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)
#
# dateToFormat 2023-04-20 %s 1681948800
#
dateToFormat() {
    if date --version 2>/dev/null 1>&2; then
        date -u --date="$1 00:00:00" "+$2" 2>/dev/null
    else
        date -u -jf '%F %T' "$1 00:00:00" "+$2" 2>/dev/null
    fi
}

#
# Converts a date to an integer timestamp
#
dateToTimestamp() {
    dateToFormat "$1" %s
}

#
# Converts a date (YYYY-MM-DD) to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)
#
# timestampToDate 1681948800 %F
#
timestampToDate() {
    if date --version 2>/dev/null 1>&2; then
        date -d "@$1" "+$2"
    else
        date -r "$1" "+$2"
    fi
}

yesterdayDate() {
    timestampToDate "$(($(date +%s) - 86400))" %F
}

todayDate() {
    date +%F
}

#
# alignRight "$characterSize" "string to align"
#
alignRight() {
    local n=$(($1 + 0))
    shift
    echo -n "$(printf "%${n}s" "$*")"
}

#
# alignLeft "$characterSize" "string to align"
#
alignLeft() {
    local n=$(($1 + 0))
    shift
    printf "%-${n}s" "$*"
}

lowercase() {
    while [ $# -gt 0 ]; do
        printf %s "$1" | tr '[:upper:]' '[:lower:]'
        shift
    done
}
#
# Not sure if this works really, need to pair with
# something in local script to make an array possibly
#
argumentsToArray() {
    local -a a=("$@")
    echo "${a[@]}"
}

#
# Heading for section output
#
boxedHeading() {
    local bar spaces text emptyBar

    bar="+$(echoBar '' -2)+"
    emptyBar="|$(echoBar ' ' -2)|"
    text="$*"
    spaces=$((${#bar} - ${#text} - 4))
    consoleDecoration "$bar"
    consoleDecoration "$emptyBar"
    echo "$(consoleDecoration -n \|) $(consoleInfo -n "$text")$(repeat $spaces " ") $(consoleDecoration -n \|)"
    consoleDecoration "$emptyBar"
    consoleDecoration "$bar"
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
