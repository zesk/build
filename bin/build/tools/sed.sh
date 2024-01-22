#!/usr/bin/env bash
#
# sed.sh
#
# Depends: text.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorArgument 1
errorArgument=2

sedReplacePattern() {
  if [ $# -eq 0 ]; then
    consoleError "${FUNCNAME[0]} find replace - no find" 1>&2
    return "$errorArgument"
  fi
  printf "s/%s/%s/g\n" "$(quoteSedPattern "$1")" "$(quoteSedPattern "${2-}")"
}
