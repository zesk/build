#!/usr/bin/env bash
#
# Bash Prompt Module: iTerm2Colors
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Sets the console colors based on the project you are currently in
#
# Example:     bashPrompt bashPromptModule_iTerm2Colors
# Requires: buildHome statusMessage buildEnvironmentGetDirectory requireDirectory cachedShaPipe decorate buildDebugEnabled iTerm2SetColors consoleConfigureColorMode
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
      ! $debug || statusMessage decorate info "$schemeFile -> \"$hash\""
      [ -n "$hash" ] || break

      hash="$schemeFile:$hash"
      [ "$hash" != "${__BUILD_ITERM2_COLORS-}" ] || return 0

      if buildDebugEnabled iterm2-colors; then
        decorate info "Applying colors from $(deorate file "$schemeFile")"
      fi

      iTerm2SetColors --verbose --fill --ignore --skip-errors < <(grep -v -e '^#' "$schemeFile" | sed '/^$/d') || :
      __BUILD_ITERM2_COLORS="$hash"

      local mode
      mode=$(__environment consoleConfigureColorMode) || :
      [ -z "$mode" ] || BUILD_COLORS_MODE="$mode"
      break
    else
      ! $debug || statusMessage --last decorate info "$schemeFile does not exist"
    fi
  done
}
