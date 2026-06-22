#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="colors.sh"
credits=$'Tim Perry\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Returns 0 if a tty is available, 1 if not. Caches the saved value in `__BUILD_HAS_TTY` to avoid running the test each call.\n\n'
descriptionLineCount="2"
environment=$'__BUILD_HAS_TTY\n'
file="bin/build/tools/colors.sh"
fn="isTTYAvailable"
fnMarker="isttyavailable"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="environment" [4]="credits" [5]="url")
line="353"
original="isTTYAvailable"
rawComment=$'Summary: Quiet test for a TTY\nReturns 0 if a tty is available, 1 if not. Caches the saved value in `__BUILD_HAS_TTY` to avoid running the test each call.\nSee: stty\nArgument: --help - Flag. Optional. Display this help.\nEnvironment: __BUILD_HAS_TTY\nCredits: Tim Perry\nURL: https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'stty\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="480be5db852b12675144ab1e6476bc78bcb875fa"
sourceLine="353"
summary="Quiet test for a TTY"
summaryComputed=""
url=$'https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional\n'
usage="isTTYAvailable [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misTTYAvailable'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Returns 0 if a tty is available, 1 if not. Caches the saved value in '$'\e''[[(code)]m__BUILD_HAS_TTY'$'\e''[[(reset)]m to avoid running the test each call.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_HAS_TTY'
# shellcheck disable=SC2016
helpPlain='Usage: isTTYAvailable [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Returns 0 if a tty is available, 1 if not. Caches the saved value in __BUILD_HAS_TTY to avoid running the test each call.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_HAS_TTY'
documentationPath="documentation/source/tools/console.md"
