#!/usr/bin/env bash
#
# sed.sh
#
# Depends: text.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

sedReplacePattern() {
  local usage="_${FUNCNAME[0]}"
  if [ $# -eq 0 ]; then
    __failArgument "$usage" "find replace - no find" || return $?
  fi
  printf "s/%s/%s/g\n" "$(quoteSedPattern "$1")" "$(quoteSedReplacement "${2-}")"
}
_sedReplacePattern() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
