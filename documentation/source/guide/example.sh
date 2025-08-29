#!/usr/bin/env bash
#
# Sample handler generation using comments
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
set -eou pipefail

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/tools.sh" || exit 99

# Summary: Cool file processor
#
# Process a cool file.
#
# - Formatting is preserved and `markdown` is supported
# - Also **bold** and *italic* - but that's it
# - Lists look like lists in text largely because markdown is just pretty text
#
# handler: myCoolScript
# Argument: fileArg - Required. File. The file to cool
# Argument: directoryArg - Required. Directory. The place to put the cool file
# Argument: --help - Show this help and exit
# Example:      myCoolScript my.cool ./coolOutput/
# This is added to the description.
# Note that whitespace is stripped from the top of the description, but not the bottom or within.
# Example:      myCoolScript another.cool ./coolerOutput/
#
myCoolScript() {
  local handler="_${FUNCNAME[0]}"

  local fileArg="" directoryArg=""
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$fileArg" ]; then
        fileArg="$(usageArgumentFile "$handler" fileArg "$argument")" || return $?
      elif [ -z "$directoryArg" ]; then
        directoryArg="$(usageArgumentDirectory "$handler" directoryArg "$argument")" || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  # cool things
  printf "%s -> %s\n" "$(basename "$fileArg")" "$directoryArg"
}
_myCoolScript() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

myCoolScript "$@"
