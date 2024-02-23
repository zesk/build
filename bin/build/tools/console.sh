#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: usage.sh
# bin: printf stty
# Docs: o ./docs/_templates/tools/console.md
# Test: o ./test/tools/colors-tests.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

#
# Get the RGB color of the terminal (usually for background colors)
#
# Credit: https://www.talisman.org/~erlkonig/documents/xterm-color-queries/
# Credit: https://stackoverflow.com/questions/16914418/how-to-manipulate-hexadecimal-value-in-bash
# Credit: https://www.talisman.org/~erlkonig/documents/xterm-color-queries/
#
consoleGetColor() {
  local xtermCode sttyOld color colors success result noTTY

  success=false

  noTTY=false
  xtermCode="11"
  while [ $# -gt 0 ]; do
    case "$1" in
      --background)
        xtermCode="11"
        ;;
      --foreground)
        xtermCode="10"
        ;;
      *)
        _consoleGetColor "$errorArgument" "Unknown argument $1" || return $?
        ;;
    esac
    shift || _consoleGetColor "$errorArgument" "Shift failed" || return $?
  done
  if ! sttyOld=$(stty -g 2>/dev/null); then
    noTTY=true
  else
    if ! stty raw -echo min 0 time 0; then
      _consoleGetColor "$errorEnvironment" "stty raw failed" || return $?
    fi
  fi

  if ! printf "\e]%d;?\e\\" "${xtermCode}"; then
    _consoleGetColor "$errorEnvironment" "tty message failed" || return $?
  fi
  # term needs the sleep (or "time 1", but that is 1/10th second).
  sleep 0.0001 || :
  colors=()
  if ! read -t 2 -r result; then
    success=true
    # remove escape chars
    result="${result#*;}"
    result="${result#rgb:}"
    IFS='/' read -r -a colors < <(printf "%s\\n" "$result" | sed 's/[^a-f0-9/]//g')
  fi
  if ! "$noTTY" && ! stty "$sttyOld"; then
    _consoleGetColor "$errorEnvironment" "stty reset to \"$sttyOld\" failed" || return $?
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
colorBrightness() {
  local r g b
  # 0.299 R + 0.587 G + 0.114 B
  read -r r g b || :
  if ! isUnsignedInteger "$r" "$g" "$b"; then
    printf "%d\n" $(((r * 299 + g * 587 + b * 114) / 2550))
  else
    consoleError "Not integers: \"$r\" \"$g\" \"$b\"" 1>&2
    return $errorArgument
  fi
}

#
# Usage: {fn}
#
# Print the suggested color mode for the current environment
#
consoleConfigureColorMode() {
  local brightness colorMode

  colorMode=light
  if brightness=$(colorBrightness 2>/dev/null < <(consoleGetColor --background)); then
    if [ "$brightness" -lt 50 ]; then
      colorMode=dark
    fi
  elif isBitBucketPipeline; then
    colorMode=dark
  fi
  printf "%s\n" "$colorMode"
}
