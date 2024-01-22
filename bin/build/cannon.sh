#!/bin/bash
#
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorArgument 1
errorArgument=2

# IDENTICAL bashHeader2 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

me=$(basename "${BASH_SOURCE[0]}")

#
# Usage generator for `cannon`
# See: cannon
#
_cannonUsage() {
  usageDocument "bin/build/$me" cannon "$@"
  return $?
}

#
# fn: cannon.sh
# Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.
#
# This can break your files so use with caution.
#
# Example:     cannon master main ! -path '*/old-version/*')
# _cannonUsage: cannon fromText toText [ findArgs ... ]
# Argument: fromText - Required. String of text to search for.
# Argument: toText - Required. String of text to replace.
# Argument: findArgs ... - Any additional arguments are meant to filter files.
# Exit Code: 0 - Success
# Exit Code: 1 - Arguments are identical
#
#
cannon() {
  local search searchQuoted replaceQuoted

  if [ -z "${1-}" ]; then
    _cannonUsage "$errorArgument" "Empty search string"
    return $?
  fi
  search=${1-}
  searchQuoted=$(quoteSedPattern "$search")
  shift || _cannonUsage "$errorArgument" "Missing replacement argument"
  if [ -z "${1-}" ]; then
    _cannonUsage "$errorArgument" "Empty replacement string"
    return $?
  fi
  replaceQuoted=$(quoteSedPattern "${1-}")
  shift
  if [ "$searchQuoted" = "$replaceQuoted" ]; then
    _cannonUsage "$errorArgument" "from to \"$search\" are identical"
  fi

  cannonLog=$(mktemp)
  find . -type f ! -path '*/.*' "$@" -print0 | xargs -0 grep -l "$search" | tee "$cannonLog" | xargs sed -i '' -e "s/$searchQuoted/$replaceQuoted/g"
  consoleSuccess "# Modified $(wc -l <"$cannonLog") files"
  rm "$cannonLog"
}

cannon "$@"
