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
    value=$(printf %s "$1" | sed 's/\([.*+?]\)/\\\1/g')
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
    printf %s "${1//\"/\"}"
}

#
# Quote strings for inclusion in shell quoted strings
# Usage: escapeSingleQuotes text
# Argument: text - Text to quote
# Output: Single quotes are prefixed with a backslash
# Example:     escapeSingleQuotes "Now I can't not include this in a bash string."
#
escapeSingleQuotes() {
    printf %s "${1//\'/\\\'}"
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
# Trim spaces and only spaces
# Usage: trimSpace text
# Argument: text - Text to remove spaces
# Output: text
# Example:     trimSpace "$token"
# Summary: Trim whitespace of a bash argument
# Source: https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816
# Credits: Chris F.A. Johnson (2008)
#
trimSpace() {
    local var="$1"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    printf %s "${var%"${var##*[![:space:]]}"}"
}

#
# Strip whitespace in input stream
# Removes leading and trailing spaces in input, also removes blank lines I think
# Usage: trimSpacePipe < file > output
# Summary: Trim whitespace in a pipeline
# Depends: awk
# Argument: None
#
trimSpacePipe() {
    awk '{$1=$1};NF'
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
# Usage: repeat count string [ ... ]
# Argument: `count` - Required, integer count of times to repeat
# Argument: `string` - A sequence of characters to repeat
# Argument: ... - Additional arguments are output using shell expansion of `$*`
# Example:     echo $(repeat 80 =)
# Example:     echo Hello world
# Example:     echo $(repeat 80 -)
#
repeat() {
    local count=$((${1:-2} + 0))

    shift
    while [ $count -gt 0 ]; do
        printf %s "$*"
        count=$((count - 1))
    done
}

#
# Usage: echoBar [ alternateChar [ offset ] ]
# Output a bar as wide as the console using the `=` symbol.
# Argument: alternateChar - Use an alternate character or string output
# Argument: offset - an integer offset to increase or decrease the size of the bar (default is `0`)
# Environment: Console width is captured using `tput cols` or if no `TERM` set, then uses the value 80.
# Example:     consoleSuccess $(echoBar =-)
# Example:     consoleSuccess $(echoBar "- Success ")
# Example:     consoleMagenta $(echoBar +-)
echoBar() {
    local c="${1:-=}"
    local n=$(($(consoleColumns) / ${#c}))
    local delta=$((${2:-0} + 0))

    n=$((n + delta))
    repeat "$n" "$c"
}

#
# Prefix output lines with a string, useful to format output or add color codes to
# consoles which do not honor colors line-by-line. Intended to be used as a pipe.
#
# Summary: Prefix output lines with a string
# Usage: prefixLines [ text .. ] < fileToPrefixLines
# Exit Code: 0
# Argument: `text` - Prefix each line with this text
# Example:     cat "$file" | prefixLines "$(consoleCode)"
# Example:     cat "$errors" | prefixLines "    ERROR: "
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
# Test if an argument is a floating point number
#
# Usage: isInteger argument
# Exit Code: 0 - if it is an integer
# Exit Code: 1 - if it is not an integer
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
isUnsignedNumber() {
    case ${1#[-+]} in
    '' | . | *[!0-9.]* | *.*.*)
        return 1
        ;;
    esac
}

#
# Test if an argument is a floating point number
#
# Usage: isInteger argument
# Exit Code: 0 - if it is an integer
# Exit Code: 1 - if it is not an integer
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
isNumber() {
    case ${1#[-+]} in
    '' | . | *[!0-9.]* | *.*.*)
        return 1
        ;;
    esac
}

#
# Test if an argument is a signed integer
#
# Usage: isInteger argument
# Exit Code: 0 - if it is a signed integer
# Exit Code: 1 - if it is not a signed integer
# Credits: F. Hauri - Give Up GitHub (isuint_Case)
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
isInteger() {
    case ${1#[-+]} in
    '' | *[!0-9]*)
        return 1
        ;;
    esac
}

#
# Test if an argument is an unsigned integer
#
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} string
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
#
isUnsignedInteger() {
    case $1 in
    '' | *[!0-9]*)
        return 1
        ;;
    esac
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
# Simplistic URL parsing. Converts a `url` into values which can be parsed or evaluated:
#
# - `url` - URL
# - `host` - Database host
# - `user` - Database user
# - `password` - Database password
# - `port` - Database port
# - `name` - Database name
# Exit Code: 0 - If parsing succeeds
# Exit Code: 1 - If parsing fails
# Summary: Simple Database URL Parsing
# Usage: urlParse url
# Argument: url - a Uniform Resource Locator used to specify a database connection
# Example:     eval "$(urlParse scheme://user:password@host:port/path)"
# Example:     echo $name
#
urlParse() {
    local url="${1-}" v name scheme user password host port failed

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

    failed=
    if [ "$scheme" = "$url" ] || [ "$user" = "$url" ] || [ "$password" = "$url" ] || [ "$host" = "$url" ]; then
        echo "url=$url" 1>&2
        echo "failed=1" 1>&2
        return 1
    fi

    for v in url scheme name user password host port failed; do
        printf "%s=%s\n" "$v" "$(quoteBashString "${!v}")"
    done
}

#
# Gets the component of the URL from a given database URL.
# Summary: Get a database URL component directly
# Usage: urlParseItem url name
# Argument: url - a Uniform Resource Locator used to specify a database connection
# Argument: name - the url component to get: `name`, `user`, `password`, `host`, `port`, `failed`
# Example:     consoleInfo "Connecting as $(urlParseItem "$url" user)"
#
urlParseItem() {
    # shellcheck disable=SC2034
    local scheme url name user password host port failed
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
# Converts a date (`YYYY-MM-DD`) to another format.
# Summary: Platform agnostic date conversion
# Usage: dateToFormat date format
# Argument: date - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)
# Argument: format - Format string for the `date` command (e.g. `%s`)
# Example:     dateToFormat 2023-04-20 %s 1681948800
# Example:     timestamp=$(dateToFormat '2023-10-15' %s)
# Environment: Compatible with BSD and GNU date.
# Exit Code: 1 - if parsing fails
# Exit Code: 0 - if parsing succeeds

dateToFormat() {
    if [ $# -eq 0 ]; then
        return 2
    fi
    if date --version 2>/dev/null 1>&2; then
        date -u --date="$1 00:00:00" "+$2" 2>/dev/null
    else
        date -u -jf '%F %T' "$1 00:00:00" "+$2" 2>/dev/null
    fi
}

#
# Converts a date to an integer timestamp
#
# Usage: dateToTimestamp date
#
# Argument: date - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)
# Environment: Compatible with BSD and GNU date.
# Exit Code: 1 - if parsing fails
# Exit Code: 0 - if parsing succeeds
# Example:     timestamp=$(dateToTimestamp '2023-10-15')
#
dateToTimestamp() {
    dateToFormat "$1" %s
}

#
# Converts a date (YYYY-MM-DD) to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)
#
# timestampToDate 1681948800 %F
#
# Usage: timestampToDate integerTimestamp format

# Argument: - `integerTimestamp` - Integer timestamp offset (unix timestamp, same as `$(date +%s)`)
# Argument: - `format` - How to output the date (e.g. `%F` - no `+` is required)

# Environment: Compatible with BSD and GNU date.

# Exit codes: If parsing fails, non-zero exit code.

# Example:     dateField=$(timestampToDate $init %Y)

timestampToDate() {
    if date --version 2>/dev/null 1>&2; then
        date -d "@$1" "+$2"
    else
        date -r "$1" "+$2"
    fi
}

# `yesterdayDate`
#
# Returns yesterday's date, in YYYY-MM-DD format. (same as `%F`)
#
# Usage: yesterdayDate
#
# Argument: None.
#
# Summary: Yesterday's date
# Environment: Compatible with BSD and GNU date.
# Example:     rotated="$log.$(yesterdayDate)"

yesterdayDate() {
    timestampToDate "$(($(date +%s) - 86400))" %F
}

# Summary: Today's date
# Returns the current date, in YYYY-MM-DD format. (same as `%F`)
# Usage: todayDate
# Argument: None.
# Environment: Compatible with BSD and GNU date.
# Example:     date="$(todayDate)"
#
todayDate() {
    date +%F
}

#
# Format text and align it right using spaces.
#
# Usage: alignRight characterWidth text [ ... ]
# Summary: align text right
# Argument: `characterWidth` - Characters to align right
# Argument: `text ...` - Text to align right
# Example:     printf "%s: %s\n" "$(alignRight 20 Name)" "$name"
# Example:     printf "%s: %s\n" "$(alignRight 20 Profession)" "$occupation"
# Example:                 Name: Juanita
# Example:           Profession: Engineer
#
alignRight() {
    local n=$(($1 + 0))
    shift
    printf "%${n}s" "$*"
}

#
# Format text and align it left using spaces.
#
# Usage: alignLeft characterWidth text [ ... ]
#
# Summary: align text left
# Argument: - characterWidth - Characters to align left
# Argument: - `text ...` - Text to align left
#
# Example:     printf "%s: %s\n" "$(alignLeft 14 Name)" "$name"
# Example:     printf "%s: %s\n" "$(alignLeft 14 Profession)" "$occupation"
# Example:     Name          : Tyrone
# Example:     Profession    : Engineer
#
alignLeft() {
    local n=$(($1 + 0))
    shift
    printf "%-${n}s" "$*"
}

#
# Convert text to lowercase
#
# Usage: lowercase [ text ... ]
# Arguments: text - text to convert to lowercase
#
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
# Summary: Text heading decoration
# Usage: boxedHeading [ --size size ] text [ ... ]
# Argument: --size size - Number of liens to output
# Argument: text ... - Text to put in the box
# Example:     boxedHeading Moving ...
# Output: +================================================================================================+
# Output: |                                                                                                |
# Output: | Moving ...                                                                                     |
# Output: |                                                                                                |
# Output: +================================================================================================+
#
boxedHeading() {
    local bar spaces text=() textString emptyBar nLines

    nLines=1
    while [ $# -gt 0 ]; do
        case $1 in
        --size)
            shift
            nLines="$1"
            if ! isUnsignedNumber "$nLines"; then
                consoleError "--size requires an unsigned integer" 1>&2
                return 1
            fi
            ;;
        *)
            text+=("$1")
            ;;
        esac
        shift
    done
    bar="+$(echoBar '' -2)+"
    emptyBar="|$(echoBar ' ' -2)|"

    # convert to string
    textString="${text[*]}"

    spaces=$((${#bar} - ${#textString} - 4))
    consoleDecoration "$bar"
    runCount "$nLines" consoleDecoration "$emptyBar"
    echo "$(consoleDecoration -n \|) $(_consoleInfo "" -n "$textString")$(repeat $spaces " ") $(consoleDecoration -n \|)"
    runCount "$nLines" consoleDecoration "$emptyBar"
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

#
# For security one should update keys every N days
#
# This value would be better encrypted and tied to the key itself so developers
# can not just update the value to avoid the security issue.
#
# This tool checks the value and checks if it is `upToDateDays` of today; if not this fails.
#
# It will also fail if:
#
# - `upToDateDays` is less than zero or greater than 366
# - `keyDate` is empty or has an invalid value
#
# Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the `keyDate` has not exceeded the number of days.
#
# Summary: Test whether the key needs to be updated
# Usage: isUpToDate keyDate upToDateDays
# Argument: keyDate - Date formatted like `YYYY-MM-DD`
# Argument: upToDateDays - Days that key expires after `keyDate`
# Example:     if !isUpToDate "$AWS_ACCESS_KEY_DATE" 90; then
# Example:       bigText Failed, update key and reset date
# Example:       exit 99
# Example:     fi
#
isUpToDate() {
    local keyDate upToDateDays=${1:-90} accessKeyTimestamp todayTimestamp deltaDays maxDays daysAgo expireDate

    keyDate="${1-}"
    shift || return "$errorArgument"
    if [ -z "${1-}" ]; then
        consoleError "Invalid date $keyDate" 1>&2
        return "$errorArgument"
    fi
    upToDateDays="${1-}"
    upToDateDays=$((upToDateDays + 0))
    maxDays=366
    if [ $upToDateDays -gt $maxDays ]; then
        consoleError "isUpToDate $keyDate $upToDateDays - values not allowed greater than $maxDays" 1>&2
        return 1
    fi
    if [ $upToDateDays -lt 0 ]; then
        consoleError "isUpToDate $keyDate $upToDateDays - negative values not allowed" 1>&2
        return 1
    fi
    if ! dateToTimestamp "$keyDate" >/dev/null; then
        consoleError "isUpToDate $keyDate $upToDateDays - Invalid date $keyDate" 1>&2
        return 1
    fi
    accessKeyTimestamp=$(($(dateToTimestamp "$keyDate") + 0))
    expireDate=$((accessKeyTimestamp + 86400 * upToDateDays))
    todayTimestamp=$(dateToTimestamp "$(todayDate)")
    deltaDays=$(((todayTimestamp - accessKeyTimestamp) / 86400))
    daysAgo=$((deltaDays - upToDateDays))
    if [ $daysAgo -gt 0 ]; then
        consoleError "Expired $keyDate, $daysAgo" 1>&2
        return 1
    fi
    daysAgo=$((-daysAgo))
    if [ $daysAgo -lt 14 ]; then
        bigText "$daysAgo  $(plural $daysAgo day days)" | prefixLines "$(consoleError)"
    fi
    if [ $daysAgo -lt 30 ]; then
        expireDate=$(dateToFormat)
        consoleWarning "Expires on $expireDate, in $daysAgo $(plural $daysAgo day days)"
        return 0
    fi
    return 0
}
