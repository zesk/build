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
# Reset the color
#
# This is typically appended after most `consoleAction` calls to reset the state of the console to default color and style.
#
# It does *not* take the optional `-n` argument ever, and outputs the reset escape sequence to standard out.
#
consoleReset() {
    echo -en '\033[0m' # Reset
}

__consoleEscape() {
    local start=$1 end=$2 nl="\n"
    shift
    shift
    if [ -z "$*" ]; then
        printf "%s$start" ""
    else
        if [ "$1" = "-n" ]; then
            nl=
            shift
        fi
        printf "$start%s$end$nl" "$*"
    fi
}
# Short Description: Alternate color output
# If you want to explore what colors are available in your terminal, try this.
#
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

# Short Description: Output colors
# Outputs sample sentences for the `consoleAction` commands to see what they look like.
#
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

# Short Description: Output a name value pair
#
# Utility function which is similar to `usageGenerator` except it operates on a line at a time. The name is output
# right-aligned to the `characterWidth` given and colored using `consoleLabel`; the value colored using `consoleValue`.
#
# Usage: consoleNameValue characterWidth name [ value ... ]
# Argument: characterWidth - Required. Number of characters to format the value for spacing
# Argument: name - Required. Name to output
# Argument: value ... - Optional. One or more Value to output
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
# Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.
#
# Short Description: Clear a line in the console
# Usage: clearLine
# Environment: Intended to be run on an interactive console. Should support `tput cols`.
# Example: statusMessage consoleInfo Loading...; bin/load.sh >>"$loadLogFile";
# Example: clearLine
#
clearLine() {
    echo -en "\r$(repeat "$(consoleColumns)" " ")\r"
}

#
# Output a status line using a colorAction
#
# This is intended for messages on a line which are then overwritten using clearLine
#
# Short Description: Output a status message with no newline
# Clears the line and outputs a message using a color command. Meant to show status but not use up an output line for it.
# Usage: statusMessage consoleAction message [ ... ]
# Argument: consoleAction - Required. String. Is one of **Semantic color commands** above or **Color commands** above
# Argument: message ... - Message to output
# Environment: Intended to be run on an interactive console. Should support $(tput cols).
# Example: statusMessage Loading...
# Example: bin/load.sh >>"$loadLogFile"
# Example: clearLine
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
# Output the number of columns in the terminal. Default is 80 if not able to be determined from `TERM`.
# Usage: consoleColumns
# Environment: Uses the `tput cols` tool to find the value if `TERM` is non-blank.
# Example: repeat $(consoleColumns)
#
consoleColumns() {
    if [ -z "${TERM:-}" ] || [ "${TERM:-}" = "dumb" ]; then
        echo -n 80
    else
        tput cols
    fi
}

#
# Usage: simpleMarkdownToConsole < $markdownFile
# Converts backticks, bold and italic to console colors.
#
simpleMarkdownToConsole() {
    # shellcheck disable=SC2119
    toggleCharacterToColor '`' "$(consoleCode)" | toggleCharacterToColor '**' "$(consoleError)" | toggleCharacterToColor '*' "$(consoleInfo)"
}

#
# Usage: toggleCharacterToColor character colorOn [ colorOff ]
# Argument: character - The character to map to color start/stop
# Argument: colorOn - Color on escape sequence
# Argument: colorOff - Color off escape sequence defaults to "$(consoleReset)"
#
toggleCharacterToColor() {
    local sequence line code reset lastItem lastLine=

    # shellcheck disable=SC2119
    sequence="$(quoteSedPattern "$1")"
    # sequence="$1"
    code="$2"
    reset="${3-$(consoleReset)}"
    while true; do
        if ! IFS= read -r line; then
            lastLine=1
        fi
        lastItem=
        odd=0
        while true; do
            # shellcheck disable=SC2295
            text="${line%%$sequence*}"
            # shellcheck disable=SC2295
            remain="${line#*$sequence}"
            if [ "$text" = "$remain" ]; then
                lastItem=1
            else
                line="$remain"
            fi
            if [ $((odd & 1)) -eq 1 ]; then
                printf "%s%s%s" "$code" "$text" "$reset"
            else
                printf "%s" "$text"
            fi
            if test $lastItem; then
                printf "\n"
                break
            fi
            odd=$((odd + 1))
        done
        if test "$lastLine"; then
            return 0
        fi
    done
}
