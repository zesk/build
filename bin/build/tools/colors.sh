#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends: text.sh
# Docs: o ./documentation/source/tools/colors.md
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

#
# This modifies text containing escape sequences to best make text look correct
#
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
# BUILD_DEBUG: BUILD_COLORS_MODE
consoleColorMode() {
  local handler="_${FUNCNAME[0]}"

  export BUILD_COLORS_MODE

  catchReturn "$handler" buildEnvironmentLoad BUILD_COLORS_MODE || return $?

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --dark)
      BUILD_COLORS_MODE=dark
      if buildDebugEnabled BUILD_COLORS_MODE; then
        decorate info "BUILD_COLORS_MODE set to dark"
      fi
      ;;
    --light)
      BUILD_COLORS_MODE=light
      if buildDebugEnabled BUILD_COLORS_MODE; then
        decorate info "BUILD_COLORS_MODE set to light"
      fi
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ -n "${BUILD_COLORS_MODE-}" ] || throwArgument "$handler" "Empty BUILD_COLORS_MODE" || return $?
  printf "%s\n" "${BUILD_COLORS_MODE-}"
}
_consoleColorMode() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Does the console support animation?
# Return Code: 0 - Supports console animation
# Return Code: 1 - Does not support console animation
hasConsoleAnimation() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # Important: This can *not* use buildEnvironmentLoad - leads to infinite loops
  export CI
  [ -z "${CI-}" ]
}
_hasConsoleAnimation() {
  true || hasConsoleAnimation --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
colorSampleCodes() {
  local i j n

  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
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
_colorSampleCodes() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Show combinations of foreground and background colors in the console.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
colorSampleCombinations() {
  local fg bg text extra padding
  local top3=37

  __help "_${FUNCNAME[0]}" "$@" || return 0

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
_colorSampleCombinations() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Output colors
# Outputs sample sentences for the `consoleAction` commands to see what they look like.
#
colorSampleStyles() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
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
    printf -- "%s%s\n" "$(decorate reset --)" "$(decorate "$i" "$i: The quick brown fox jumped over the lazy dog.")"
  done
}
_colorSampleStyles() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Output colors
# Outputs sample sentences for the `action` commands to see what they look like.
#
colorSampleSemanticStyles() {
  local extra

  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"

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
    decorate reset --
    decorate "$i" "$i: The quick brown fox jumped over the lazy dog."
  done
}
_colorSampleSemanticStyles() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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

# Outputs a line and fills the remainder with space
plasterLines() {
  local handler="_${FUNCNAME[0]}"

  local line curX curY rows character=" "
  IFS=$'\n' read -r -d '' curX curY < <(cursorGet) || :
  isUnsignedInteger "$curX" || throwEnvironment "$handler" "cursorGet returned $curX $curY" || return $?
  isUnsignedInteger "$curY" || throwEnvironment "$handler" "cursorGet returned $curX $curY" || return $?
  rows=$(catchReturn "$handler" consoleRows) || return $?
  columns=$(catchReturn "$handler" consoleColumns) || return $?
  while IFS="" read -r line; do
    catchEnvironment "$handler" cursorSet 1 "$curY" || return $?
    printf "%s" "$line"
    IFS=$'\n' read -r -d '' curX _ < <(cursorGet) || :
    printf "%s" "$(repeat $((columns - curX)) "$character")"
    curY=$((curY + 1))
    [ $curY -le "$rows" ] || break
  done
  printf "\n"
}
_plasterLines() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a status message
#
# This is intended for messages on a line which are then overwritten using clearLine
#
# Summary: Output a status message and display correctly on consoles with animation and in log files
# Clears the line and outputs a message using a command. Meant to show status but not use up an output line for it.
# Usage: statusMessage command ...
# Argument: command - Required. Commands which output a message.
# Argument: --last - Optional. Flag. Last message to be output, so output a newline as well at the end.
# Argument: --first - Optional. Flag. First message to be output, only clears line if available.
# Argument: --inline - Optional. Flag. Inline message displays with newline when animation is NOT available.
#
# When `hasConsoleAnimation` is true:
#
# `--first` - clears the line and outputs the message starting at the left column, no newline
# `--last` - clears the line and outputs the message starting at the left column, with a newline
# `--inline` - Outputs the message at the cursor without a newline
#
# When `hasConsoleAnimation` is false:
#
# `--first` - outputs the message starting at the cursor, no newline
# `--last` - outputs the message starting at the cursor, with a newline
# `--inline` - Outputs the message at the cursor with a newline
#
# Environment: Intended to be run on an interactive console. Should support $(tput cols).
# Example:     statusMessage decorate info "Loading ..."
# Example:     bin/load.sh >>"$loadLogFile"
# Example:     clearLine
#
statusMessage() {
  local handler="_${FUNCNAME[0]}"
  local lastMessage=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --first)
      if ! hasConsoleAnimation; then
        shift
        printf -- "%s" "$("$@")"
        return 0
      fi
      ;;
    --inline)
      shift
      local suffix="\n"
      ! hasConsoleAnimation || suffix=""
      printf -- "%s$suffix" "$("$@")"
      return 0
      ;;
    --last)
      if hasConsoleAnimation; then
        lastMessage=$'\n'
      fi
      ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      muzzle usageArgumentCallable "$handler" "command" "${1-}" || return $?
      break
      ;;
    esac
    shift
  done
  clearLine "$("$@")${lastMessage}"
}
_statusMessage() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Quiet test for a TTY.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Environment: - `__BUILD_HAS_TTY` - Cached value of `false` or `true`. Any other value forces computation during this call.
# Credits: Tim Perry
# URL: https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional
isTTYAvailable() {
  export __BUILD_HAS_TTY

  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
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
_isTTYAvailable() {
  true || isTTYAvailable --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Column count in current console
#
# Output the number of columns in the terminal. Default is 80 if not able to be determined from `TERM`.
# Example:     repeat $(consoleColumns)
# Environment: - `COLUMNS` - May be defined after calling this
# Environment: - `LINES` - May be defined after calling this
# Side Effect: MAY define two environment variables
consoleColumns() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  if ! isTTYAvailable; then
    printf -- "%d" 120
  else
    shopt -s checkwinsize || :
    local size
    IFS=" " read -r -a size < <(stty size </dev/tty 2>/dev/null) || :
    local width="${size[1]}"
    if ! isPositiveInteger "$width"; then
      export COLUMNS
      if isPositiveInteger "${COLUMNS-}"; then
        width="$COLUMNS"
      else
        width=100
      fi
    fi
    printf -- "%d" "$width"
  fi
}
_consoleColumns() {
  true || consoleColumns --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Row count in current console
#
# Output the number of columns in the terminal. Default is 60 if not able to be determined from `TERM`.
# Usage: consoleColumns
# Example:     tail -n $(consoleRows) "$file"
# Environment: - `COLUMNS` - May be defined after calling this
# Environment: - `LINES` - May be defined after calling this
# Side Effect: MAY define two environment variables
consoleRows() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"

  if ! isTTYAvailable; then
    printf -- "%d" 60
  else
    shopt -s checkwinsize || :
    local height _
    IFS=" " read -r height _ < <(stty size </dev/tty 2>/dev/null) || :
    if ! isPositiveInteger "$height"; then
      export LINES
      if isPositiveInteger "${LINES-}"; then
        height="$LINES"
      else
        height=72
      fi
    fi
    printf -- "%d" "$height"
  fi
}
_consoleRows() {
  ! false || consoleRows --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Converts backticks, bold and italic to console colors.
#
# Usage: simpleMarkdownToConsole < $markdownFile
#
simpleMarkdownToConsole() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  # shellcheck disable=SC2119
  _toggleCharacterToColor '`' "$(decorate code --)" | _toggleCharacterToColor '**' "$(decorate red --)" | _toggleCharacterToColor '*' "$(decorate cyan --)"
}
_simpleMarkdownToConsole() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: r - UnsignedInteger. Required.
# Argument: g - UnsignedInteger. Required.
# Argument: b - UnsignedInteger. Required.
__colorBrightness() {
  local handler="$1" r g b
  r=$(usageArgumentUnsignedInteger "$handler" "red" "$2") || return $?
  g=$(usageArgumentUnsignedInteger "$handler" "green" "$3") || return $?
  b=$(usageArgumentUnsignedInteger "$handler" "blue" "$4") || return $?
  printf "%d\n" $(((r * 299 + g * 587 + b * 114) / 2550))
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
  local handler="_${FUNCNAME[0]}"
  local r g b

  if [ $# -eq 0 ]; then
    local done=false color colors=()
    # 0.299 R + 0.587 G + 0.114 B
    while ! $done; do
      read -r color || done=true
      colors+=("$color")
      if [ ${#colors[@]} -eq 3 ]; then
        __colorBrightness "$handler" "${colors[@]}" || return $?
        colors=()
      fi
    done
  elif [ $# -lt 3 ]; then
    [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
    throwArgument "$handler" "Requires 3 arguments" || return $?
  fi
  while [ $# -ge 3 ]; do
    __colorBrightness "$handler" "$1" "$2" "$3" || return $?
    shift 3
  done
}
_colorBrightness() {
  # __IDENTICAL__ usageDocument 1
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
# Requires: bc catchEnvironment read usageArgumentUnsignedInteger packageWhich __colorNormalize
colorNormalize() {
  local handler="_${FUNCNAME[0]}"

  catchReturn "$handler" packageWhich bc bc || return $?
  local red green blue
  if [ $# -eq 0 ]; then
    local done=false
    while ! $done; do
      IFS=$'\n' read -d'' -r red green blue || done=true
      red=$(usageArgumentUnsignedInteger "$handler" "redValue" "$red") || return $?
      green=$(usageArgumentUnsignedInteger "$handler" "greenValue" "$green") || return $?
      blue=$(usageArgumentUnsignedInteger "$handler" "blueValue" "$blue") || return $?
      __colorNormalize "$red" "$green" "$blue"
    done
  else
    while [ $# -gt 0 ]; do
      [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
      red=$(usageArgumentUnsignedInteger "$handler" "redValue" "${1-}") && shift || return $?
      green=$(usageArgumentUnsignedInteger "$handler" "greenValue" "${1-}") && shift || return $?
      blue=$(usageArgumentUnsignedInteger "$handler" "blueValue" "${1-}") && shift || return $?
      __colorNormalize "$red" "$green" "$blue"
    done
  fi
}
_colorNormalize() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Clamp digits between two integers
# Reads stdin digits, one per line, and outputs only integer values between $min and $max
# Argument: minimum - Integer|Empty. Minimum integer value to output.
# Argument: maximum - Integer|Empty. Maximum integer value to output.
clampDigits() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

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
_clampDigits() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  [[:xdigit:]]*) __colorParse "$argument" || return $? ;;
  [[:alpha:]]*:[[:xdigit:]]*) __colorParse "${argument#*:}" || return $? ;;
  *) printf -- "%s\n" "invalid-color" 1>&2 || : && return 1 ;;
  esac
}

_colorRange() {
  local c="$1"
  isUnsignedInteger "$c" || return 1
  [ "$c" -le 255 ] || c=255
  printf "%d" "$c"
}

# Take r g b decimal values and convert them to hex color values
# stdin: list:UnsignedInteger
# Argument: format - String. Optional. Formatting string.
# Argument: red - UnsignedInteger. Optional. Red component.
# Argument: green - UnsignedInteger. Optional. Blue component.
# Argument: blue - UnsignedInteger. Optional. Green component.
# Takes arguments or stdin values in groups of 3.
colorFormat() {
  local handler="_${FUNCNAME[0]}" format="%0.2X%0.2X%0.2X\n"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if [ $# -gt 0 ]; then format="${1:-"$format"}" && shift; fi
  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      local r="${1-}" g="${2-}" b="${3-}"
      shift 3 2>/dev/null || throwArgument "$handler" "Arguments must be in threes after format" || return $?

      r=$(_colorRange "$r") || throwArgument "$handler" "Invalid r $r value" || return $?
      g=$(_colorRange "$g") || throwArgument "$handler" "Invalid g $g value" || return $?
      b=$(_colorRange "$b") || throwArgument "$handler" "Invalid b $b value" || return $?

      # shellcheck disable=SC2059
      printf -- "$format" "$r" "$g" "$b"
    done
  else
    local done=false
    while ! $done; do
      IFS=$'\n' read -d "" -r r g b || done=true
      if r=$(_colorRange "$r") && g=$(_colorRange "$g") && b=$(_colorRange "$b"); then
        # shellcheck disable=SC2059
        printf -- "$format" "$r" "$g" "$b"
      fi
    done
  fi
}
_colorFormat() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Parse a color and output R G B decimal values
# stdin: list:colors
# Argument: color - String. Optional. Color to parse.
# Takes arguments or stdin.
colorParse() {
  if [ $# -gt 0 ]; then
    [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
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
  ! false || colorParse --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Multiply color values by a factor and return the new values
# Argument: factor - floatValue. Required. Red RGB value (0-255)
# Argument: redValue - Integer. Required. Red RGB value (0-255)
# Argument: greenValue - Integer. Required. Red RGB value (0-255)
# Argument: blueValue - Integer. Required. Red RGB value (0-255)
# Requires: bc
colorMultiply() {
  local handler="_${FUNCNAME[0]}"
  local factor colors=()

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" packageWhich bc bc || return $?
  factor=$(usageArgumentString "$handler" "factor" "${1-}") && shift || return $?

  local red green blue
  if [ $# -gt 0 ]; then
    colors=("$@")
  else
    local color && while read -r color; do colors+=("$color"); done
  fi

  set -- "${colors[@]+"${colors[@]}"}"
  while [ $# -gt 0 ]; do
    local red green blue
    red=$(usageArgumentUnsignedInteger "$handler" "redValue" "${1-}") && shift || return $?
    green=$(usageArgumentUnsignedInteger "$handler" "greenValue" "${1-}") && shift || return $?
    blue=$(usageArgumentUnsignedInteger "$handler" "blueValue" "${1-}") && shift || return $?
    bc <<<"m=$factor;$red*m;$green*m;$blue*m" | cut -d . -f 1
  done
}
_colorMultiply() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Internal
#
# Utility function to help with simpleMarkdownToConsole
# Usage: toggleCharacterToColor character colorOn [ colorOff ]
# Argument: character - The character to map to color start/stop
# Argument: colorOn - Color on escape sequence
# Argument: colorOff - Color off escape sequence defaults to "$(decorate reset --)"
#
_toggleCharacterToColor() {
  local sequence line code reset lastItem lastLine=

  # TODO is quoteSedPattern correct for BASH // replacement?
  sequence="$(quoteSedPattern "$1")"
  code="$2"
  reset="${3-$(decorate reset --)}"
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

# Set the terminal color scheme to the specification
# stdin: Scheme definition with `colorName=colorValue` on each line
colorScheme() {
  local handler="_${FUNCNAME[0]}"
  local colorsFile debug=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --debug) debug=true ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  export __BUILD_TERM_COLORS BUILD_COLORS_MODE

  colorsFile=$(fileTemporaryName "$handler") || return 0
  catchEnvironment "$handler" grepSafe -v -e '^#' | catchEnvironment "$handler" sed '/^$/d' | catchEnvironment "$handler" muzzle tee "$colorsFile" || return $?
  local hash
  hash="$(shaPipe <"$colorsFile")" || :

  [ "$hash" != "${__BUILD_TERM_COLORS-}" ] || return 0

  local it2=false iTerm2=false
  ! isiTerm2 || it2=true
  local bg bgs=()
  local name value newStyle
  while IFS="=" read -r name value; do
    local colorCode
    if $it2 && iTerm2IsColorType "$name"; then
      iTerm2=true
    fi
    if muzzle decorateStyle "$name"; then
      ! $debug || statusMessage decorate info "Parsing $(decorate code "$name") and $(decorate value "$value")"
      colorCode=$(colorParse <<<"$value" | colorFormat "%d;%d;%d")
      newStyle="38;2;$colorCode"
      ! $debug || statusMessage decorate info "Setting style $(decorate value "$name") to $(decorate code "$newStyle")"
      catchEnvironment "$handler" muzzle decorateStyle "$name" "$newStyle" || return $?
    else
      local bgName="${name%bg}"
      if [ -n "$bgName" ] && [ "$name" != "$bgName" ] && muzzle decorateStyle "$bgName"; then
        colorCode=$(colorParse <<<"$value" | colorFormat "%d;%d;%d")
        bgs+=("$bgName" "$colorCode")
        ! $debug || statusMessage decorate info "Parsing background color for $(decorate code "$bgName"): $(decorate value "$value") -> $(decorate code "$colorCode")"
      fi
    fi
  done <"$colorsFile"
  if [ ${#bgs[@]} -gt 0 ]; then
    set -- "${bgs[@]}"
    while [ $# -gt 1 ]; do
      name="$1"
      value="$2"
      newStyle=$(decorateStyle "$name")
      newStyle="${newStyle%%;48;2;*}"
      newStyle="$newStyle;48;2;$value"
      catchEnvironment "$handler" muzzle decorateStyle "$name" "$newStyle" || return $?
      ! $debug || statusMessage decorate info "Setting background style $(decorate value "$name") \"$(decorate code "$value")\" to $(decorate code "$newStyle")"
      shift 2
    done
  fi

  ! $debug || dd+=(--verbose)
  ! $iTerm2 || iTerm2SetColors "${dd[@]+"${dd[@]}"}" --fill --ignore --skip-errors <"$colorsFile" || :

  bg="$(grep -e '^bg=' "$colorsFile" | tail -n 1 | cut -f 2 -d =)"
  catchEnvironment "$handler" rm -rf "$colorsFile" || return $?

  __BUILD_TERM_COLORS="$hash"

  local mode
  mode=$(catchReturn "$handler" consoleConfigureColorMode "$bg") || :
  [ -z "$mode" ] || BUILD_COLORS_MODE="$mode" && bashPrompt --skip-prompt --colors "$(bashPromptColorScheme "$mode")"

  ! $debug || decorate info "Background is now $bg and mode is $mode ... "
}
_colorScheme() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
