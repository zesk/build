#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

  local home start
  start=$(timingStart)
  home=$(buildHome 2>/dev/null) || return 0

  local debug=false
  ! buildDebugEnabled term-colors || debug=true

  local schemeFile
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
    if __bashPromptModule_LoadColors "$schemeFile" "$start" "$debug" "$prettySchemeFile"; then
      break
    fi
  done
}
_bashPromptModule_TermColors() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__bashPromptModule_LoadColors() {
  local schemeFile="$1" start="$2" debug="$3" prettySchemeFile="$4" usage="_return" dd=()

  export __BUILD_TERM_COLORS BUILD_COLORS_MODE

  local cacheDir hash
  cacheDir=$(buildEnvironmentGetDirectory XDG_CACHE_HOME --subdirectory ".TermColors") || return 0

  hash=$(cachedShaPipe "$cacheDir" <"$schemeFile") || :
  ! $debug || statusMessage --last decorate info "$schemeFile -> \"$hash\" $(decorate code __BUILD_TERM_COLORS) $(timingReport "$start")"
  [ -n "$hash" ] || return 0

  hash="$schemeFile:$hash"
  [ "$hash" != "${__BUILD_TERM_COLORS-}" ] || return 0

  colorsFile=$(fileTemporaryName _return) || return 0
  __catchEnvironment "$usage" grepSafe -v -e '^#' "$schemeFile" | __catchEnvironment "$usage" sed '/^$/d' | __catchEnvironment "$usage" muzzle tee "$colorsFile" || return $?
  local it2=false iTerm2=false
  ! isiTerm2 || it2=true
  local bgs=()
  while IFS="=" read -r name value; do
    local colorCode newStyle
    if $it2 && iTerm2IsColorType "$name"; then
      iTerm2=true
    fi
    if muzzle decorateStyle "$name"; then
      ! $debug || statusMessage decorate info "Parsing $(decorate code "$name") and $(decorate value "$value")"
      colorCode=$(colorParse <<<"$value" | colorFormat "%d;%d;%d")
      newStyle="38;2;$colorCode"
      ! $debug || statusMessage decorate info "Setting style $(decorate value "$name") to $(decorate code "$newStyle")"
      __catchEnvironment "$usage" muzzle decorateStyle "$name" "$newStyle" || return $?
    else
      local bgName="${name%bg}"
      if [ -n "$bgName" ] && [ "$name" != "$bgName" ] && muzzle decorateStyle "$bgName"; then
        colorCode=$(colorParse <<<"$value" | colorFormat "%d;%d;%d")
        bgs+=("$bgName" "$colorCode")
        ! $debug || statusMessage decorate info "Parsing background color for $(decorate code "$bgName"): $(decorate value "$value") -> $(decorate code "$colorCode")"
      fi
    fi
  done <"$colorsFile"
  if [ ${#bgs[@]} -gt 0 ]; then
    set -- "${bgs[@]}"
    while [ $# -gt 1 ]; do
      name="$1"
      value="$2"
      newStyle=$(decorateStyle "$name")
      newStyle="${newStyle%%;48;2;*}"
      newStyle="$newStyle;48;2;$value"
      __catchEnvironment "$usage" muzzle decorateStyle "$name" "$newStyle" || return $?
      ! $debug || statusMessage decorate info "Setting background style $(decorate value "$name") \"$(decorate code "$value")\" to $(decorate code "$newStyle")"
      shift 2
    done
  fi

  ! $debug || dd+=(--verbose)
  ! $iTerm2 || iTerm2SetColors "${dd[@]+"${dd[@]}"}" --fill --ignore --skip-errors <"$colorsFile" || :

  bg="$(grep -e '^bg=' "$colorsFile" | tail -n 1 | cut -f 2 -d =)"
  __catchEnvironment "$usage" rm -rf "$colorsFile" || return $?

  ! $debug || timingReport "$start" Elapsed

  __BUILD_TERM_COLORS="$hash"

  local mode
  mode=$(__environment consoleConfigureColorMode "$bg") || :
  [ -z "$mode" ] || BUILD_COLORS_MODE="$mode" && bashPrompt --colors "$(bashPromptColorScheme "$mode")"

  ! $debug || timingReport "$start" "Background is now $bg and mode is $mode ... "
}
