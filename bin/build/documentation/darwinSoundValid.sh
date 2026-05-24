#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument="none"
base="darwin.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Is a Darwin sound name valid?\n\n'
descriptionLineCount="2"
file="bin/build/tools/darwin.sh"
fn="darwinSoundValid"
fnMarker="darwinsoundvalid"
foundNames=()
line="35"
rawComment=$'Is a Darwin sound name valid?\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/darwin.sh"
sourceHash="ec705e085d0b6db06177741d264497efd1aa9f27"
sourceLine="35"
summary="Is a Darwin sound name valid?"
summaryComputed="true"
usage="darwinSoundValid"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdarwinSoundValid'$'\e''[0m'$'\n'''$'\n''Is a Darwin sound name valid?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: darwinSoundValid'$'\n'''$'\n''Is a Darwin sound name valid?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/darwin.md"
