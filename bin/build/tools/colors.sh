#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
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

  export BUILD_COLORS_MODE

  __catchEnvironment "$usage" buildEnvironmentLoad BUILD_COLORS_MODE || return $?

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
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
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "${BUILD_COLORS_MODE-}" ] || __throwArgument "$usage" "Empty BUILD_COLORS_MODE" || return $?
  printf "%s\n" "${BUILD_COLORS_MODE-}"
}
_consoleColorMode() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn}
# Exit Code: 0 - Supports console animation
# Exit Code; 1 - Does not support console animation
#
hasConsoleAnimation() {
  # Important: This can *not* use buildEnvironmentLoad - leads to infinite loops
  export CI
  [ -z "${CI-}" ]
}

# Fake `hasConsoleAnimation` for testing
# Usage: {fn} --end | true | false
# Argument: --end - Flag. Optional. Resets the value for console animation to the saved value.
# Argument: true | false - Boolean. Force the value of hasConsoleAnimation to this value temporarily. Saves the original value.
# Developer Note: Keep this here to keep it close to the definition it modifies
__mockConsoleAnimation() {
  local usage="_${FUNCNAME[0]}" flag="${1-}"

  shift || __catchArgument "$usage" "Missing argument" || return $?
  if [ "$flag" = "--end" ]; then
    __mockValue CI __MOCKED_CI "$flag" "$@"
    return 0
  fi

  isBoolean "$flag" || __throwArgument "$usage" "Requires true or false (or --end)" || return $?
  __mockValue CI __MOCKED_CI "$(_choose "$flag" "" "testCI")" "$@"
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
    red bold-red
    green bold-green
    blue bold-blue
    cyan bold-cyan
    orange bold-orange
    magenta bold-magenta
    black bold-black
    black-contrast bold-black-contrast
    white bold-white
    underline
    bold
    code
    info
    notice
    success
    error
    label
    value
    warning
    decoration
    subtle
  )
  for i in "${colors[@]}"; do
    printf -- "%s%s\n" "$(decorate reset)" "$(decorate "$i" "$i: The quick brown fox jumped over the lazy dog.")"
  done
}

# Summary: Output colors
# Outputs sample sentences for the `action` commands to see what they look like.
#
semanticColorTest() {
  local extra

  if ! buildEnvironmentLoad BUILD_COLORS_MODE; then
    return 1
  fi
  extra=
  if [ -z "$BUILD_COLORS_MODE" ]; then
    BUILD_COLORS_MODE=$(consoleConfigureColorMode)
    extra="$(magenta Computed)"
  fi
  if [ -z "$BUILD_COLORS_MODE" ]; then
    decorate error "BUILD_COLORS_MODE not set"
  else
    printf "%s%s\n" "$(decorate pair 25 "BUILD_COLORS_MODE:" "$BUILD_COLORS_MODE")" "$extra"
  fi
  local i colors=(
    info
    success
    notice
    warning
    error
    code
    label
    value
    decoration
    subtle
  )
  for i in "${colors[@]}"; do
    decorate reset
    decorate "$i" "$i: The quick brown fox jumped over the lazy dog."
  done
}

# fn: decorate pair
# Summary: Output a name value pair (decorate extension)
#
# The name is output left-aligned to the `characterWidth` given and colored using `decorate label`; the value colored using `decorate value`.
#
# Usage: decorate pair [ characterWidth ] name [ value ... ]
# Argument: characterWidth - Optional. Number of characters to format the value for spacing. Uses environment variable BUILD_PAIR_WIDTH if not set.
# Argument: name - Required. Name to output
# Argument: value ... - Optional. One or more Values to output as values for `name` (single line)
# Environment: BUILD_PAIR_WIDTH
# shellcheck disable=SC2120
__decorateExtensionPair() {
  local width name

  if isUnsignedInteger "${1-}"; then
    width="$1" && shift
  fi
  if [ -z "$width" ]; then
    width=$(buildEnvironmentGet BUILD_PAIR_WIDTH)
  fi
  name="${1-}" && shift
  [ -n "$name" ] || return 0
  printf "%s %s\n" "$(decorate label "$(alignLeft "$width" "$name")")" "$(decorate each value "$@")"
}

