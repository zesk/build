#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--verbose - Flag. Optional. Show list of true results when all arguments pass."$'\n'"functionName ... - String. Function to look up to see if it has been tested. One or more."$'\n'""
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="When environment variable \`TEST_TRACK_ASSERTIONS\` is \`true\` – \`testSuite\` and assertion functions track which functions take a function value (for example, \`assertExitCode\`) and track functions which are run, and stores them in the testing cache directory which accumulate after each test run unless the cache is cleared."$'\n'""$'\n'""
descriptionLineCount="2"
environment="TEST_TRACK_ASSERTIONS"$'\n'""
file="bin/build/tools/test.sh"
fn="testSuiteFunctionTested"
fnMarker="testsuitefunctiontested"
foundNames=([0]="argument" [1]="return_code" [2]="important" [3]="environment")
important="If you test your function's \`--help\` function then you can ignore it using"$'\n'""
line="513"
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"When environment variable \`TEST_TRACK_ASSERTIONS\` is \`true\` – \`testSuite\` and assertion functions track which functions take a function value (for example, \`assertExitCode\`) and track functions which are run, and stores them in the testing cache directory which accumulate after each test run unless the cache is cleared."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --verbose - Flag. Optional. Show list of true results when all arguments pass."$'\n'"Argument: functionName ... - String. Function to look up to see if it has been tested. One or more."$'\n'"Return Code: 0 - All functions were tested by the test suite at least once."$'\n'"Return Code: 1 - At least one function was not tested by the test suite at least once."$'\n'"Important: If you test your function's \`--help\` function then you can ignore it using"$'\n'"Environment: TEST_TRACK_ASSERTIONS"$'\n'""$'\n'""
return_code="0 - All functions were tested by the test suite at least once."$'\n'"1 - At least one function was not tested by the test suite at least once."$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="78c7da5cbc1777fd8206d96854e19720ad1957a9"
sourceLine="513"
summary="When environment variable \`TEST_TRACK_ASSERTIONS\` is \`true\` – \`testSuite\` and assertion"
summaryComputed="true"
usage="testSuiteFunctionTested [ --help ] [ --help ] [ --verbose ] [ functionName ... ]"
