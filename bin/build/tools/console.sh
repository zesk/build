#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends: handler.sh
# bin: printf stty
# Docs: o ./documentation/source/tools/console.md
# Test: o ./test/tools/console-tests.sh

# Summary: Get the console foreground or background color
# Gets the RGB console color using an `xterm` escape sequence supported by some terminals. (usually for background colors)
#
# Credit: https://www.talisman.org/~erlkonig/documents/xterm-color-queries/
# Credit: https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash
#
# Argument: --foreground - Optional. Flag. Get the console text color.
# Argument: --background - Optional. Flag. Get the console background color.
consoleGetColor() {
  local handler="_${FUNCNAME[0]}"
  local argument
  local xtermCode sttyOld color colors success result noTTY
  local timingTweak

  success=false

  timingTweak=0.1
  noTTY=false
  xtermCode="11"
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --background)
      xtermCode="11"
      ;;
    --foreground)
      xtermCode="10"
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  colors=()
  if ! sttyOld=$(stty -g 2>/dev/null); then
    noTTY=true
    printf -- "\e]%d;?\e\\" "${xtermCode}" || :
    sleep "$timingTweak" || :
    read -t 2 -r result
    exitCode=$?
  else
    catchEnvironment "$handler" stty raw -echo min 0 time 0 || return $?
    printf -- "\e]%d;?\e\\" "${xtermCode}" >/dev/tty || :
    sleep "$timingTweak" || :
    read -t 2 -r result </dev/tty
    exitCode=$?
  fi
  if [ $exitCode -ne 0 ]; then
    success=true
    # remove escape chars
    result="${result#*;}"
    result="${result#rgb:}"
    IFS='/' read -r -a colors < <(printf -- "%s\\n" "$result" | sed 's/[^a-f0-9/]//g') || :
  fi
  if ! "$noTTY" && ! stty "$sttyOld"; then
    throwEnvironment "$handler" "stty reset to \"$sttyOld\" failed" || return $?
  fi
  if $success; then
    for color in "${colors[@]+${colors[@]}}"; do
      case "$color" in
      [0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F])
        printf -- "%d\n" $(((0x$color + 0) / 256))
        ;;
      esac
    done
  fi

}
_consoleGetColor() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# handler: {fn} [ --background | --foreground ]
# Argument: --foreground - Optional. Flag. Get the console text color.
# Argument: --background - Optional. Flag. Get the console background color.
# Fetch the brightness of the console using `consoleGetColor`
# See: consoleGetColor
# Output: Integer. between 0 and 100.
# Return Code: 0 - Success
# Return Code: 1 - A problem occurred with `consoleGetColor`
consoleBrightness() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  if ! colorBrightness < <(consoleGetColor "$@") 2>/dev/null; then
    return 1
  fi
}
_consoleBrightness() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# handler: {fn}
# Argument: backgroundColor - Optional. String. Background color.
# Print the suggested color mode for the current environment
#
consoleConfigureColorMode() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local colorMode="light" color="${1-}" brightness
  if [ -n "$color" ]; then
    brightness=$(colorParse <<<"$color" | colorBrightness)
  else
    brightness=$(consoleBrightness --background)
  fi
  if isInteger "$brightness"; then
    if [ "$brightness" -lt 50 ]; then
      colorMode=dark
    fi
  elif isBitBucketPipeline; then
    colorMode=dark
  fi
  printf -- "%s\n" "$colorMode"
}
_consoleConfigureColorMode() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Set the title of the window for the console
consoleSetTitle() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  printf -- "\e%s\007" "]0;$*"
}
_consoleSetTitle() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Set the title of the window for the console to "user@hostname: pwd"
# Argument: None
consoleDefaultTitle() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ -t 0 ] || throwEnvironment "$handler" "stdin is not a terminal" || return $?
  consoleSetTitle "${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}"
}
_consoleDefaultTitle() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a hyperlink to the console
# OSC 8 standard for terminals
# No way to test ability, I think. Maybe `tput`.
# handler: {fn} link [ text ]
consoleLink() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local link="$1" text="${2-$1}" OSC="\e]" ST="\e\\"
  local OSC8="${OSC}8;;"
  printf -- "${OSC8}%s${ST}%s${OSC8}${ST}" "$link" "$text"
}
_consoleLink() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Are console links (likely) supported?
# Unfortunately there's no way to test for this feature currently
consoleLinksSupported() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  export HOSTNAME
  [ -n "${HOSTNAME-}" ] || return 1
  hasConsoleAnimation || return 1
  ! isBitBucketPipeline || return 1
  ! isiTerm2 || return 0
}
_consoleLinksSupported() {
  ! false || consoleLinksSupported --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a local file link to the console
# Argument: --no-app - Flag. Optional. Do not map the application path in `decoratePath`
# Argument: fileName - Required. File path to output.
# Argument: text - Optional. Text to output linked to file.
consoleFileLink() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  export HOSTNAME HOME
  if ! consoleLinksSupported; then
    printf -- "%s\n" "$(decoratePath "$@")"
  else
    local aa=()
    while [ $# -gt 0 ]; do
      case "$1" in
      --no-app) aa=("$1") ;;
      *)
        local path="$1"
        isPlain "$path" || throwArgument "$handler" "Path contains non-plain characters: $(dumpBinary <<<"$path")" || return $?
        if [ "${path:0:1}" != "/" ]; then
          path="$(pwd)/$(directoryPathSimplify "$path")"
        fi
        local value="$path"
        if [ $# -gt 1 ]; then
          shift
          value="$1"
        fi
        consoleLink "file://$HOSTNAME$path" "$(decoratePath "${aa[@]+"${aa[@]}"}" "$value")"
        ;;
      esac
      shift
    done
  fi
}
_consoleFileLink() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# decorate extension for `file`
# handler: decorate file fileName [ text ]
# Argument: --no-app - Flag. Optional. Do not map the application path in `decoratePath`
# Argument: fileName - Required. File path to output.
# Argument: text - Optional. Text to output linked to file.
# See: decoratePath
# Environment: BUILD_HOME TMPDIR HOME
__decorateExtensionFile() {
  consoleFileLink "$@"
}

# decorate extension for `link`
# handler: decorate link url [ text ]
# Argument: url - Required. Link to output to the console.
# Argument: text - Optional. Text to output linked to `url`.
__decorateExtensionLink() {
  if ! consoleLinksSupported; then
    printf -- "%s\n" "$1"
  else
    consoleLink "$@"
  fi
}
