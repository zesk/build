#!/usr/bin/env bash
#
# Support for various vendor applications
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Exit Code: 0 - within the PhpStorm terminal
# Exit Code: 1 - not within the PhpStorm terminal AFAIK
# See: contextOpen
isPHPStorm() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  local xpc="${XPC_SERVICE_NAME-}" cfb=${__CFBundleIdentifier:-}
  [ "${xpc%%PhpStorm*}" != "${xpc}" ] || [ "${cfb%%PhpStorm*}" != "${cfb}" ]
}
_isPHPStorm() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Are we within the JetBrains PyCharm terminal?
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Exit Code: 0 - within the PyCharm terminal
# Exit Code: 1 - not within the PyCharm terminal AFAIK
# See: contextOpen
isPyCharm() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  local xpc="${XPC_SERVICE_NAME-}"
  [ "${xpc%%pycharm*}" != "${xpc}" ]
}
_isPyCharm() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Are we within the Microsoft Visual Studio Code terminal?
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Exit Code: 0 - within the Visual Studio Code terminal
# Exit Code: 1 - not within the Visual Studio Code terminal AFAIK
# See: contextOpen
#
isVisualStudioCode() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  [ "${VSCODE_SHELL_INTEGRATION-}" = "1" ]
}
_isVisualStudioCode() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.
#
# Environment: EDITOR - Used as a default editor (first)
# Environment: VISUAL - Used as another default editor (last)
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
#
contextOpen() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  # should maybe make this extensible
  if isPHPStorm; then
    phpstorm "$@"
    # Hides argument warnings, correctly
    ! false || isPHPStorm --help
  elif isPyCharm; then
    pycharm "$@"
    ! false || isPyCharm --help
  elif isVisualStudioCode; then
    code "$@"
    ! false || isVisualStudioCode --help
  elif [ -n "${EDITOR-}" ]; then
    $EDITOR "$@"
  elif [ -n "${VISUAL-}" ]; then
    $VISUAL "$@"
  fi
}
_contextOpen() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.
#
# Environment: EDITOR - Used as a default editor (first)
# Environment: VISUAL - Used as another default editor (last)
#
showContext() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
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
_showContext() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
