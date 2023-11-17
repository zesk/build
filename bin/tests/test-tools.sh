#!/usr/bin/env bash
#
# test-tools.sh
#
# Test tools
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
testSection() {
    boxedHeading --size 0 "$@"
}

testHeading() {
    printf "%s" "$(consoleCode)"
    consoleOrange "$(echoBar '*')"
    printf "%s" "$(consoleCode)$(clearLine)"
    bigText "$@" | prefixLines "  $(consoleCode)"
    consoleOrange "$(echoBar)"
    consoleReset
}
