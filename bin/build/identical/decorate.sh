#!/usr/bin/env bash
#
# Identical template
#
# Original of _colors
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

#
# EDIT THIS FILE - EDIT THIS FILE - EDIT THIS FILE - EDIT THIS FILE
# EDIT THIS FILE - EDIT THIS FILE - EDIT THIS FILE - EDIT THIS FILE
# EDIT THIS FILE - EDIT THIS FILE - EDIT THIS FILE - EDIT THIS FILE
#

# Testing stuff
#
#
# Timing tests
#
# _catStyles
#
# real    0m2.764s
# user    0m2.394s
# sys     0m0.144s
#
# _caseStyles
#
# real    0m1.321s
# user    0m1.194s
# sys     0m0.066s
#
# Change _caseStyles "$what" -> _catStyles "$what"
# time muzzle runCount 10000 decorate decoration "This is some very long text which may change every line." | tee _catStyles.time
#
# NOT USED
#
_catStyles() {
  _styles | grep -e "^$1 "
}

_styles() {
  cat <<'EOF'
reset
underline 4
no-underline 24
bold 1
no-bold 21
black 109;7
black-contrast 107;30
blue 94
cyan 36
green 92
magenta 35
orange 33
red 31
white 48;5;0;37
yellow 48;5;16;38;5;11
bold-black 1;109;7
bold-black-contrast 1;107;30
bold-blue 1;94
bold-cyan 1;36
bold-green 92
bold-magenta 1;35
bold-orange 1;33
bold-red 1;31
bold-white 1;48;5;0;37
bold-yellow 1;48;5;16;38;5;11
code 1;97;44
info 38;5;20 1;33 Info
success 42;30 0;32 SUCCESS
warning 1;93;41 Warning
error 1;91 ERROR
subtle 1;38;5;252 1;38;5;240
label 34;103 1;96
value 1;40;97 1;97
decoration 45;97 45;30
EOF
}

# IDENTICAL decorate EOF

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
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  ! false || hasColors --help
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

# Output a list of build-in decoration styles, one per line
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
decorations() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0
  printf "%s\n" reset \
    underline no-underline bold no-bold \
    black black-contrast blue cyan green magenta orange red white yellow \
    bold-black bold-black-contrast bold-blue bold-cyan bold-green bold-magenta bold-orange bold-red bold-white bold-yellow \
    code info notice success warning error subtle label value decoration
}
_decorations() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  ! false || decorations --help
}

# Singular decoration function
# Usage: decorate style [ text ... ]
# Argument: style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow bold-black bold-black-contrast bold-blue bold-cyan bold-green bold-magenta bold-orange bold-red bold-white bold-yellow code info notice success warning error subtle label value decoration
# Argument: text - Text to output. If not supplied, outputs a code to change the style to the new style.
# stdout: Decorated text
# Requires: isFunction _argument awk __catchEnvironment usageDocument
decorate() {
  local usage="_${FUNCNAME[0]}" text="" what="${1-}" lp dp style
  shift || __catchArgument "$usage" "Requires at least one argument" || return $?
  if ! style=$(_caseStyles "$what"); then
    local extend
    extend="__decorateExtension$(printf "%s" "${what:0:1}" | awk '{print toupper($0)}')${what:1}"
    # When this next line calls `__catchArgument` it results in an infinite loop
    # shellcheck disable=SC2119
    isFunction "$extend" || _argument printf -- "%s\n%s\n" "Unknown decoration name: $what ($extend)" "$(decorations)" || return $?
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
    notice) lp='46;31' && dp='1;97;44' && text="Notice" ;;
    success) lp='42;30' && dp='0;32' && text="Success" ;;
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

# fn: decorate quote
# Double-quote all arguments as properly quoted bash string
# Mostly $ and " are problematic within a string
# Requires: printf decorate
__decorateExtensionQuote() {
  local text="$*"
  text="${text//\"/\\\"}"
  text="${text//\$/\\\$}"
  printf -- "\"%s\"\n" "$text"
}