#
# Clears current line of text in the console
#
# Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.
#
# Summary: Clear a line in the console
# Usage: clearLine textToOutput
# Environment: Intended to be run on an interactive console. Should support `tput cols`.
# Example:     clearLine
#
clearLine() {
  if hasConsoleAnimation; then
    printf -- "\r%s\r%s" "$(repeat "$(consoleColumns)" " ")" "$*"
  else
    printf -- "%s\n" "$*"
  fi
}

# IDENTICAL _clearLine 8

# Simple blank line generator for scripts
# Usage: {fn}
# Requires: read stty printf seq sed
_clearLine() {
  local width
  read -d' ' -r width < <(stty size) || width=80 && printf "\r%s\r" "$(seq -s' ' "$((width + 1))" | sed 's/[0-9]//g')"
}

#
# Output a status line
#
# This is intended for messages on a line which are then overwritten using clearLine
#
# Summary: Output a status message with no newline
# Clears the line and outputs a message using a command. Meant to show status but not use up an output line for it.
# Usage: statusMessage command ...
# Argument: command - Required. Commands which output a message.
# Argument: --last - Optional. Flag. Last message to be output, so output a newline as well at the end.
# Environment: Intended to be run on an interactive console. Should support $(tput cols).
# Example:     statusMessage decorate info "Loading ..."
# Example:     bin/load.sh >>"$loadLogFile"
# Example:     clearLine
#
statusMessage() {
  local usage="_${FUNCNAME[0]}"
  local lastMessage=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --first)
        if ! hasConsoleAnimation; then
          shift
          __catchEnvironment "$usage" printf -- "%s" "$("$@")" || return $?
          return 0
        fi
        ;;
      --last)
        if hasConsoleAnimation; then
          lastMessage=$'\n'
        fi
        ;;
      -*)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
      *)
        break
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  clearLine "$("$@")${lastMessage}"
}
_statusMessage() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Quiet test for a TTY.
# Environment: - __BUILD_HAS_TTY - Cached value of `false` or `true`. Any other value forces computation during this call.
# Credits: Tim Perry
# URL: https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional
isTTYAvailable() {
  export __BUILD_HAS_TTY

  if [ "${__BUILD_HAS_TTY-}" != "true" ] && [ "${__BUILD_HAS_TTY-}" != "false" ]; then
    if bash -c ": >/dev/tty" >/dev/null 2>/dev/null; then
      __BUILD_HAS_TTY=true
      return 0
    else
      __BUILD_HAS_TTY=false
      return 1
    fi
  fi
  "$__BUILD_HAS_TTY"
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
  if ! isTTYAvailable; then
    printf "%d" 120
  else
    local size
    IFS=" " read -r -a size < <(stty size </dev/tty 2>/dev/null) || :
    isInteger "${size[1]}" && printf "%d" "${size[1]}" || printf "%d" 120
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
  if ! isTTYAvailable; then
    printf "%d" 120
  else
    local rows _
    IFS=" " read -r rows _ < <(stty size </dev/tty 2>/dev/null) || :
    isInteger "$rows" && printf "%d" "$rows" || printf "%d" 80
  fi
}

#
# Converts backticks, bold and italic to console colors.
#
# Usage: simpleMarkdownToConsole < $markdownFile
#
simpleMarkdownToConsole() {
  # shellcheck disable=SC2119
  _toggleCharacterToColor '`' "$(decorate code)" | _toggleCharacterToColor '**' "$(decorate red)" | _toggleCharacterToColor '*' "$(decorate cyan)"
}

