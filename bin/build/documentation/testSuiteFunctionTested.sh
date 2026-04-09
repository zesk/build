#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--verbose - Flag. Optional. Show list of true results when all arguments pass."$'\n'"functionName ... - String. Function to look up to see if it has been tested. One or more."$'\n'""
base="test.sh"
description="When environment variable \`TEST_TRACK_ASSERTIONS\` is \`true\` – \`testSuite\` and assertion functions track which functions take a function value (for example, \`assertExitCode\`) and track functions which are run, and stores them in the testing cache directory which accumulate after each test run unless the cache is cleared."$'\n'""
environment="TEST_TRACK_ASSERTIONS"$'\n'""
file="bin/build/tools/test.sh"
fn="testSuiteFunctionTested"
foundNames=([0]="argument" [1]="return_code" [2]="important" [3]="environment")
important="If you test your function's \`--help\` function then you can ignore it using"$'\n'""
line="513"
lowerFn="testsuitefunctiontested"
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"When environment variable \`TEST_TRACK_ASSERTIONS\` is \`true\` – \`testSuite\` and assertion functions track which functions take a function value (for example, \`assertExitCode\`) and track functions which are run, and stores them in the testing cache directory which accumulate after each test run unless the cache is cleared."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --verbose - Flag. Optional. Show list of true results when all arguments pass."$'\n'"Argument: functionName ... - String. Function to look up to see if it has been tested. One or more."$'\n'"Return Code: 0 - All functions were tested by the test suite at least once."$'\n'"Return Code: 1 - At least one function was not tested by the test suite at least once."$'\n'"Important: If you test your function's \`--help\` function then you can ignore it using"$'\n'"Environment: TEST_TRACK_ASSERTIONS"$'\n'""$'\n'""
return_code="0 - All functions were tested by the test suite at least once."$'\n'"1 - At least one function was not tested by the test suite at least once."$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="a67c5b2c2396821f4e070140f0dabed2cde8ea23"
sourceLine="513"
summary="When environment variable \`TEST_TRACK_ASSERTIONS\` is \`true\` – \`testSuite\` and assertion"
summaryComputed="true"
usage="testSuiteFunctionTested [ --help ] [ --help ] [ --verbose ] [ functionName ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtestSuiteFunctionTested'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ functionName ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help            '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help            '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose         '$'\e''[[(value)]mFlag. Optional. Show list of true results when all arguments pass.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfunctionName ...  '$'\e''[[(value)]mString. Function to look up to see if it has been tested. One or more.'$'\e''[[(reset)]m'$'\n'''$'\n''When environment variable '$'\e''[[(code)]mTEST_TRACK_ASSERTIONS'$'\e''[[(reset)]m is '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m – '$'\e''[[(code)]mtestSuite'$'\e''[[(reset)]m and assertion functions track which functions take a function value (for example, '$'\e''[[(code)]massertExitCode'$'\e''[[(reset)]m) and track functions which are run, and stores them in the testing cache directory which accumulate after each test run unless the cache is cleared.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All functions were tested by the test suite at least once.'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - At least one function was not tested by the test suite at least once.'$'\n'''$'\n''Environment variables:'$'\n''- TEST_TRACK_ASSERTIONS'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: testSuiteFunctionTested [ --help ] [ --help ] [ --verbose ] [ functionName ... ]'$'\n'''$'\n''    --help            Flag. Optional. Display this help.'$'\n''    --help            Flag. Optional. Display this help.'$'\n''    --verbose         Flag. Optional. Show list of true results when all arguments pass.'$'\n''    functionName ...  String. Function to look up to see if it has been tested. One or more.'$'\n'''$'\n''When environment variable TEST_TRACK_ASSERTIONS is true – testSuite and assertion functions track which functions take a function value (for example, assertExitCode) and track functions which are run, and stores them in the testing cache directory which accumulate after each test run unless the cache is cleared.'$'\n'''$'\n''Return codes:'$'\n''- 0 - All functions were tested by the test suite at least once.'$'\n''- 1 - At least one function was not tested by the test suite at least once.'$'\n'''$'\n''Environment variables:'$'\n''- TEST_TRACK_ASSERTIONS'$'\n'''
documentationPath="documentation/source/tools/test.md"
