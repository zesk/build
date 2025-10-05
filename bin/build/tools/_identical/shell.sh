#!/usr/bin/env bash
#
# Checking identical
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# In case you forgot, the directory in which this file is named `_identical` and *NOT* `identical`.
#
# This is to avoid having this match when doing `identicalRepair` - causes issues.
#
# Thanks for your consideration.

__identicalCheckShell() {
  local handler="$1" && shift
  local argument aa=() pp=() addDefaultPrefixes=true

  local internalPrefixes=(--prefix '# ''DOC TEMPLATE:' --prefix '# ''__IDENTICAL__' --prefix '# ''_IDENTICAL_')

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || returnThrowArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --internal-only)
      pp=("${internalPrefixes[@]}")
      addDefaultPrefixes=false
      ;;
    --internal)
      if [ "${#pp[@]}" -eq 0 ]; then
        # Ordering here matters so declare from inside scope to outside scope
        pp=("${internalPrefixes[@]}")
      fi
      ;;
    --interactive | --ignore-singles | --no-map | --watch | --debug | --verbose)
      aa+=("$argument")
      ;;
    --repair | --single | --exec | --prefix | --exclude | --extension | --skip | --singles | --cd)
      shift
      aa+=("$argument" "${1-}")
      ;;
    *)
      break
      ;;
    esac
    shift || :
  done
  ! $addDefaultPrefixes || pp+=(--prefix '# ''IDENTICAL')
  returnCatch "$handler" identicalCheck "${aa[@]+"${aa[@]}"}" "${pp[@]}" --extension sh "$@" || return $?
}
