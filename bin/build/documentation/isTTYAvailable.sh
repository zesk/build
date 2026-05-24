#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="colors.sh"
credits=$'Tim Perry\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Returns 0 if a tty is available, 1 if not. Caches the saved value in `__BUILD_HAS_TTY` to avoid running the test each call.ZL\n\n'
descriptionLineCount="2"
environment=$'- `__BUILD_HAS_TTY` - Cached value of `false` or `true`. Any other value forces computation during this call.\n'
file="bin/build/tools/colors.sh"
fn="isTTYAvailable"
fnMarker="isttyavailable"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="environment" [4]="credits" [5]="url")
line="376"
rawComment=$'Summary: Quiet test for a TTY\nReturns 0 if a tty is available, 1 if not. Caches the saved value in `__BUILD_HAS_TTY` to avoid running the test each call.ZL\nSee: stty /dev/tty\nArgument: --help - Flag. Optional. Display this help.\nEnvironment: - `__BUILD_HAS_TTY` - Cached value of `false` or `true`. Any other value forces computation during this call.\nCredits: Tim Perry\nURL: https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'stty /dev/tty\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="376"
summary="Quiet test for a TTY"
summaryComputed=""
url=$'https://stackoverflow.com/questions/69075612/cross-platform-method-to-detect-whether-dev-tty-is-available-functional\n'
usage="isTTYAvailable [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misTTYAvailable'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Returns 0 if a tty is available, 1 if not. Caches the saved value in '$'\e''[[(code)]m__BUILD_HAS_TTY'$'\e''[[(reset)]m to avoid running the test each call.ZL'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]m__BUILD_HAS_TTY'$'\e''[[(reset)]m - Cached value of '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m or '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m. Any other value forces computation during this call.'
# shellcheck disable=SC2016
helpPlain='Usage: isTTYAvailable [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Returns 0 if a tty is available, 1 if not. Caches the saved value in __BUILD_HAS_TTY to avoid running the test each call.ZL'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- __BUILD_HAS_TTY - Cached value of false or true. Any other value forces computation during this call.'
documentationPath="documentation/source/tools/console.md"
