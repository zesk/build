#!/usr/bin/env bash
#
# Documentation
#
# Copyright &copy; 2025 Market Acumen, Inc.

interactiveCountdown() {
  local handler="_${FUNCNAME[0]}"

  local prefix="" counter="" binary="" runner=("statusMessage" "printf" -- "%s")

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --prefix)
      shift
      prefix="$(usageArgumentEmptyString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --badge)
      runner=(bigTextAt "-5" "5")
      ;;
    *)
      if [ -z "$counter" ]; then
        counter=$(usageArgumentPositiveInteger "$handler" "counter" "$1") || return $?
      else
        binary=$(usageArgumentCallable "$handler" "callable" "$1") || return $?
        break
      fi
      ;;
    esac
    shift
  done
  [ -n "$counter" ] || __throwArgument "$handler" "counter is required" || return $?

  local start end now

  start=$(timingStart) || return $?
  end=$((start + counter * 1000))
  now=$start
  [ -z "$prefix" ] || prefix="$prefix "

  while [ "$now" -lt "$end" ]; do
    __catchEnvironment "$handler" "${runner[@]}" "$(printf "%s%s" "$(decorate info "$prefix")" "$(decorate value " $((counter / 1000)) ")")" || return $?
    sleep 1 || __throwEnvironment "$handler" "Interrupted" || return $?
    now=$(timingStart) || return $?
    counter=$((end - now))
  done
  statusMessage printf -- "%s" ""
  if [ -n "$binary" ]; then
    __catch "$handler" "$@" || return $?
  fi
}
_interactiveCountdown() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

