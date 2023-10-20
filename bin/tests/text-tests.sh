#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

testText() {
    assertOutputContains Hello boxedHeading Hello
}
