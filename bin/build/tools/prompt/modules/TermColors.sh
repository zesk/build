#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Sets the console colors based on the project you are currently in.
# Define your color configuration file (values of `bg=FFF` etc. one per line, comments allowed)
#
# Will fill in missing bright or non-bright colors which are unspecified. (`blue` implies `br_blue` and so on)
#
# Sets `BUILD_COLORS_MODE` based on background color
# Sets `decorateStyle` for valid styles
#
# See: consoleConfigureColorMode
# File: ./etc/iterm2-colors.conf
# File: ./etc/term-colors.conf
# File: ./.term-colors.conf
#
# Example:     bashPrompt --order 80 bashPromptModule_TermColors
# Requires: buildHome statusMessage buildEnvironmentGetDirectory directoryRequire cachedShaPipe decorate buildDebugEnabled iTerm2SetColors consoleConfigureColorMode
# BUILD_DEBUG: term-colors - When `bashPromptModule_TermColors` is enabled, will show colors and how they are applied
#
# Support for iTerm2 is built-in and automatic
bashPromptModule_TermColors() {
  local handler="returnMessage"
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

  local home
  home=$(catchReturn "$handler" buildHome 2>/dev/null) || return 0

  local debug=false
  ! buildDebugEnabled term-colors || debug=true

  local schemeFile dd=()
  ! $debug || dd+=("--debug")

  # Deprecated files
  for schemeFile in "$home/.term-colors.conf" "$home/etc/term-colors.conf" "$home/.iterm2-colors.conf" "$home/etc/iterm2-colors.conf"; do
    local prettySchemeFile
    prettySchemeFile="$(decorate file "$schemeFile")"
    ! $debug || statusMessage decorate info "Looking at $prettySchemeFile"
    if [ ! -f "$schemeFile" ]; then
      ! $debug || statusMessage --last decorate info "$prettySchemeFile does not exist"
      continue
    fi

    ! $debug || statusMessage decorate info "Applying colors from $prettySchemeFile ... "
    if catchReturn "$handler" colorScheme "${dd[@]+"${dd[@]}"}" <"$schemeFile" || return $?; then
      break
    fi
  done
}
_bashPromptModule_TermColors() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
