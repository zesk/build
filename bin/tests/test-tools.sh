#!/usr/bin/env bash
#
# test-tools.sh
#
# Test tools
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
testSection() {
    local bar spaces remain

    bar="+$(echoBar '' -2)+"
    remain="$*"
    spaces=$((${#bar} - ${#remain} - 4))
    consoleDecoration "$bar"
    echo "$(consoleDecoration -n \|) $(consoleInfo -n "$remain")$(repeat $spaces " ") $(consoleDecoration -n \|)"
    consoleDecoration "$bar"
}
