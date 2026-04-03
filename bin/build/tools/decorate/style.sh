#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Fetch
# Argument: style - String. Required. The style to fetch or replace.
# Argument: newFormat - String. Optional. The new style formatting options as a string in the form `lp dp label`
decorateStyle() {
  local handler="_${FUNCNAME[0]}"
  local style="" newFormat="" oldFormat changed=false

  _decorateInitialize || return $?
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$style" ]; then
        style=$(validate "$handler" String "style" "$1") || return $?
      else
        export __BUILD_DECORATE
        newFormat=$(validate "$handler" String "newFormat" "$1") || return $?
        if oldFormat=$(__decorateStyle "$style"); then
          __BUILD_DECORATE="$(__decorateStyleReplace "$__BUILD_DECORATE" "$style" "$newFormat")"
        else
          __BUILD_DECORATE="$__BUILD_DECORATE$style=$newFormat:"
        fi
        changed=true
      fi
      ;;
    esac
    shift
  done
  ! $changed || __decorateThemeSedFile "$handler" --delete

  if [ -n "$style" ]; then
    if ! oldFormat=$(__decorateStyle "$style"); then
      return 1
    fi
    printf "%s\n" "$oldFormat"
  fi
}
_decorateStyle() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: styleList - String. Required. Structure to modify.
# Argument: style - String. Required. Style to modify.
# Argument: newFormat - String. Required. New format for the style
__decorateStyleReplace() {
  local colors="$1" style="$2" newFormat="$3" result
  local pattern=":$style="
  # Suffix first
  result="${colors#*"$pattern"}"
  result="${colors%%"$pattern"*}$pattern$newFormat:${result#*:}"
  printf "%s\n" "$result"
}
