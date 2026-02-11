#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# fn: decorate diff
# Summary: Decoration for `diff -U0`
# Removes most diff character decoration and replaces with colors
#
# Argument: leftStyle - String. Required. Style for left file lines
# Argument: rightStyle - String. Required. Style for right file lines
__decorateExtensionDiff() {
  local handler="returnMessage"

  local leftStyle && leftStyle=$(validate "$handler" String "leftStyle" "${1-}") && shift || return $?
  local rightStyle && rightStyle=$(validate "$handler" String "leftStyle" "${1-}") && shift || return $?

  local finished=false
  while ! $finished; do
    local line && IFS="" read -r -d $'\n' line || finished=true
    [ -n "$line" ] || continue
    case "${line:0:3}" in
    "---") decorate "$leftStyle" "${line#--- }" ;;
    "-"*) decorate "$leftStyle" "${line:1}" ;;
    '+++') decorate "$rightStyle" "${line#+++ }" ;;
    "+"*) decorate "$rightStyle" "${line:1}" ;;
    "@"*) line="${line% @@*}" && decorate "subtle" "${line#@@* }" ;;
    " "*) printf "%s\n" "${line:1}" ;;
    *) printf "%s\n" "$line" ;;
    esac
  done
}

# Summary: Are files identical?
# Argument: -b - Flag. Causes trailing blanks (spaces and tabs) to be ignored, and other strings of blanks to compare equal.
# Argument: -B - Flag. Causes chunks that include only blank lines to be ignored.
# Argument: -i - Flag. Ignores the case of letters.  E.g., "A" will compare equal to "a".
# Argument: -w - Flag. Ignores all blanks and tabs.
# Argument: -I pattern - String. Optional. Ignore lines which match extended regular expression `pattern`.
# Argument: source - File. Required. File to compare to.
# Argument: target ... - File. Required. Target file to compare to. Additional files are compared to `source`.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 0 - Files are identical
# Return Code: 1 - Files differ
# Return Code: 2 - Argument error
filesAreIdentical() {
  local handler="_${FUNCNAME[0]}"

  local source="" target="" dd=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    -b | -B | -i) dd+=("$argument") ;;
    -I) shift && dd+=("$argument" "${1-}") ;;
    *)
      if [ -z "$source" ]; then
        [ "$argument" = "-" ] && source="$argument" || source="$(validate "$handler" File "source" "$argument")" || return $?
      else
        [ "$argument" = "-" ] && target="$argument" || target="$(validate "$handler" File "target" "$argument")" || return $?
        muzzle diff -q "${dd[@]+"${dd[@]}"}" "$source" "$target" || return 1
      fi
      ;;
    esac
    shift
  done
  [ -n "$source" ] || throwArgument "$handler" "source required" || return $?
  [ -n "$target" ] || throwArgument "$handler" "target required" || return $?
}
_filesAreIdentical() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
