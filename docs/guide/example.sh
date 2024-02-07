#!/usr/bin/env bash
#
# Sample Usage generation using comments
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

errorEnvironment=1

errorArgument=2

cd "$(dirname "${BASH_SOURCE[0]}")/../.." || exit "$errorEnvironment"

# shellcheck source=/dev/null
. ./bin/build/tools.sh

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
  local fileArg directoryArg

  if ! fileArg="$(usageArgumentFile "_${FUNCNAME[0]}" fileArg "$1")"; then
    return $errorArgument
  fi
  shift || return $errorArgument
  if ! directoryArg="$(usageArgumentDirectory "_${FUNCNAME[0]}" directoryArg "$1")"; then
    return $errorArgument
  fi
  shift || return $errorArgument

  # cool things
  printf "%s -> %s\n" "$(basename "$fileArg")" "$directoryArg"
}
_myCoolScript() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

myCoolScript "$@"