# Credit: https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/POYNTON1/ColorFAQ.html#RTFToC11
# Return an integer between 0 and 100
# Colors are between 0 and 255
# Usage: {fn} r g b
# Argument: redValue - Integer. Optional. Red RGB value (0-255)
# Argument: greenValue - Integer. Optional. Red RGB value (0-255)
# Argument: blueValue - Integer. Optional. Red RGB value (0-255)
# stdin: 3 integer values [ Optional ]
colorBrightness() {
  local usage="_${FUNCNAME[0]}"
  local r g b

  if [ $# -eq 0 ]; then
    # 0.299 R + 0.587 G + 0.114 B
    read -r r g b || :
  elif [ $# -eq 3 ]; then
    r=$1 g=$2 b=$3
  else
    __throwArgument "$usage" "Requires 3 arguments" || return $?
  fi
  __catchArgument "$usage" isUnsignedInteger "$r" || return $?
  __catchArgument "$usage" isUnsignedInteger "$g" || return $?
  __catchArgument "$usage" isUnsignedInteger "$b" || return $?
  printf "%d\n" $(((r * 299 + g * 587 + b * 114) / 2550))
}
_colorBrightness() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Credit: Mark Ransom
# URL: https://stackoverflow.com/questions/141855/programmatically-lighten-a-color
# Originally written in Python
# Requires: bc printf tee cut clampDigits
__colorNormalize() {
  local red=$1 green=$2 blue=$3 threshold=255

  maxColor=$red
  [ "$green" -le "$maxColor" ] || maxColor=$green
  [ "$blue" -le "$maxColor" ] || maxColor=$blue
  if [ "$maxColor" -le "$threshold" ]; then
    printf "%d\n" "$red" "$green" "$blue"
    return
  fi
  local total=$((red + green + blue))
  if [ $total -gt $((3 * threshold)) ]; then
    printf "%d\n" "$threshold" "$threshold" "$threshold"
    return
  fi
  local fThreshold=255.999
  printf "%s\n" "f=(3*$fThreshold-$total)/(3*$maxColor-$total)" "gray=$fThreshold-f*$maxColor" "m=gray*f" "$red+m" "$green+m" "$blue+m" | tee bc.log | bc --scale=2 | cut -f 1 -d . | clampDigits 0 255
}

# Redistribute color values to make brightness adjustments more balanced
# Requires: bc __catchEnvironment read usageArgumentUnsignedInteger packageWhich __colorNormalize
colorNormalize() {
  local usage="_${FUNCNAME[0]}"

  __catchEnvironment "$usage" packageWhich bc bc || return $?
  local red green blue
  if [ $# -eq 0 ]; then
    local done=false
    while ! $done; do
      IFS=$'\n' read -d'' -r red green blue || done=true
      red=$(usageArgumentUnsignedInteger "$usage" "redValue" "$red") || return $?
      green=$(usageArgumentUnsignedInteger "$usage" "greenValue" "$green") || return $?
      blue=$(usageArgumentUnsignedInteger "$usage" "blueValue" "$blue") || return $?
      __colorNormalize "$red" "$green" "$blue"
    done
  else
    while [ $# -gt 0 ]; do
      red=$(usageArgumentUnsignedInteger "$usage" "redValue" "${1-}") && shift || return $?
      green=$(usageArgumentUnsignedInteger "$usage" "greenValue" "${1-}") && shift || return $?
      blue=$(usageArgumentUnsignedInteger "$usage" "blueValue" "${1-}") && shift || return $?
      __colorNormalize "$red" "$green" "$blue"
    done
  fi
}
_colorNormalize() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Clamp digits between two integers
clampDigits() {
  local min="${1-}" max="${2-}" number

  while read -r number; do
    isInteger "$number" || continue
    if isInteger "$min" && [ "$number" -lt "$min" ]; then
      printf -- "%d\n" "$min"
    elif isInteger "$max" && [ "$number" -gt "$max" ]; then
      printf -- "%d\n" "$max"
    else
      printf -- "%d\n" "$number"
    fi
    shift
  done
}

__colorHexToInteger() {
  local color="${1-}"
  printf "%d\n" "0x${color:0:2}" "0x${color:2:2}" "0x${color:4:2}" 2>/dev/null
}

__colorParse() {
  local color="$1"
  case "${#color}" in
    3) __colorHexToInteger "${color:0:1}${color:0:1}${color:1:1}${color:1:1}${color:2:1}${color:2:1}" ;;
    6) __colorHexToInteger "$color" ;;
    *) printf "%s\n" "hex-length" 1>&2 && return 1 ;;
  esac
}
__colorParseArgument() {
  local argument="${1-}"
  case "$argument" in
    [[:xdigit:]]*) __colorParse "$argument" || return 1 ;;
    [[:alpha:]]*:[[:xdigit:]]*) __colorParse "${argument#*:}" || return 1 ;;
    *) printf -- "%s\n" "invalid-color" 1>&2 && return 1 ;;
  esac
}

