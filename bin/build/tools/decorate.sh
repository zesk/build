#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# NO DEPENDENCIES

# IDENTICAL decorate 150

# Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate
#
# Usage: hasColors
# Exit Code: 0 - Console or output supports colors
# Exit Code; 1 - Colors are likely not supported by console
# Environment: BUILD_COLORS - Optional. Boolean. Whether the build system will output ANSI colors.
# Requires: isPositiveInteger tput
hasColors() {
  local usage="_${FUNCNAME[0]}"
  local termColors
  export BUILD_COLORS TERM

  [ "${1-}" != "--help" ] || ! "$usage" 0 || return 0
  # Values allowed for this global are true and false
  # Important - must not use buildEnvironmentLoad BUILD_COLORS TERM; then
  BUILD_COLORS="${BUILD_COLORS-}"
  if [ -z "$BUILD_COLORS" ]; then
    BUILD_COLORS=false
    case "${TERM-}" in "" | "dumb" | "unknown") BUILD_COLORS=true ;; *)
      termColors="$(tput colors 2>/dev/null)"
      isPositiveInteger "$termColors" || termColors=2
      [ "$termColors" -lt 8 ] || BUILD_COLORS=true
      ;;
    esac
  elif [ "$BUILD_COLORS" = "1" ]; then
    # Backwards
    BUILD_COLORS=true
  elif [ -n "$BUILD_COLORS" ] && [ "$BUILD_COLORS" != "true" ]; then
    BUILD_COLORS=false
  fi
  [ "${BUILD_COLORS-}" = "true" ]
}
_hasColors() {
  ! false || hasColors --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Semantics-based
#
# Usage: {fn} label lightStartCode darkStartCode endCode [ -n ] [ message ]
# Requires: hasColors printf
__decorate() {
  local prefix="$1" start="$2" dp="$3" end="$4" && shift 4
  export BUILD_COLORS_MODE BUILD_COLORS
  if [ -n "${BUILD_COLORS-}" ] && [ "${BUILD_COLORS-}" = "true" ] || [ -z "${BUILD_COLORS-}" ] && hasColors; then
    if [ "${BUILD_COLORS_MODE-}" = "dark" ]; then
      start="$dp"
    fi
    if [ $# -eq 0 ]; then printf -- "%s$start" ""; else printf -- "$start%s$end\n" "$*"; fi
    return 0
  fi
  [ $# -gt 0 ] || return 0
  if [ -n "$prefix" ]; then printf -- "%s: %s\n" "$prefix" "$*"; else printf -- "%s\n" "$*"; fi
}

# Singular decoration function
# Usage: decorate style [ text ... ]
# Argument: style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow bold-black bold-black-contrast bold-blue bold-cyan bold-green bold-magenta bold-orange bold-red bold-white bold-yellow code info notice success warning error subtle label value decoration
# Argument: text - Text to output. If not supplied, outputs a code to change the style to the new style.
# stdout: Decorated text
# Depends: isFunction _argument awk __catchEnvironment usageDocument
decorate() {
  local usage="_${FUNCNAME[0]}" text="" what="${1-}" && shift
  local lp dp style
  if ! style=$(_caseStyles "$what"); then
    local extend
    extend="__decorateExtension$(printf "%s" "${what:0:1}" | awk '{print toupper($0)}')${what:1}"
    # When this next line calls `__catchArgument` it results in an infinite loop
    isFunction "$extend" || _argument "Unknown decoration name: $what ($extend)" || return $?
    __catchEnvironment "$usage" "$extend" "$@" || return $?
    return $?
  fi
  read -r lp dp text <<<"$style" || :
  local p='\033['
  __decorate "$text" "${p}${lp}m" "${p}${dp:-$lp}m" "${p}0m" "$@"
}
_decorate() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Enables timing
# Usage: {fn} style
# Exit Code: 1 - not found
# Exit Code: 0 - found
# stdout: 1, 2, or 3 tokens + newline: lightColor darkColor text
# Requires: printf
_caseStyles() {
  case "$1" in
    reset) lp='0' ;;
      # styles
    underline) lp='4' ;;
    no-underline) lp='24' ;;
    bold) lp='1' ;;
    no-bold) lp='21' ;;
      # colors
    black) lp='109;7' ;;
    black-contrast) lp='107;30' ;;
    blue) lp='94' ;;
    cyan) lp='36' ;;
    green) lp='92' ;;
    magenta) lp='35' ;;
    orange) lp='33' ;;
    red) lp='31' ;;
    white) lp='48;5;0;37' ;;
    yellow) lp='48;5;16;38;5;11' ;;
      # bold-colors
    bold-black) lp='1;109;7' ;;
    bold-black-contrast) lp='1;107;30' ;;
    bold-blue) lp='1;94' ;;
    bold-cyan) lp='1;36' ;;
    bold-green) lp='92' ;;
    bold-magenta) lp='1;35' ;;
    bold-orange) lp='1;33' ;;
    bold-red) lp='1;31' ;;
    bold-white) lp='1;48;5;0;37' ;;
    bold-yellow) lp='1;48;5;16;38;5;11' ;;
      # semantic-colors
    code) lp='1;97;44' ;;
    info) lp='38;5;20' && dp='1;33' && text="Info" ;;
    notice) lp='46;30' && dp='1;97;44' && text="Notice" ;;
    success) lp='42;30' && dp='0;32' && text="SUCCESS" ;;
    warning) lp='1;93;41' && text="Warning" ;;
    error) lp='1;91' && text="ERROR" ;;
    subtle) lp='1;38;5;252' && dp='1;38;5;240' ;;
    label) lp='34;103' && dp='1;96' ;;
    value) lp='1;40;97' && dp='1;97' ;;
    decoration) lp='45;97' && dp='45;30' ;;
    *)
      return 1
      ;;
  esac
  printf "%s %s %s\n" "$lp" "${dp:-$lp}" "$text"
}

# Usage: decorate each decoration argument1 argument2 ...
# Runs the following command on each subsequent argument to allow for formatting with spaces
# Requires: decorate printf
__decorateExtensionEach() {
  local code="$1" formatted=()

  shift || return 0
  while [ $# -gt 0 ]; do
    formatted+=("$(decorate "$code" "$1")")
    shift
  done
  IFS=" " printf -- "%s\n" "${formatted[*]-}"
}
