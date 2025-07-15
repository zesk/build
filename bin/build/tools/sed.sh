#!/usr/bin/env bash
#
# sed.sh
#
# Depends: text.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Quote a sed command for search and replace
# Argument: searchPattern - Required. String. The string to search for.
# Argument: replacePattern - Required. String. The replacement to replace with.
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
sedReplacePattern() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  printf "s/%s/%s/g\n" "$(quoteSedPattern "$1")" "$(quoteSedReplacement "${2-}")"
}
_sedReplacePattern() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
