#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: text.sh
# bin: test echo printf
# Docs: o ./docs/_templates/tools/colors.md
# Test: o ./test/tools/colors-tests.sh

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
  if hasColors; then
    echo -en '\033[0m' # Reset
  fi
}

#
# Set colors to deal with dark or light-background consoles
# See:
#
consoleColorMode() {
  export BUILD_COLORS_MODE

  # shellcheck source=/dev/null
  if ! buildEnvironmentLoad BUILD_COLORS_MODE; then
    return 1
  fi

  case "$1" in
    --dark)
      BUILD_COLORS_MODE=dark
      ;;
    --light)
      BUILD_COLORS_MODE=light
      ;;
    *)
      consoleError "Unknown console mode $1" 1>&2
      return 1
      ;;
  esac
}

#
# Usage: hasConsoleAnimation
# Exit Code: 0 - Supports console animation
# Exit Code; 1 - Does not support console animation
#
hasConsoleAnimation() {
  # Important: This can *not* use loadBuildEnvironment
  export CI
  [ -z "${CI-}" ]
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

colorComboTest() {
  local fg bg text extra padding
  extra=
  if [ "$1" = "--bold" ]; then
    shift || :
    extra=";1"
  fi
  text="${*-" ABC "}"
  padding="$(repeat $((${#text} - 3)) " ")"
  printf "   "
  for fg in $(seq 30 37) $(seq 90 97); do
    printf "\033[%d%sm%3d%s\033[0m " "$fg" "$extra" "$fg" "$padding"
  done
  printf "\n"
  for bg in $(seq 40 47) $(seq 100 107); do
    printf "\033[%d%sm%3d\033[0m " "$bg" "$extra" "$bg"
    for fg in $(seq 30 37) $(seq 90 97); do
      printf "\033[%d;%d%sm$text\033[0m " "$fg" "$bg" "$extra"
    done
    printf "\n"
  done
}

# Summary: Output colors
# Outputs sample sentences for the `consoleAction` commands to see what they look like.
#
colorTest() {
  local i colors=(
    consoleRed consoleBoldRed
    consoleGreen consoleBoldGreen
    consoleBlue consoleBoldBlue
    consoleCyan consoleBoldCyan
    consoleOrange consoleBoldOrange
    consoleMagenta consoleBoldMagenta
    consoleBlack consoleBoldBlack
    consoleWhite consoleBoldWhite
    consoleUnderline
    consoleBold
    consoleCode
    consoleSuccess
    consoleError
    consoleLabel
    consoleValue
    consoleWarning
    consoleDecoration
    consoleSubtle
  )
  for i in "${colors[@]}"; do
    consoleReset
    $i "$i: The quick brown fox jumped over the lazy dog."
  done
}

# Summary: Output colors
# Outputs sample sentences for the `consoleAction` commands to see what they look like.
#
semanticColorTest() {
  local i colors extra

  colors=(
    consoleInfo
    consoleSuccess
    consoleWarning
    consoleError
    consoleCode
    consoleLabel
    consoleValue
    consoleDecoration
    consoleSubtle
  )

  if ! buildEnvironmentLoad BUILD_COLORS_MODE; then
    return 1
  fi
  extra=
  if [ -z "$BUILD_COLORS_MODE" ]; then
    BUILD_COLORS_MODE=$(consoleConfigureColorMode)
    extra="$(consoleMagenta Computed)"
  fi
  if [ -z "$BUILD_COLORS_MODE" ]; then
    consoleError "BUILD_COLORS_MODE not set"
  else
    printf "%s%s\n" "$(consoleNameValue 25 "BUILD_COLORS_MODE:" "$BUILD_COLORS_MODE")" "$extra"
  fi
  for i in "${colors[@]}"; do
    consoleReset
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
consoleBoldRed() {
  __consoleEscape '\033[31;1m' '\033[0m' "$@"
}

consoleGreen() {
  _consoleGreen "" "$@"
}
_consoleGreen() {
  local label="$1"
  shift
  __consoleOutput "$label" '\033[92m' '\033[0m' "$@"
}
consoleBoldGreen() {
  __consoleOutput "" '\033[1;92m' '\033[0m' "$@"
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
consoleBoldCyan() {
  __consoleOutput "" '\033[36;1m' '\033[0m' "$@"
}
consoleBlackBackground() {
  __consoleEscape '\033[48;5;0m' '\033[0m' "$@"
}
consoleYellow() {
  __consoleEscape '\033[48;5;16;38;5;11m' '\033[0m' "$@"
}

# shellcheck disable=SC2120
consoleMagenta() {
  __consoleEscape '\033[35m' '\033[0m' "$@"
}
consoleBlack() {
  __consoleEscape '\033[109;7m' '\033[0m' "$@"
}
consoleBoldBlack() {
  __consoleEscape '\033[109;7;1m' '\033[0m' "$@"
}
consoleBoldWhite() {
  __consoleEscape '\033[48;5;0;37;1m' '\033[0m' "$@"
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
  __consoleEscape '\033[1m' '\033[0m' "$@"
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
# Usage: {fn} label lightStartCode darkStartCode endCode [ -n ] [ message ]
#
__consoleOutputMode() {
  local label="$1" start
  export BUILD_COLORS_MODE

  shift || :
  if [ "${BUILD_COLORS_MODE-}" = "dark" ]; then
    shift || :
    __consoleOutput "$label" "$@"
  else
    start="$1"
    shift || :
    shift || :
    __consoleOutput "$label" "$start" "$@"
  fi
}

#
# info
#
# shellcheck disable=SC2120
consoleInfo() {
  _consoleInfo "Info" "$@"
}
_consoleInfo() {
  local label="$1"
  shift || :
  __consoleOutputMode "$label" '\033[38;5;20m' '\033[38;5;159m' '\033[0m' "$@"
}

#
# warning things are not normal
#
# shellcheck disable=SC2120
consoleWarning() {
  __consoleOutput "Warning" '\033[1;93;41m' '\033[0m' "$@"
}

#
# things went well
#
# shellcheck disable=SC2120
consoleSuccess() {
  __consoleOutput "SUCCESS" '\033[1;42;97m' '\033[0m' "$@"
}

#
# decorations to output (like bars and lines)
#
# shellcheck disable=SC2120
consoleDecoration() {
  __consoleOutputMode '' '\033[30;94m' '\033[45;94m' '\033[0m' "$@"
}

#
# Keep things subtle
#
consoleSubtle() {
  __consoleOutputMode '' '\033[1;38;5;252m' '\033[1;38;5;240m' '\033[0m' "$@"
}

#
# things went poorly
#

#
# Name/Value pairs
#
# shellcheck disable=SC2120
consoleLabel() {
  __consoleOutputMode '' '\033[34;103m' '\033[1;96m' '\033[0m' "$@"
}

#
# Name/Value pairs
#
# shellcheck disable=SC2120
consoleValue() {
  __consoleOutputMode '' '\033[1;40;97m' '\033[1;97m' '\033[0m' "$@"
}

#
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
  shift 2 && printf "%s %s\n" "$(consoleLabel "$(alignLeft "$characterWidth" "$name")")" "$(consoleValue "$@")"
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

# IDENTICAL _clearLine 4
_clearLine() {
  local width
  read -d' ' -r width < <(stty size) || : && printf "\r%s\r" "$(seq -s' ' "$((width + 1))" | sed 's/[0-9]//g')"
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
# Environment: COLUMNS - May be defined after calling this
# Environment: LINES - May be defined after calling this
# Side Effect: MAY define two environment variables
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

  sequence="$(quoteSedPattern "$1")"
  code="$2"
  reset="${3-$(consoleReset)}"
  while true; do
    if ! IFS= read -r line; then
      lastLine=1
    fi
    if [ -z "$line" ]; then
      printf "\n"
    else
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
          lastItem=
          break
        fi
        odd=$((odd + 1))
      done
    fi
    if test "$lastLine"; then
      return 0
    fi
  done
}
