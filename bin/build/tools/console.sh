#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends: usage.sh
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
  local usage="_${FUNCNAME[0]}"
  local argument
  local xtermCode sttyOld color colors success result noTTY
  local timingTweak

  success=false

  timingTweak=0.1
  noTTY=false
  xtermCode="11"
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --background)
      xtermCode="11"
      ;;
    --foreground)
      xtermCode="10"
      ;;
    *)
      __throwArgument "$usage" "unknown argument: $(decorate value "$argument")" || return $?
      ;;
    esac
    shift || __throwArgument "$usage" "shift argument $(decorate label "$argument")" || return $?
  done
  colors=()
  if ! sttyOld=$(stty -g 2>/dev/null); then
    noTTY=true
    printf -- "\e]%d;?\e\\" "${xtermCode}" || :
    sleep "$timingTweak" || :
    read -t 2 -r result
    exitCode=$?
  else
    __catchEnvironment "$usage" stty raw -echo min 0 time 0 || return $?
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
    __throwEnvironment "$usage" "stty reset to \"$sttyOld\" failed" || return $?
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
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} [ --background | --foreground ]
# Argument: --foreground - Optional. Flag. Get the console text color.
# Argument: --background - Optional. Flag. Get the console background color.
# Fetch the brightness of the console using `consoleGetColor`
# See: consoleGetColor
# Output: Integer. between 0 and 100.
# Exit Code: 0 - Success
# Exit Code: 1 - A problem occurred with `consoleGetColor`
consoleBrightness() {
  if ! colorBrightness < <(consoleGetColor "$@") 2>/dev/null; then
    return 1
  fi
}

#
# Usage: {fn}
# Argument: backgroundColor - Optional. String. Background color.
# Print the suggested color mode for the current environment
#
consoleConfigureColorMode() {
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

# Set the title of the window for the console
consoleSetTitle() {
  local usage="_${FUNCNAME[0]}"
  [ -t 0 ] || __throwEnvironment "$usage" "stdin is not a terminal" || return $?
  printf -- "\e%s\007" "]0;$*"
}
_consoleSetTitle() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Set the title of the window for the console to "user@hostname: pwd"
# Argument: None
consoleDefaultTitle() {
  local usage="_${FUNCNAME[0]}"
  [ -t 0 ] || __throwEnvironment "$usage" "stdin is not a terminal" || return $?
  consoleSetTitle "${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}"
}
_consoleDefaultTitle() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a hyperlink to the console
# OSC 8 standard for terminals
# No way to test ability, I think. Maybe `tput`.
# Usage: {fn} link [ text ]
consoleLink() {
  local link="$1" text="${2-$1}" OSC="\e]" ST="\e\\"
  local OSC8="${OSC}8;;"
  printf -- "${OSC8}%s${ST}%s${OSC8}${ST}" "$link" "$text"
}

# Are console links (likely) supported?
# Unfortunately there's no way to test for this feature currently
consoleLinksSupported() {
  local usage="_${FUNCNAME[0]}"
  export HOSTNAME
  [ -n "${HOSTNAME-}" ] || return 1
  hasConsoleAnimation || return 1
  ! isBitBucketPipeline || return 1
  ! isiTerm2 || return 0
}
_consoleLinksSupported() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a local file link to the console
# Usage: file [ text ]
consoleFileLink() {
  export HOSTNAME HOME
  if ! consoleLinksSupported; then
    printf -- "%s\n" "$(decoratePath "$1")"
  else
    local path="$1"
    if [ "${path:0:1}" != "/" ]; then
      path="$(pwd)/$(simplifyPath "$path")"
    fi
    consoleLink "file://$HOSTNAME$path" "$(decoratePath "${2-$1}")"
  fi
}

# decorate extension for `file`
# Usage: decorate file fileName [ text ]
# Argument: fileName - Required. File path to output.
# Argument: text - Optional. Text to output linked to file.
__decorateExtensionFile() {
  consoleFileLink "$@"
}

# decorate extension for `link`
# Usage: decorate link url [ text ]
# Argument: url - Required. Link to output to the console.
# Argument: text - Optional. Text to output linked to `url`.
__decorateExtensionLink() {
  if ! consoleLinksSupported; then
    printf -- "%s\n" "$1"
  else
    consoleLink "$@"
  fi
}
