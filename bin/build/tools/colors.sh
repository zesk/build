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
    printf "\e[0m"
  fi
}

# This modifies text containing escape sequences to best make text look correct
__wrapColor() {
  local escapeColor=$'\e'"[" prefix="$1" && shift
  local suffix="${escapeColor}0m" text="$*" _magic="¢" start starts end ends

  # "This is a (1word) and (2phrase)"
  text="${text//$suffix/$_magic}"
  # "This is a (1word* and (2phrase*"
  IFS="$_magic" read -r -a starts <<<"$text" || :
  # [ "This is a (1word", " and (2phrase", "" ]
  if [ "${#starts[@]}" -ge 1 ]; then
    for start in "${starts[@]}"; do
      # "This is a (1word"
      start="${start//$escapeColor/$_magic}"
      # "This is a (1word"
      IFS="$_magic" read -r -a ends <<<"$start" || :
      # [ "This is a ", "1word" ]
      if [ "${#ends[@]}" -eq 2 ]; then
        printf "%s" "$prefix"
        printf "%s" "${ends[0]}"
        printf "%s" "$suffix"
        printf "%s%s" "$escapeColor" "${ends[1]}"
      else
        # starts are divided by "$suffix" so must be added back
        printf -- "%s%s%s" "$prefix" "$start" "$suffix"
      fi
    done
  else
    printf -- "%s%s%s" "$prefix" "$text" "$suffix"
  fi
}

#
# Set colors to deal with dark or light-background consoles
# Usage: {fn} [ --dark ] [ --light ]
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --dark - Optional. Flag. Dark mode for darker backgrounds.
# Argument: --light - Optional. Flag. Light mode for lighter backgrounds.
# Environment: BUILD_COLORS_MODE
#
consoleColorMode() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved

  export BUILD_COLORS_MODE

  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_COLORS_MODE || return $?

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
      --dark)
        BUILD_COLORS_MODE=dark
        ;;
      --light)
        BUILD_COLORS_MODE=light
        ;;
      *)
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
  done

  [ -n "${BUILD_COLORS_MODE-}" ] || __failArgument "$usage" "Empty BUILD_COLORS_MODE" || return $?
  printf "%s\n" "${BUILD_COLORS_MODE-}"
}
_consoleColorMode() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn}
# Exit Code: 0 - Supports console animation
# Exit Code; 1 - Does not support console animation
#
hasConsoleAnimation() {
  # Important: This can *not* use loadBuildEnvironment
  export CI
  [ -z "${CI-}" ]
}

# Usage: {fn} prefix suffix [ text ]
# Argument: prefix - Required. String.
# Argument: suffix - Required. String.
# Argument: text ... - Optional. String.
__consoleEscape() {
  local start="$1" end="$2"
  shift && shift
  if hasColors; then
    if [ -z "$*" ]; then
      printf "%s$start" ""
    else
      printf "$start%s$end\n" "$*"
    fi
  else
    printf "%s\n" "$*"
  fi
}

# Usage: {fn} prefix suffix [ text ]
# Argument: prefix - Required. String.
# Argument: suffix - Required. String.
# Argument: text ... - Optional. String.
__consoleEscape1() {
  local start="$1"
  shift
  if hasColors; then
    if [ -z "$*" ]; then
      printf "%s$start" ""
    else
      __wrapColor "$start" "$@"
    fi
  else
    printf "%s\n" "$*"
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
  local top3=37

  extra="0;"
  if [ "$1" = "--bold" ]; then
    shift || :
    extra="1;"
  fi
  text="${*-" ABC "}"
  padding="$(repeat $((${#text} - 3)) " ")"
  printf "   "
  for fg in $(seq 30 "$top3") $(seq 90 97); do
    printf "\033[%s%dm%3d%s\033[0m " "$extra" "$fg" "$fg" "$padding"
  done
  printf "\n"
  for bg in $(seq 40 47) $(seq 100 107); do
    printf "\033[%s%dm%3d\033[0m " "$extra" "$bg" "$bg"
    for fg in $(seq 30 "$top3") $(seq 90 97); do
      printf "\033[%s%d;%dm$text\033[0m " "$extra" "$fg" "$bg"
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
  __consoleOutputMode "$label" '\033[38;5;20m' '\033[1;33m' '\033[0m' "$@"
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
# @see decoration
consoleSuccess() {
  __consoleOutputMode "SUCCESS" '\033[42;30m' '\033[0;32m' '\033[0m' "$@"
}

#
# decorations to output (like bars and lines)
#
# shellcheck disable=SC2120
# @see decoration
consoleDecoration() {
  __consoleOutputMode '' '\033[45;97m' '\033[45;30m' '\033[0m' "$@"
}

#
# Keep things subtle
#
# @see decoration
consoleSubtle() {
  __consoleOutputMode '' '\033[1;38;5;252m' '\033[1;38;5;240m' '\033[0m' "$@"
}

#
# things went poorly
#

#
# Name/Value pairs
#
# @see decoration
# shellcheck disable=SC2120
consoleLabel() {
  __consoleOutputMode '' '\033[34;103m' '\033[1;96m' '\033[0m' "$@"
}

#
# @see decoration
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
    printf "\r%s\r" "$(repeat "$(consoleColumns)" " ")"
  else
    printf "\n"
  fi
}

# IDENTICAL _clearLine 5
# Simple blank line generator for scripts
_clearLine() {
  local width
  read -d' ' -r width < <(stty size) || width=80 && printf "\r%s\r" "$(seq -s' ' "$((width + 1))" | sed 's/[0-9]//g')"
}

#
# Output a status line using a colorAction
#
# This is intended for messages on a line which are then overwritten using clearLine
#
# Summary: Output a status message with no newline
# Clears the line and outputs a message using a color command. Meant to show status but not use up an output line for it.
# Usage: statusMessage command ...
# Argument: command - Required. Commands which output a message.
# Environment: Intended to be run on an interactive console. Should support $(tput cols).
# Example:     statusMessage consoleInfo "Loading ..."
# Example:     bin/load.sh >>"$loadLogFile"
# Example:     clearLine
#
statusMessage() {
  if hasConsoleAnimation; then
    printf "%s%s" "$(clearLine)" "$("$@")"
  else
    printf "%s\n" "$("$@")"
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
# Row count in current console
#
# Output the number of columns in the terminal. Default is 60 if not able to be determined from `TERM`.
# Usage: consoleColumns
# Environment: Uses the `tput lines` tool to find the value if `TERM` is non-blank.
# Example:     tail -n $(consoleRows) "$file"
# Environment: COLUMNS - May be defined after calling this
# Environment: LINES - May be defined after calling this
# Side Effect: MAY define two environment variables
consoleRows() {
  if [ -z "${TERM:-}" ] || [ "${TERM:-}" = "dumb" ]; then
    printf %d 60
  else
    tput lines
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

  # TODO is quoteSedPattern correct for BASH // replacement?
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
