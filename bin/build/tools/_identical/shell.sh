#!/usr/bin/env bash
#
# Checking identical
#
# Copyright &copy; 2026 Market Acumen, Inc.
#


__identicalCheckShell() {
  local handler="$1" && shift
  local argument aa=() pp=() addDefaultPrefixes=true
  local prefix="# "

  local internalPrefixes=(--prefix "${prefix}DOC TEMPLATE:" --prefix "${prefix}__IDENTICAL__" --prefix "${prefix}_IDENTICAL_")

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --internal-only) pp=("${internalPrefixes[@]}") && addDefaultPrefixes=false ;;
    --internal)
      # Ordering here matters so declare from inside scope to outside scope
      [ "${#pp[@]}" -gt 0 ] || pp=("${internalPrefixes[@]}")
      ;;
    --interactive | --ignore-singles | --no-map | --watch | --debug | --verbose)
      aa+=("$argument")
      ;;
    --repair | --single | --exec | --prefix | --exclude | --extension | --skip | --singles | --cd) shift && aa+=("$argument" "${1-}") ;;
    *) break ;;
    esac
    shift || :
  done
  ! $addDefaultPrefixes || pp+=(--prefix "${prefix}IDENTICAL")
  catchReturn "$handler" identicalCheck "${aa[@]+"${aa[@]}"}" "${pp[@]}" --extension sh "$@" || return $?
}