# Take r g b decimal values and convert them to hex color values
# stdin: list:UnsignedInteger
# Argument: red - UnsignedInteger. Optional. Red component.
# Argument: green - UnsignedInteger. Optional. Blue component.
# Argument: blue - UnsignedInteger. Optional. Green component.
# Takes arguments or stdin values in groups of 3.
colorFormat() {
  local usage="_${FUNCNAME[0]}" format="%0.2X%0.2X%0.2X\n"
  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      local r g b

      r=$(usageArgumentUnsignedInteger "$usage" "red" "${1-}") && shift || return $?
      g=$(usageArgumentUnsignedInteger "$usage" "green" "${1-}") && shift || return $?
      b=$(usageArgumentUnsignedInteger "$usage" "blue" "${1-}") && shift || return $?

      # shellcheck disable=SC2059
      printf -- "$format" "$r" "$g" "$b"
    done
  else
    local done=false
    while ! $done; do
      IFS=$'\n' read -d"" -r r g b || done=true
      # shellcheck disable=SC2059
      isUnsignedInteger "$r" && isUnsignedInteger "$g" && isUnsignedInteger "$b" && printf -- "$format" "$r" "$g" "$b"
    done
  fi
}
_colorFormat() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Parse a color and output R G B decimal values
# stdin: list:colors
# Argument: color - String. Optional. Color to parse.
# Takes arguments or stdin.
colorParse() {
  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      __colorParseArgument "$1" || return $?
      shift
    done
  else
    local color
    while read -r color; do
      __colorParseArgument "$color" || return $?
    done
  fi
}
_colorParse() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: factor - floatValue. Required. Red RGB value (0-255)
# Argument: redValue - Integer. Required. Red RGB value (0-255)
# Argument: greenValue - Integer. Required. Red RGB value (0-255)
# Argument: blueValue - Integer. Required. Red RGB value (0-255)
colorMultiply() {
  local usage="_${FUNCNAME[0]}"
  local factor colors=()

  __catchEnvironment "$usage" packageWhich bc bc || return $?
  factor=$(usageArgumentString "$usage" "factor" "${1-}") && shift || return $?

  local red green blue
  if [ $# -gt 0 ]; then
    colors=("$@")
  else
    local color && while read -r color; do colors+=("$color"); done
  fi

  set -- "${colors[@]+"${colors[@]}"}"
  while [ $# -gt 0 ]; do
    local red green blue
    red=$(usageArgumentUnsignedInteger "$usage" "redValue" "${1-}") && shift || return $?
    green=$(usageArgumentUnsignedInteger "$usage" "greenValue" "${1-}") && shift || return $?
    blue=$(usageArgumentUnsignedInteger "$usage" "blueValue" "${1-}") && shift || return $?
    bc <<<"m=$factor;$red*m;$green*m;$blue*m" | cut -d . -f 1
  done
}
_colorMultiply() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Internal
#
# Utility function to help with simpleMarkdownToConsole
# Usage: toggleCharacterToColor character colorOn [ colorOff ]
# Argument: character - The character to map to color start/stop
# Argument: colorOn - Color on escape sequence
# Argument: colorOff - Color off escape sequence defaults to "$(decorate reset)"
#
_toggleCharacterToColor() {
  local sequence line code reset lastItem lastLine=

  # TODO is quoteSedPattern correct for BASH // replacement?
  sequence="$(quoteSedPattern "$1")"
  code="$2"
  reset="${3-$(decorate reset)}"
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

# Usage: decorate each decoration argument1 argument2 ...
# Runs the following command on each subsequent argument to allow for formatting with spaces
__decorateExtensionEach() {
  local code="$1" formatted=()

  shift || return 0
  while [ $# -gt 0 ]; do
    formatted+=("$(decorate "$code" "$1")")
    shift
  done
  IFS=" " printf "%s\n" "${formatted[*]-}"
}
