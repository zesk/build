#!/usr/bin/env bash
#
# Sample Usage generation using comments
#
# Copyright &copy; 2024 Market Acument, Inc.
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."
me=$(basename "${BASH_SOURCE[0]}")

# shellcheck source=/dev/null
. ./bin/build/tools.sh

_myCoolScriptUsage() {
    usageDocument "./docs/guide/$me" "myCoolScript" "$@"
    exit $?
}

# Summary: Cool file processor
#
# Process a cool file.
#
# - Formatting is preserved and `markdown` is supported
# - Also **bold** and *italic* - but that's it
# - Lists look like lists in text largely because markdown is just pretty text
#
# Usage: myCoolScript
# Argument: file - Required. File. The file to cool
# Argument: directory - Required. Directory. The place to put the file
# Argument: --help - Show this help and exit
# Example:      myCoolScript my.cool ./coolOutput/
# This is added to the description.
# Note that whitespace is stripped from the top of the description, but not the bottom or within.
# Example:      myCoolScript another.cool ./coolerOutput/
#
myCoolScript() {
    file="${1-}"
    # ...
    if [ -z "$file" ]; then
        _myCoolScriptUsage 1 "Requries a file"
    fi
    if [ ! -f "$file" ]; then
        _myCoolScriptUsage 1 "$file is not a file"
    fi
    # cool things
}

myCoolScript "$@"
