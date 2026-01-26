#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Converts decoration style to a mode where the theme can be applied later to text which is formatted.
# All decorate calls made after this call will output with special codes not to be displayed to the user.
# Argument: --end - Flag. Optional. End themeless mode.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Environment: __BUILD_DECORATE
decorateThemelessMode() {
  local handler="_${FUNCNAME[0]}"

  local endFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --end) endFlag=true ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  export __BUILD_DECORATE
  [ -n "${__BUILD_DECORATE-}" ] || throwEnvironment "$handler" "Decorate colors not initialized." || return $?
  export __BUILD_DECORATE_SAVED
  if $endFlag; then
    [ -n "${__BUILD_DECORATE_SAVED-}" ] || throwEnvironment "$handler" "Themeless mode not saved." || return $?
    __BUILD_DECORATE="$__BUILD_DECORATE_SAVED"
    unset __BUILD_DECORATE_SAVED
    return 0
  else
    [ -z "${__BUILD_DECORATE_SAVED-}" ] || throwEnvironment "$handler" "Themeless mode already initialized." || return $?
  fi

  local styles=()
  local finished=false && while ! $finished; do
    local style && read -r style || finished=true
    [ -n "$style" ] || continue
    styles+=("$style=[($style)]")
  done < <(decorations)

  __BUILD_DECORATE_SAVED="${__BUILD_DECORATE-}"
  __BUILD_DECORATE=":$(listJoin ":" "${styles[@]}"):"
}
_decorateThemelessMode() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Applies the current theme to text rendered using `decorateThemelessMode`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# stdin: Text to apply current theme to
# stdout: Console-ready text
decorateThemed() {
  local handler="_${FUNCNAME[0]}"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *) break ;;
    esac
    shift
  done

  if [ $# -gt 0 ]; then
    catchEnvironment "$handler" printf "%s\n" "$@" | __decorateThemed "$handler" || return $?
  else
    __decorateThemed "$handler" || return $?
  fi
}
_decorateThemed() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__decorateThemed() {
  local handler="$1" && shift
  export __BUILD_DECORATE
  [ -n "${__BUILD_DECORATE-}" ] || throwEnvironment "$handler" "Decorate colors not initialized." || return $?

  local sedFile && sedFile=$(__decorateThemeSedFile "$handler") || return $?
  catchEnvironment "$handler" sed -f "$sedFile" || return $?
}

__decorateThemeGenerateSedFile() {
  local handler="$1" && shift
  local style colorCode && while IFS="=" read -r -d ':' style colorCode; do
    # colorCode - Strip space and after "1;33 Info" -> "1;33"
    [ -z "$style" ] || catchReturn "$handler" sedReplacePattern "[($style)]" "${colorCode%% *}" || return $?
  done
}

__decorateThemeSedFile() {
  local handler="$1" && shift

  export __BUILD_DECORATE_THEME
  case "${1-}" in
  --delete)
    [ -f "${__BUILD_DECORATE_THEME-}" ] || return 0
    catchEnvironment "$handler" rm -f "${__BUILD_DECORATE_THEME-}" || return $?
    unset __BUILD_DECORATE_THEME
    return 0
    ;;
  esac
  export __BUILD_DECORATE
  if [ ! -f "${__BUILD_DECORATE_THEME-}" ]; then
    local sedFile && sedFile="$(catchReturn "$handler" buildCacheDirectory)/theme.sed" || return $?
    __decorateThemeGenerateSedFile "$handler" >"$sedFile" <<<"${__BUILD_DECORATE-}" || returnClean $? "$sedFile" || return $?
    __BUILD_DECORATE_THEME="$sedFile"
  fi
  catchEnvironment "$handler" printf "%s\n" "${__BUILD_DECORATE_THEME-}" || return $?
}
