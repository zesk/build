#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL decorate 240

# Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate
#
# Usage: hasColors
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Exit Code: 0 - Console or output supports colors
# Exit Code: 1 - Colors are likely not supported by console
# Environment: BUILD_COLORS - Optional. Boolean. Whether the build system will output ANSI colors.
# Requires: isPositiveInteger tput
hasColors() {
  # --help is only argument allowed
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"

  # Values allowed for this global are true and false
  # Important: DO NOT use buildEnvironmentLoad BUILD_COLORS TERM
  export BUILD_COLORS
  if [ -z "${BUILD_COLORS-}" ]; then
    BUILD_COLORS=false
    case "${TERM-}" in "" | "dumb" | "unknown") BUILD_COLORS=true ;; *)
      local termColors
      termColors="$(tput colors 2>/dev/null)"
      isPositiveInteger "$termColors" || termColors=2
      [ "$termColors" -lt 8 ] || BUILD_COLORS=true
      ;;
    esac
  elif [ "${BUILD_COLORS-}" != "true" ]; then
    BUILD_COLORS=false
  fi
  [ "${BUILD_COLORS-}" = "true" ]
}
_hasColors() {
  true || hasColors --help
  # __IDENTICAL__ usageDocument 1
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

# Output a list of build-in decoration styles, one per line
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
decorations() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf "%s\n" reset \
    underline no-underline bold no-bold \
    black black-contrast blue cyan green magenta orange red white yellow \
    bold-black bold-black-contrast bold-blue bold-cyan bold-green bold-magenta bold-orange bold-red bold-white bold-yellow \
    code info notice success warning error subtle label value decoration
}
_decorations() {
  ! false || decorations --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Singular decoration function
# Usage: decorate style [ text ... ]
# Argument: style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow bold-black bold-black-contrast bold-blue bold-cyan bold-green bold-magenta bold-orange bold-red bold-white bold-yellow code info notice success warning error subtle label value decoration
# Argument: text - Text to output. If not supplied, outputs a code to change the style to the new style.
# stdout: Decorated text
# Requires: isFunction _argument awk __catchEnvironment usageDocument __executeInputSupport __help
decorate() {
  local handler="_${FUNCNAME[0]}" text="" what="${1-}" lp dp style
  [ "$what" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  shift && [ -n "$what" ] || __catchArgument "$handler" "Requires at least one argument: \"$*\"" || return $?

  if ! style=$(__decorateStyle "$what"); then
    local extend func="${what/-/_}"
    extend="__decorateExtension$(printf "%s" "${func:0:1}" | awk '{print toupper($0)}')${func:1}"
    # When this next line calls `__catchArgument` it results in an infinite loop, so don't - use _argument
    # shellcheck disable=SC2119
    isFunction "$extend" || _argument printf -- "%s\n%s\n" "Unknown decoration name: $what ($extend)" "$(decorations)" || return $?
    __executeInputSupport "$handler" "$extend" -- "$@" || return $?
    return 0
  fi
  IFS=" " read -r lp dp text <<<"$style" || :
  [ "$dp" != "-" ] || dp="$lp"
  local p='\033['

  __executeInputSupport "$handler" __decorate "$text" "${p}${lp}m" "${p}${dp:-$lp}m" "${p}0m" -- "$@" || return $?
}
_decorate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_decorateInitialize() {
  export __BUILD_COLORS
  [ -n "${__BUILD_COLORS-}" ] || __decorateStyles || return $?
}

# Fetch the requested style as a string: lp dp text
# dp may be a dash for simpler parsing - dp=lp when dp is blank or dash
# text is optional, lp is required to be non-blank
# Requires: isArray __decorateStyles
__decorateStyle() {
  local original style pattern=$'\n'"$1="

  _decorateInitialize || return $?
  original="${__BUILD_COLORS}"
  style="${__BUILD_COLORS#*"$pattern"}"
  [ "$style" != "$original" ] || return 1
  style="${style%%$'\n'*}"
  printf "%s\n" "$style"
}

# Default array styles, override if you wish
if ! isFunction __decorateStyles; then
  # This sets __BUILD_COLORS to the styles strings
  __decorateStyles() {
    __decorateStylesDefault
  }
fi

# Default array styles, override if you wish
__decorateStylesDefault() {
  local styles="
reset=0
underline=4
no-underline=24
bold=1
no-bold=21
black=109;7
black-contrast=107;30
blue=94
cyan=36
green=92
magenta=35
orange=33
red=31
white=48;5;0;37
yellow=48;5;16;38;5;11
bold-black=1;109;7
bold-black-contrast=1;107;30
bold-blue=1;94
bold-cyan=1;36
bold-green=92
bold-magenta=1;35
bold-orange=1;33
bold-red=1;31
bold-white=1;48;5;0;37
bold-yellow=1;48;5;16;38;5;11
code=1;97;44
info=38;5;20 1;33 Info
notice=46;31 1;97;44 Notice
success=42;30 0;32 Success
warning=1;93;41 - Warning
error=1;91 - ERROR
subtle=1;38;5;252 1;38;5;240
label=34;103 1;96
value=1;40;97 1;97
decoration=45;97 45;30
"
  export __BUILD_COLORS
  __BUILD_COLORS="$styles"
}

# fn: decorate each
# Usage: decorate each decoration argument1 argument2 ...
# Runs the following command on each subsequent argument for formatting
# Also supports formatting input lines instead (on the same line)
# Example:     decorate each code "$@"
# Requires: decorate printf
# Argument: style - String. Required. The style to decorate each element.
# Argument: -- - Flag. Optional. Pass as the first argument after the style to avoid reading arguments from stdin.
# Argument: --index - Flag. Optional. Show the index of each item before with a colon. `0:first 1:second` etc.
# Argument: --count - Flag. Optional. Show the count of items in the list after the list is generated.
__decorateExtensionEach() {
  local formatted=() item addIndex=false showCount=false index=0 prefix=""

  while [ $# -gt 0 ]; do
    case "$1" in
    --index) addIndex=true ;;
    --count) showCount=true ;;
    --arguments) showCount=true ;;
    *) code="$1" && shift && break ;;
    esac
    shift
  done
  if [ $# -eq 0 ]; then
    local byte
    if read -r -t 1 -n 1 byte; then
      if [ "$byte" = $'\n' ]; then
        formatted+=("$prefix$(decorate "$code" "")")
        byte=""
      fi
      local done=false
      while ! $done; do
        IFS='' read -r item || done=true
        [ -n "$byte$item" ] || ! $done || break
        ! $addIndex || prefix="$index:"
        formatted+=("$prefix$(decorate "$code" "$byte$item")")
        byte=""
        index=$((index + 1))
      done
    fi
  else
    [ "${1-}" != "--" ] || shift
    while [ $# -gt 0 ]; do
      ! $addIndex || prefix="$index:"
      item="$1"
      formatted+=("$prefix$(decorate "$code" "$item")")
      shift
      index=$((index + 1))
    done
  fi
  ! $showCount || formatted+=("[$index]")
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

# <-- END of IDENTICAL decorate
