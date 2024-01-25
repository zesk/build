#!/usr/bin/env bash
#
# Support for various vendor applications
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: nothing
# Docs: o ./docs/_templates/tools/vendor.md
# Test: o ./docs/_templates/tools/vendor.md

export XPC_SERVICE_NAME
export VSCODE_SHELL_INTEGRATION
export __CFBundleIdentifier
#
# Are we within the JetBrains PHPStorm terminal?
#
# Usage: isPHPStorm
# Exit Code: 0 - within the PhpStorm terminal
# Exit Code: 1 - not within the PhpStorm terminal AFAIK
# See: contextOpen
isPHPStorm() {
  local xpc="${XPC_SERVICE_NAME-}" cfb=${__CFBundleIdentifier:-}
  [ "${xpc%%PhpStorm*}" != "${xpc}" ] || [ "${cfb%%PhpStorm*}" != "${cfb}" ]
}

#
# Are we within the JetBrains PyCharm terminal?
#
# Usage: isPyCharm
# Exit Code: 0 - within the PyCharm terminal
# Exit Code: 1 - not within the PyCharm terminal AFAIK
# See: contextOpen
isPyCharm() {
  local xpc="${XPC_SERVICE_NAME-}"
  [ "${xpc%%pycharm*}" != "${xpc}" ]
}

#
# Are we within the Microsoft Visual Studio Code terminal?
#
# Usage: isVisualStudioCode
# Exit Code: 0 - within the Visual Studio Code terminal
# Exit Code: 1 - not within the Visual Studio Code terminal AFAIK
# See: contextOpen
#
isVisualStudioCode() {
  [ "${VSCODE_SHELL_INTEGRATION-}" = "1" ]
}

#
# Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.
#
# Environment: EDITOR - Used as a default editor (first)
# Environment: VISUAL - Used as another default editor (last)
#
contextOpen() {
  # should maybe make this extensible
  if isPHPStorm; then
    phpstorm "$@"
  elif isPyCharm; then
    pycharm "$@"
  elif isVisualStudioCode; then
    code "$@"
  elif [ -n "${EDITOR-}" ]; then
    $EDITOR "$@"
  elif [ -n "${VISUAL-}" ]; then
    $VISUAL "$@"
  fi
}

#
# Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.
#
# Environment: EDITOR - Used as a default editor (first)
# Environment: VISUAL - Used as another default editor (last)
#
showContext() {
  # should maybe make this extensible
  if isPHPStorm; then
    printf "%s\n" phpstorm
  elif isPyCharm; then
    printf "%s\n" charm
  elif isVisualStudioCode; then
    printf "%s\n" code
  elif [ -n "${EDITOR-}" ]; then
    printf "EDITOR=%s \$EDITOR\n" "$EDITOR"
  elif [ -n "${VISUAL-}" ]; then
    printf "VISUAL=%s \$VISUAL\n" "$VISUAL"
  else
    return 1
  fi
}
