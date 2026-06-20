#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Set up a pre-commit hook and create a cache of our files by extension.\n\n'
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitPreCommitSetup"
fnMarker="gitprecommitsetup"
foundNames=([0]="see" [1]="argument" [2]="return_code")
line="882"
original="gitPreCommitSetup"
rawComment=$'Set up a pre-commit hook and create a cache of our files by extension.\nSee: gitPreCommitCleanup\nArgument: --help - Flag. Optional. Display this help.\nReturn code: 0 - One or more files are available as part of the commit\nReturn code: 1 - Error, or zero files are available as part of the commit\n\n'
return_code=$'0 - One or more files are available as part of the commit\n1 - Error, or zero files are available as part of the commit\n'
see=$'gitPreCommitCleanup\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="5e91a5d4b3beafc28e8b01755133cb215bd453d8"
sourceLine="882"
summary="Set up a pre-commit hook and create a cache of"
summaryComputed="true"
usage="gitPreCommitSetup [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitPreCommitSetup'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Set up a pre-commit hook and create a cache of our files by extension.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - One or more files are available as part of the commit'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Error, or zero files are available as part of the commit'
# shellcheck disable=SC2016
helpPlain='Usage: gitPreCommitSetup [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Set up a pre-commit hook and create a cache of our files by extension.'$'\n'''$'\n''Return codes:'$'\n''- 0 - One or more files are available as part of the commit'$'\n''- 1 - Error, or zero files are available as part of the commit'
documentationPath="documentation/source/tools/git.md"
