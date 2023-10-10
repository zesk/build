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
#
quoteSedPattern() {
    echo -n "$1" | sed 's/\([\/.*+?]\)/\\\1/g'
}

#
# Usage: repeat count string
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
# Decoration
#
echoBar() {
    repeat 80 =
}

#
# Prefix each line with the arguments passed
#
# Usage: prefixLines string < fileToPrefixLines
#
prefixLines() {
    local prefix="$*" awkLine
    shift
    awkLine="{ print \"$prefix\"\$0 }"
    awk "$awkLine"
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
#  urlParse url
#
urlParse() {
    local url=$1 name user password host

    name=${url##*/}

    user=${url##*://}
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
# Usage: maximumFieldLength [ fieldIndex ] < fieldBasedFile
#
# Given a input file, determine the maximum length of fieldIndex
#
# Defaults to first field, space separator
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
# Usage: plural number singular plural
#
# Sample:
#
# count=$(($(wc -l < $foxSightings) + 0))
# echo "We saw $count $(plural $count fox foxes)."
#
plural() {
    if [ "$(($1 + 0))" -eq 1 ]; then
        echo "$2"
    else
        echo "$3"
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
# alignRight "$characterSize" "string to align"
#
alignRight() {
    local n=$(($1 + 0))
    shift
    printf "%${n}s" "$*"
}

#
# alignLeft "$characterSize" "string to align"
#
alignLeft() {
    local n=$(($1 + 0))
    shift
    printf "%-${n}s" "$*"
}

#
# Not sure if this works really, need to pair with
# something in local script to make an array possibly
#
function argumentsToArray() {
    local -a a=("$@")
    echo "${a[@]}"
}
