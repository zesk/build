#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: text.sh
# bin: test echo printf
# Docs: contextOpen ./docs/_templates/tools/colors.md

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

#
# Usage: hasConsoleAnimation
# Exit Code: 0 - Supports console animation
# Exit Code; 1 - Does not support console animation
# Environment: CI - If this has a non-blank value, this returns true (supports animation)
#
hasConsoleAnimation() {
    [ -z "${CI-}" ]
}

# This tests whether `TERM` is set, and if not, uses the `DISPLAY` variable to set `BUILD_COLORS` IFF `DISPLAY` is non-empty.
# If `TERM1` is set then uses the `tput colors` call to determine the console support for colors.
#
# Usage: hasColors
# Exit Code: 0 - Console or output supports colors
# Exit Code; 1 - No colors
# Local Cache: this value is cached in BUILD_COLORS if it is not set.
# Environment: BUILD_COLORS - Override value for this
hasColors() {
    export BUILD_COLORS
    export TERM
    export DISPLAY

    BUILD_COLORS="${BUILD_COLORS-z}"
    if [ "z" = "$BUILD_COLORS" ]; then
        if [ -z "${TERM-}" ] || [ "${TERM-}" = "dumb" ]; then
            if [ -n "${DISPLAY-}" ]; then
                BUILD_COLORS=1
            else
                BUILD_COLORS=
            fi
        elif [ "$(tput colors)" -ge 8 ]; then
            BUILD_COLORS=1
        else
            BUILD_COLORS=
        fi
    elif [ -n "$BUILD_COLORS" ] && [ "$BUILD_COLORS" != "1" ]; then
        # Values allowed for this global are 1 and blank only
        BUILD_COLORS=
    fi
    test "$BUILD_COLORS"
}

__consoleEscape() {
    local start=$1 end=$2 nl="\n"
    shift
    shift
    if [ "${1-}" = "-n" ]; then
        nl=
        shift
    fi
    if hasColors; then
        if [ -z "$*" ]; then
            printf "%s$start" ""
        else
            printf "$start%s$end$nl" "$*"
        fi
    else
        printf "%s$nl" "$*"
    fi
}

__consoleOutput() {
    local prefix=$1 start=$2 end=$3 nl="\n"

    shift
    shift
    shift
    if [ "${1-}" = "-n" ]; then
        nl=
        shift
    fi
    if hasColors; then
        if [ -z "$*" ]; then
            printf "%s$start" ""
        else
            printf "$start%s$end$nl" "$*"
        fi
    elif [ -n "$*" ]; then
        if [ -n "$prefix" ]; then
            printf "%s: %s$nl" "$prefix" "$*"
        else
            printf "%s$nl" "$*"
        fi
    fi
}
#
# Summary: Alternate color output
# If you want to explore what colors are available in your terminal, try this.
#
allColorTest() {
    local i j n

    if ! hasColors; then
        printf "no colors\n"
        return 0
    fi
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
        printf "\n"
        i=$((i + 1))
    done
}

# Summary: Output colors
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
# shellcheck disable=SC2120
consoleRed() {
    _consoleRed '' "$@"
}
_consoleRed() {
    local label="$1"
    shift
    __consoleOutput "$label" '\033[31m' '\033[0m' "$@"
}
consoleGreen() {
    _consoleGreen "" "$@"
}
_consoleGreen() {
    local label="$1"
    shift
    __consoleOutput "$label" '\033[92m' '\033[0m' "$@"
}
# shellcheck disable=SC2120
consoleCyan() {
    _consoleCyan "" "$@"
}
_consoleCyan() {
    local label="$1"
    shift
    __consoleOutput "$label" '\033[36m' '\033[0m' "$@"
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
    _consoleOrange "" "$@"
}

