#!/usr/bin/env bash
#
# Identical template
#
# Original of _colors
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

#
# EDIT THIS FILE - EDIT THIS FILE - EDIT THIS FILE - EDIT THIS FILE
# EDIT THIS FILE - EDIT THIS FILE - EDIT THIS FILE - EDIT THIS FILE
# EDIT THIS FILE - EDIT THIS FILE - EDIT THIS FILE - EDIT THIS FILE
#

# IDENTICAL decorate EOF

# Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 0 - Console or output supports colors
# Return Code: 1 - Colors are likely not supported by console
# Environment: BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors.
# Requires: isPositiveInteger tput
consoleHasColors() {
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
_consoleHasColors() {
  true || consoleHasColors --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Semantics-based
#
# Argument: label - Text label
# Argument: lightStartCode - Escape code label for light mode (color)
# Argument: endCode - Escape end code
# Argument: text ... - Text to output.
# Requires: consoleHasColors printf
__decorate() {
  local prefix="$1" start="$2" end="$3" && shift 3
  export BUILD_COLORS
  if [ -n "${BUILD_COLORS-}" ] && [ "${BUILD_COLORS-}" = "true" ] || [ -z "${BUILD_COLORS-}" ] && consoleHasColors; then
    if [ $# -eq 0 ]; then printf -- "%s$start" ""; else printf -- "$start%s$end\n" "$*"; fi
    return 0
  fi
  [ $# -gt 0 ] || return 0
  if [ -n "$prefix" ]; then printf -- "%s: %s\n" "$prefix" "$*"; else printf -- "%s\n" "$*"; fi
}

# Output a list of build-in decoration styles, one per line
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
decorations() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf "%s\n" reset \
    underline no-underline bold no-bold \
    black black-contrast blue cyan green magenta orange red white yellow \
    code info notice success warning error subtle label value decoration
}
_decorations() {
  ! false || decorations --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Singular decoration function
# Argument: style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration
# Argument: text ... - String. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for `style`.
# You can extend this function by writing a your own extension `__decorationExtensionCustom` is called for `decorate custom`.
# stdout: Decorated text
# Environment: __BUILD_DECORATE - String. Cached color lookup.
# Environment: BUILD_COLORS - Boolean. Colors enabled (`true` or `false`).
# Requires: isFunction returnArgument awk catchEnvironment usageDocument executeInputSupport __help
decorate() {
  local handler="_${FUNCNAME[0]}" what="${1-}"
  [ "$what" != "--help" ] || __help "$handler" "$@" || return 0
  [ -n "$what" ] || catchArgument "$handler" "Requires at least one argument: \"$*\"" || return $?
  local style && shift && catchReturn "$handler" _decorateInitialize || return $?
  if ! style=$(__decorateStyle "$what"); then
    local extend func="${what/-/_}"
    extend="__decorateExtension$(printf "%s" "${func:0:1}" | awk '{print toupper($0)}')${func:1}"
    # When this next line calls `catchArgument` it results in an infinite loop, so don't - use returnArgument
    # shellcheck disable=SC2119
    if isFunction "$extend"; then
      executeInputSupport "$handler" "$extend" -- "$@" || return $?
      return 0
    else
      executeInputSupport "$handler" __decorate "❌" "[$what ☹️" "]" -- "$@" || return 2
    fi
  fi
  local lp text="" && IFS=" " read -r lp text <<<"$style" || :
  local p='\033['
  executeInputSupport "$handler" __decorate "$text" "${p}${lp}m" "${p}0m" -- "$@" || return $?
}
_decorate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is the decorate color system initialized yet?
# Useful to set our global color environment at the top level of a script if it hasn't been initialized already.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# shellcheck disable=SC2120
decorateInitialized() {
  [ "${1-}" != "--help" ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0
  export __BUILD_DECORATE
  [ -n "${__BUILD_DECORATE-}" ]
}
_decorateInitialized() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_decorateInitialize() {
  export __BUILD_DECORATE
  [ -n "${__BUILD_DECORATE-}" ] || __decorateStyles || return $?
}

# Fetch the requested style as a string: lp dp text
# dp may be a dash for simpler parsing - dp=lp when dp is blank or dash
# text is optional, lp is required to be non-blank
# Requires: __decorateStyles
__decorateStyle() {
  local original style pattern=":$1="

  original="${__BUILD_DECORATE}"
  style="${__BUILD_DECORATE#*"$pattern"}"
  [ "$style" != "$original" ] || return 1
  printf "%s\n" "${style%%:*}"
}

# Default array styles, override if you wish
if ! isFunction __decorateStyles; then
  # This sets __BUILD_DECORATE to the styles strings
  __decorateStyles() {
    __decorateStylesDefaultLight || __decorateStylesDefaultDark # Solely for link
  }
fi

# Default array styles, override if you wish
__decorateStylesBase() {
  local styles=":reset=0:underline=4:no-underline=24:bold=1:no-bold=21:black=109;7:black-contrast=107;30:blue=94:cyan=36:green=92:magenta=35:orange=33:red=31:white=48;5;0;37:yellow=48;5;16;38;5;11:"
  styles="$styles:$(printf "%s:" "$@")"
  styles="$styles:code=1;97;44:warning=1;93;41 Warning:error=1;91 ERROR:"
  export __BUILD_DECORATE
  __BUILD_DECORATE="$styles"
}
__decorateStylesDefaultLight() {
  local aa=(
    "info=38;5;20 Info"
    "notice=46;31 Notice"
    "success=42;30 Success"
    "subtle=1;38;5;252"
    "label=34;103"
    "value=30;107"
    "decoration=45;97"
  )
  __decorateStylesBase "${aa[@]}"
}
__decorateStylesDefaultDark() {
  local aa=(
    "info=33 Info"
    "notice=97;44 Notice"
    "success=0;32 Success"
    "subtle=38;5;240"
    "label=96;40"
    "value=94"
    "decoration=45;30"
  )
  __decorateStylesBase "${aa[@]}"
}

# fn: decorate each
# Runs the following command on each subsequent argument for formatting
# Also supports formatting input lines instead (on the same line)
# Example:     decorate each code -- "$@"
# Requires: decorate printf
# Argument: style - CommaDelimitedList. Required. Style arguments passed directly to decorate for each item.
# Argument: -- - Flag. Optional. Pass as the first argument after the style to avoid reading arguments from stdin.
# Argument: --index - Flag. Optional. Show the index of each item before with a colon. `0:first 1:second` etc.
# Argument: --count - Flag. Optional. Show the count of items in the list after the list is generated.
__decorateExtensionEach() {
  local __saved=("$@") __count=$#
  local formatted=() item addIndex=false showCount=false index=0 prefix="" style=""

  while [ $# -gt 0 ]; do
    case "$1" in --index) addIndex=true ;; --count) showCount=true ;; --arguments) showCount=true ;;
    "") throwArgument "$handler" "Blank argument" || return $? ;;
    *) style="$1" && shift && break ;;
    esac
    shift
  done
  local codes=("$style")
  if [ "$style" != "${style#*,}" ]; then
    IFS="," read -r -a codes <<<"$style"
    [ "${#codes[@]}" -gt 0 ] || throwArgument "$handler" "Blank style passed to each: \"$style\" (${__saved[*]})"
  fi
  if [ $# -eq 0 ]; then
    local byte
    if read -r -t 1 -n 1 byte; then
      if [ "$byte" = $'\n' ]; then
        formatted+=("$prefix$(decorate "${codes[@]}" "")")
        byte=""
      fi
      local done=false
      while ! $done; do
        IFS='' read -r item || done=true
        [ -n "$byte$item" ] || ! $done || break
        ! $addIndex || prefix="$index:"
        formatted+=("$prefix$(decorate "${codes[@]}" "$byte$item")")
        byte=""
        index=$((index + 1))
      done
    fi
  else
    [ "${1-}" != "--" ] || shift
    while [ $# -gt 0 ]; do
      ! $addIndex || prefix="$index:"
      item="$1"
      formatted+=("$prefix$(decorate "${codes[@]}" "$item")")
      shift
      index=$((index + 1))
    done
  fi
  ! $showCount || formatted+=("[$index]")
  IFS=" " printf -- "%s\n" "${formatted[*]-}"
}

# fn: decorate BOLD
# Argument: style - CommaDelimitedList. Required. Style arguments passed directly to decorate for each item.
# Argument: text ... - EmptyString. Optional. Text to format. Use `--` to output begin codes only.
__decorateExtensionBOLD() {
  local style="${1-}" && shift
  case "$style" in
  "" | "-" | "--")
    decorate bold "$*"
    return 0
    ;;
  esac
  local codes=("$style")
  if [ "$style" != "${style#*,}" ]; then
    IFS="," read -r -a codes <<<"$style"
    [ "${#codes[@]}" -gt 0 ] || throwArgument "$handler" "Blank style passed to BOLD: \"$style\" (${__saved[*]})"
  fi
  if [ "$*" != "--" ]; then
    if [ $# -eq 0 ]; then
      decorate "${codes[@]}" | decorate bold
    else
      decorate bold "$(decorate "${codes[@]}" -- "$@")"
    fi
  else
    decorate bold --
    decorate "${codes[@]}" --
  fi
}

# fn: decorate quote
# Double-quote all arguments as properly quoted bash string
# Mostly $ and " are problematic within a string
# Requires: printf decorate
__decorateExtensionQuote() {
  if [ $# -eq 0 ]; then
    local finished=false
    while ! $finished; do
      local line="" && IFS="" read -d $'\n' -r line || finished=true
      [ -n "$line" ] || ! $finished || continue
      __decorateExtensionQuoteProcessLine "$line" || return $?
    done
  else
    [ "$1" != "--" ] || shift
    __decorateExtensionQuoteProcessLine "$@" || return $?
  fi
}

# Argument: text ... - String. Text to quote
__decorateExtensionQuoteProcessLine() {
  local text="$*"
  text="${text//\"/\\\"}"
  text="${text//\$/\\\$}"
  printf -- "\"%s\"\n" "$text"
}

# <-- END of IDENTICAL decorate
