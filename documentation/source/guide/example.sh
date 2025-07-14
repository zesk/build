#!/usr/bin/env bash
#
# Sample Usage generation using comments
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
# Usage: myCoolScript
# Argument: fileArg - Required. File. The file to cool
# Argument: directoryArg - Required. Directory. The place to put the cool file
# Argument: --help - Show this help and exit
# Example:      myCoolScript my.cool ./coolOutput/
# This is added to the description.
# Note that whitespace is stripped from the top of the description, but not the bottom or within.
# Example:      myCoolScript another.cool ./coolerOutput/
#
myCoolScript() {
  local argument fileArg directoryArg
  local usage

  usage="_${FUNCNAME[0]}"

  fileArg=
  directoryArg=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    *)
      if [ -z "$fileArg" ]; then
        fileArg="$(usageArgumentFile "$usage" fileArg "$argument")" || return $?
      elif [ -z "$directoryArg" ]; then
        directoryArg="$(usageArgumentDirectory "$usage" directoryArg "$argument")" || return $?
      else
        __throwArgument "unknown argument: $argument" || return $?
      fi
      ;;
    esac
    shift || :
  done

  # cool things
  printf "%s -> %s\n" "$(basename "$fileArg")" "$directoryArg"
}
_myCoolScript() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

myCoolScript "$@"
