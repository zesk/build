#!/usr/bin/env bash
#
# Bash Prompt Module: TermColors
#
# Copyright &copy; 2025 Market Acumen, Inc.

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
# Requires: buildHome statusMessage buildEnvironmentGetDirectory requireDirectory cachedShaPipe decorate buildDebugEnabled iTerm2SetColors consoleConfigureColorMode
# BUILD_DEBUG: term-colors - When `bashPromptModule_TermColors` is enabled, will show colors and how they are applied
#
# Support for iTerm2 is built-in and automatic
bashPromptModule_TermColors() {
  local debug=false home start usage="_return"

  home=$(buildHome 2>/dev/null) || return 0

  ! buildDebugEnabled term-colors || debug=true

  export __BUILD_ITERM2_COLORS BUILD_COLORS_MODE

  local schemeFile
  # Deprecated files
  for schemeFile in "$home/.term-colors.conf" "$home/etc/term-colors.conf" "$home/.iterm2-colors.conf" "$home/etc/iterm2-colors.conf"; do
    ! $debug || statusMessage decorate info "Looking at $schemeFile"
    if [ -f "$schemeFile" ]; then
      local hash cacheDir
      cacheDir=$(buildEnvironmentGetDirectory XDG_CACHE_HOME --subdirectory ".TermColors") || break

      hash=$(cachedShaPipe "$cacheDir" <"$schemeFile") || :
      ! $debug || statusMessage --last decorate info "$schemeFile -> \"$hash\""
      [ -n "$hash" ] || break

      hash="$schemeFile:$hash"
      [ "$hash" != "${__BUILD_ITERM2_COLORS-}" ] || return 0

      ! $debug || statusMessage decorate info "Applying colors from $(decorate file "$schemeFile") ... "

      start=$(timingStart)
      colorsFile=$(fileTemporaryName _return) || return 0
      __catchEnvironment "$usage" grepSafe -v -e '^#' "$schemeFile" | __catchEnvironment "$usage" sed '/^$/d' | __catchEnvironment "$usage" muzzle tee "$colorsFile" || return $?
      local it2=false iTerm2=false
      ! isiTerm2 || it2=true
      while IFS="=" read -r name value; do
        if $it2 && iTerm2IsColorType "$name"; then
          iTerm2=true
        fi
        if decorateStyle "$name"; then
          decorateStyle "$name" "$value"
        fi
      done <"$colorsFile"
      ! $iTerm2 || iTerm2SetColors --fill --ignore --skip-errors <"$colorsFile" || :
      bg="$(grep -e '^bg=' "$colorsFile" | tail -n 1 | cut -f 2 -d =)"
      __catchEnvironment "$usage" rm -rf "$colorsFile" || return $?

      ! $debug || timingReport "$start"

      __BUILD_ITERM2_COLORS="$hash"

      start=$(timingStart)

      local mode
      mode=$(__environment consoleConfigureColorMode "$bg") || :
      [ -z "$mode" ] || BUILD_COLORS_MODE="$mode" && bashPrompt --colors "$(bashPromptColorScheme "$mode")"

      ! $debug || timingReport "$start" "Background is now $bg and mode is $mode ... "
      break
    else
      ! $debug || statusMessage --last decorate info "$schemeFile does not exist"
    fi
  done
}
