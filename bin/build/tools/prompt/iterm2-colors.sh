#!/usr/bin/env bash
#
# Bash Prompt Module: iTerm2Colors
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Sets the console colors based on the project you are currently in.
# Place an iterm2 colors configuration file (values of `bg=FFF` etc. one per line, comments allowed)
#
# Will fill in missing bright or non-bright colors which are unspecified. (`blue` implies `br_blue` and so on)
#
# Sets `BUILD_COLORS_MODE` based on background color
# See: consoleConfigureColorMode
# File: ./etc/iterm2-colors.conf
# File: ./.iterm2-colors.conf
#
# Example:     bashPrompt --order 8 bashPromptModule_iTerm2Colors
# Requires: buildHome statusMessage buildEnvironmentGetDirectory requireDirectory cachedShaPipe decorate buildDebugEnabled iTerm2SetColors consoleConfigureColorMode
# BUILD_DEBUG: iterm2-colors - When `bashPromptModule_iTerm2Colors` is enabled, will show colors and how they are applied
bashPromptModule_iTerm2Colors() {
  local debug=false home

  home=$(buildHome 2>/dev/null) || return 0

  ! buildDebugEnabled iterm2-colors || debug=true

  export __BUILD_ITERM2_COLORS BUILD_COLORS_MODE

  local schemeFile
  for schemeFile in "$home/.iterm2-colors.conf" "$home/etc/iterm2-colors.conf"; do
    ! $debug || statusMessage decorate info "Looking at $schemeFile"
    if [ -f "$schemeFile" ]; then
      local hash cacheDir
      # cacheDir=$(buildEnvironmentGetDirectory --subdirectory ".iTerm2Colors" XDG_CACHE_HOME) || break
      cacheDir=$(buildEnvironmentGetDirectory XDG_CACHE_HOME) || break
      cacheDir=$(requireDirectory "$cacheDir/.iTerm2Colors") || break

      hash=$(cachedShaPipe "$cacheDir" <"$schemeFile") || :
      ! $debug || statusMessage --last decorate info "$schemeFile -> \"$hash\""
      [ -n "$hash" ] || break

      hash="$schemeFile:$hash"
      [ "$hash" != "${__BUILD_ITERM2_COLORS-}" ] || return 0

      ! $debug || decorate info "Applying colors from $(decorate file "$schemeFile")"

      saveBackground=$(fileTemporaryName _return) || return 0
      iTerm2SetColors --fill --ignore --skip-errors < <(grep -v -e '^#' "$schemeFile" | sed '/^$/d' | tee "$saveBackground") || :
      bg="$(grep -e '^bg=' "$saveBackground" | tail -n 1 | cut -f 2 -d =)"
      rm -rf "$saveBackground"

      __BUILD_ITERM2_COLORS="$hash"

      local mode
      mode=$(__environment consoleConfigureColorMode "$bg") || :
      [ -z "$mode" ] || BUILD_COLORS_MODE="$mode" && bashPrompt --colors "$(bashPromptColorScheme "$mode")"

      ! $debug || decorate info "Background is now $bg and mode is $mode"
      break
    else
      ! $debug || statusMessage --last decorate info "$schemeFile does not exist"
    fi
  done
}
