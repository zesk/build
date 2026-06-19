#!/usr/bin/env bash
#
# Find missing `{SEE:...}` tokens
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#

__documentationFunctionsSeeLoop() {
  local handler="$1" && shift

  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local path && path=$(validate "$handler" Directory "path" "${1-}") && shift || return $?
  [ $# -eq 0 ] || throwArgument "$handler" "Unknown arguments: $*" || return $?

  local count=1
  while [ "$count" -gt 0 ]; do
    count=$(documentationFunctionsListSeeUnfinished "$path" | fileLineCount)
    [ "$count" -gt 0 ] || break
    decorate big "$count" | decorate red
    documentationFunctionsListSeeUnfinished "$path" | head -10
    sleep 10 && clear
  done
}

__documentationFunctionsListSeeUnfinished() {
  local handler="$1" && shift

  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local path && path=$(validate "$handler" Directory "path" "${1-}") && shift || return $?

  find "$path" -mindepth 1 -maxdepth 1 -type f -name '*.md' -print0 | xargs -0 grep -l '{SEE' | cut -c $((${#path} + 2))- | cut -f 1 -d . | sort
}

__documentationFunctionsSeeDirty() {
  local handler="$1" && shift

  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local path && path=$(validate "$handler" Directory "path" "${1-}") && shift || return $?

  local fun && while read -r fun; do
    local funFile="$path/$fun.md"
    [ ! -f "$funFile" ] || catchReturn "$handler" touch -d "1970-01-01T00:00:00" "$funFile" || return $?
  done < <(documentationFunctionsListSeeUnfinished "$path")
}
