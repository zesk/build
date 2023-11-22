#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: text.sh
# bin: test echo printf

###############################################################################
#
#   ▄▄      ▗▄▖
#  █▀▀▌     ▝▜▌
# ▐▛    ▟█▙  ▐▌   ▟█▙  █▟█▌▗▟██▖
# ▐▌   ▐▛ ▜▌ ▐▌  ▐▛ ▜▌ █▘  ▐▙▄▖▘
# ▐▙   ▐▌ ▐▌ ▐▌  ▐▌ ▐▌ █    ▀▀█▖
#  █▄▄▌▝█▄█▘ ▐▙▄ ▝█▄█▘ █   ▐▄▄▟▌
#   ▀▀  ▝▀▘   ▀▀  ▝▀▘  ▀    ▀▀▀
#
consoleReset() {
    echo -en '\033[0m' # Reset
}

__consoleEscape() {
    local start=$1 end=$2 nl=1
    shift
    shift
    if [ -z "$*" ]; then
        echo -ne "$start"
    else
        if [ "$1" = "-n" ]; then
            nl=
            shift
        fi
        echo -ne "$start"
        echo -n "$@"
        echo -ne "$end"
        if test "$nl"; then
            echo
        fi
    fi
}

allColorTest() {
    local i j n

    i=0
    while [ $i -lt 11 ]; do
        j=0
        while [ $j -lt 10 ]; do
            n=$((10 * i + j))
            if [ $n -gt 108 ]; then
                break
            fi
            printf "\033[%dm %3d\033[0m" $n $n
            j=$((j + 1))
        done
        echo
        i=$((i + 1))
    done
}

colorTest() {
    local i colors=(
        consoleRed consoleGreen consoleCyan consoleBlue consoleOrange
        consoleMagenta consoleBlack consoleWhite consoleBoldMagenta consoleUnderline
        consoleBold consoleBoldRed consoleCode consoleWarning consoleSuccess
        consoleDecoration consoleError consoleLabel consoleValue
    )
    for i in "${colors[@]}"; do
        $i "$i: The quick brown fox jumped over the lazy dog."
    done
}

#
# Color-based
#
consoleRed() {
    __consoleEscape '\033[31m' '\033[0m' "$@"
}
consoleGreen() {
    __consoleEscape '\033[92m' '\033[0m' "$@"
}
consoleCyan() {
    __consoleEscape '\033[36m' '\033[0m' "$@"
}
consoleBlue() {
    __consoleEscape '\033[94m' '\033[0m' "$@"
}
consoleBlackBackground() {
    __consoleEscape '\033[48;5;0m' '\033[0m' "$@"
}
consoleYellow() {
    __consoleEscape '\033[48;5;16;38;5;11m' '\033[0m' "$@"
}
consoleOrange() {
    # see https://i.stack.imgur.com/KTSQa.png
    __consoleEscape '\033[38;5;214m' '\033[0m' "$@"
}

# shellcheck disable=SC2120
consoleMagenta() {
    __consoleEscape '\033[35m' '\033[0m' "$@"
}
consoleBlack() {
    __consoleEscape '\033[30m' '\033[0m' "$@"
}
consoleWhite() {
    __consoleEscape '\033[48;5;0;37m' '\033[0m' "$@"
}
consoleBoldMagenta() {
    __consoleEscape '\033[1m\033[35m' '\033[0m' "$@"
}

#
# Styles
#
consoleUnderline() {
    __consoleEscape '\033[4m' '\033[24m' "$@"
}
consoleBold() {
    __consoleEscape '\033[1m' '\033[21m' "$@"
}
consoleBoldRed() {
    __consoleEscape '\033[31m' '\033[0m' "$@"
}
consoleNoBold() {
    echo -en '\033[21m'
}
consoleNoUnderline() {
    echo -en '\033[24m'
}

#
# Semantics-based
#

#
# info
#
consoleInfo() {
    consoleCyan "$@"
}

#
# code or variables in output
#
consoleCode() {
    consoleGreen "$@"
}

#
# warning things are not normal
#
consoleWarning() {
    consoleOrange "$@"
}

#
# things went well
#
consoleSuccess() {
    consoleGreen "$@"
}

#
# decorations to output (like bars and lines)
#
# shellcheck disable=SC2120
consoleDecoration() {
    consoleBoldMagenta "$@"
}

#
# things went poorly
#
consoleError() {
    __consoleEscape '\033[1;31m' '\033[0m' "$@"
}

#
# Name/Value pairs
#
consoleLabel() {
    consoleOrange "$@"
}

#
# Name/Value pairs
#
consoleValue() {
    consoleMagenta "$@"
}

#
# consoleNameValue characterWidth name value...
#
consoleNameValue() {
    local characterWidth=$1 name=$2
    shift
    shift
    name="$(consoleLabel -n "$name")"
    echo "$(alignRight "$characterWidth" "$name") $(consoleValue -n "$@")"
}

#
# Clears current line of text in the console
#
clearLine() {
    echo -en "\r$(repeat "$(consoleColumns)" " ")\r"
}

#
# Output a status line using a colorAction
#
# This is intended for messages on a line which are then overwritten using clearLine
#
statusMessage() {
    local consoleAction=$1

    shift
    clearLine
    "$consoleAction" -n "$@"
}

#
# Column count in current console
#
consoleColumns() {
    if [ -z "${TERM:-}" ] || [ "${TERM:-}" = "dumb" ]; then
        echo -n 80
    else
        tput cols
    fi
}

backticksHighligh() {
    toggleCharacterToColor '`' "$(consoleCode)"
}

#
# Usage: toggleCharacterToColor character colorOn [ colorOff ]
# Argument: character - The character to map to color start/stop
# Argument: colorOn - Color on escape sequence
# Argument: colorOff - Color off escape sequence defaults to "$(consoleReset)"
#
toggleCharacterToColor() {
    local character line code reset lastLine=

    # shellcheck disable=SC2119
    character=$1
    code="$2"
    reset="${3-$(consoleReset)}"
    while true; do
        if ! IFS="$character" read -r -a line; then
            lastLine=1
        fi
        odd=0
        while [ ${#line[@]} -gt 0 ]; do
            if [ $((odd & 1)) -eq 1 ]; then
                printf "%s%s%s" "$code" "${line[0]}" "$reset"
            else
                printf "%s" "${line[0]}"
            fi
            unset 'line[0]'
            line=("${line[@]+${line[@]}}")
            odd=$((odd + 1))
        done
        printf "\n"
        if test $lastLine; then
            return 0
        fi
    done
}
