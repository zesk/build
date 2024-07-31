#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: usage.sh
# bin: printf stty
# Docs: o ./docs/_templates/tools/console.md
# Test: o ./test/tools/console-tests.sh

#
# Get the RGB color of the terminal (usually for background colors)
#
# Credit: https://www.talisman.org/~erlkonig/documents/xterm-color-queries/
# Credit: https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash
# Credit: https://www.talisman.org/~erlkonig/documents/xterm-color-queries/
#
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
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
        __failArgument "$usage" "unknown argument: $(consoleValue "$argument")" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(consoleLabel "$argument")" || return $?
  done
  colors=()
  if ! sttyOld=$(stty -g 2>/dev/null); then
    noTTY=true
    printf "\e]%d;?\e\\" "${xtermCode}" || :
    sleep "$timingTweak" || :
    read -t 2 -r result
    exitCode=$?
  else
    __usageEnvironment "$usage" stty raw -echo min 0 time 0 || return $?
    printf "\e]%d;?\e\\" "${xtermCode}" >/dev/tty || :
    sleep "$timingTweak" || :
    read -t 2 -r result </dev/tty
    exitCode=$?
  fi
  if [ $exitCode -ne 0 ]; then
    success=true
    # remove escape chars
    result="${result#*;}"
    result="${result#rgb:}"
    IFS='/' read -r -a colors < <(printf "%s\\n" "$result" | sed 's/[^a-f0-9/]//g')
  fi
  if ! "$noTTY" && ! stty "$sttyOld"; then
    __failEnvironment "$usage" "stty reset to \"$sttyOld\" failed" || return $?
  fi
  if $success; then
    for color in "${colors[@]+${colors[@]}}"; do
      case "$color" in
        [0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F])
          printf "%d " $(((0x$color + 0) / 256))
          ;;
      esac
    done
    printf "\n"
  fi

}
_consoleGetColor() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Credit: https://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/POYNTON1/ColorFAQ.html#RTFToC11
# Return an integer between 0 and 100
# Colors are between 0 and 255
# Usage: {fn}
# shellcheck disable=SC2120
colorBrightness() {
  local usage="_${FUNCNAME[0]}"
  local r g b

  if [ $# -eq 0 ]; then
    # 0.299 R + 0.587 G + 0.114 B
    read -r r g b || :
  elif [ $# -eq 3 ]; then
    r=$1 g=$2 b=$3
  else
    __failArgument "$usage" "Requires 3 arguments" || return $?
  fi
  __usageArgument "$usage" isUnsignedInteger "$r" "$g" "$b" || return $?
  printf "%d\n" $(((r * 299 + g * 587 + b * 114) / 2550))
}
_colorBrightness() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} [ --background | --foreground ]
#
consoleBrightness() {
  colorBrightness 2>/dev/null < <(consoleGetColor "$@")
}

#
# Usage: {fn}
#
# Print the suggested color mode for the current environment
#
consoleConfigureColorMode() {
  local brightness colorMode

  colorMode=light
  if brightness=$(consoleBrightness --background); then
    if [ "$brightness" -lt 50 ]; then
      colorMode=dark
    fi
  elif isBitBucketPipeline; then
    colorMode=dark
  fi
  printf "%s\n" "$colorMode"
}
