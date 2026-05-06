#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="vendor.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Are we within the JetBrains PyCharm terminal?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/vendor.sh"
fn="isPyCharm"
fnMarker="ispycharm"
foundNames=([0]="argument" [1]="return_code" [2]="see")
line="41"
rawComment="Are we within the JetBrains PyCharm terminal?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - within the PyCharm terminal"$'\n'"Return Code: 1 - not within the PyCharm terminal AFAIK"$'\n'"See: contextOpen"$'\n'""$'\n'""
return_code="0 - within the PyCharm terminal"$'\n'"1 - not within the PyCharm terminal AFAIK"$'\n'""
see="contextOpen"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceHash="6a1c6758472ed8ae9048cda1a9a026cbbe718421"
sourceLine="41"
summary="Are we within the JetBrains PyCharm terminal?"
summaryComputed="true"
usage="isPyCharm [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misPyCharm'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Are we within the JetBrains PyCharm terminal?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - within the PyCharm terminal'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - not within the PyCharm terminal AFAIK'
# shellcheck disable=SC2016
helpPlain='Usage: isPyCharm [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Are we within the JetBrains PyCharm terminal?'$'\n'''$'\n''Return codes:'$'\n''- 0 - within the PyCharm terminal'$'\n''- 1 - not within the PyCharm terminal AFAIK'
documentationPath="documentation/source/tools/vendor.md"