_consoleOrange() {
    local label="$1"
    shift
    # see https://i.stack.imgur.com/KTSQa.png
    __consoleOutput "$label" '\033[38;5;214m' '\033[0m' "$@"
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
# shellcheck disable=SC2120
consoleInfo() {
    _consoleCyan Info "$@"
}
_consoleInfo() {
    _consoleCyan "$@"
}

#
# code or variables in output
#
# shellcheck disable=SC2120
consoleCode() {
    __consoleEscape '\033[30;102m' '\033[0m' "$@"
}

#
# warning things are not normal
#
# shellcheck disable=SC2120
consoleWarning() {
    _consoleOrange Warning "$@"
}

#
# things went well
#
# shellcheck disable=SC2120
consoleSuccess() {
    _consoleGreen SUCCESS "$@"
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
# shellcheck disable=SC2120
consoleError() {
    __consoleOutput ERROR '\033[1;31m' '\033[0m' "$@"
}

#
# Name/Value pairs
#
# shellcheck disable=SC2120
consoleLabel() {
    consoleOrange "$@"
}

#
# Name/Value pairs
#
# shellcheck disable=SC2120
consoleValue() {
    consoleMagenta "$@"
}

# Summary: Output a name value pair
#
# Utility function which is similar to `usageGenerator` except it operates on a line at a time. The name is output
# right-aligned to the `characterWidth` given and colored using `consoleLabel`; the value colored using `consoleValue`.
#
# Usage: consoleNameValue characterWidth name [ value ... ]
# Argument: characterWidth - Required. Number of characters to format the value for spacing
# Argument: name - Required. Name to output
# Argument: value ... - Optional. One or more Value to output
#
# shellcheck disable=SC2120
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
# Summary: Clear a line in the console
# Usage: clearLine
# Environment: Intended to be run on an interactive console. Should support `tput cols`.
# Example:     statusMessage consoleInfo Loading...; bin/load.sh >>"$loadLogFile";
# Example:     clearLine
#
clearLine() {
    if hasConsoleAnimation; then
        echo -en "\r$(repeat "$(consoleColumns)" " ")\r"
    fi
}

#
# Output a status line using a colorAction
#
# This is intended for messages on a line which are then overwritten using clearLine
#
# Summary: Output a status message with no newline
# Clears the line and outputs a message using a color command. Meant to show status but not use up an output line for it.
# Usage: statusMessage consoleAction message [ ... ]
# Argument: consoleAction - Required. String. Is one of **Semantic color commands** above or **Color commands** above
# Argument: message ... - Message to output
# Environment: Intended to be run on an interactive console. Should support $(tput cols).
# Example:     statusMessage Loading...
# Example:     bin/load.sh >>"$loadLogFile"
# Example:     clearLine
#
# shellcheck disable=SC2120
statusMessage() {
    local consoleAction=$1

    shift
    if hasConsoleAnimation; then
        clearLine
        "$consoleAction" -n "$@"
    else
        "$consoleAction" "$@"
    fi
}

#
# Column count in current console
#
# Output the number of columns in the terminal. Default is 80 if not able to be determined from `TERM`.
# Usage: consoleColumns
# Environment: Uses the `tput cols` tool to find the value if `TERM` is non-blank.
# Example:     repeat $(consoleColumns)
#
consoleColumns() {
    if [ -z "${TERM:-}" ] || [ "${TERM:-}" = "dumb" ]; then
        printf %d 80
    else
        tput cols
    fi
}

#
# Converts backticks, bold and italic to console colors.
#
# Usage: simpleMarkdownToConsole < $markdownFile
#
simpleMarkdownToConsole() {
    # shellcheck disable=SC2119
    _toggleCharacterToColor '`' "$(consoleCode)" | _toggleCharacterToColor '**' "$(consoleRed)" | _toggleCharacterToColor '*' "$(consoleCyan)"
}

#
# Internal
#
# Utility function to help with simpleMarkdownToConsole
# Usage: toggleCharacterToColor character colorOn [ colorOff ]
# Argument: character - The character to map to color start/stop
# Argument: colorOn - Color on escape sequence
# Argument: colorOff - Color off escape sequence defaults to "$(consoleReset)"
#
_toggleCharacterToColor() {
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
