#!/usr/bin/env bash
#
# test-tools.sh
#
# Test tools
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
testSection() {
    boxedHeading --height 0 "$@"
}

testHeading() {
    bigText "$@"
    consoleOrange "$(echoBar)"
    consoleReset
}
