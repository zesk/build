#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\npath - Requires. String. The path to be removed from the `PATH` environment.\n'
base="path.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Remove a path from the PATH environment variable\n\n'
descriptionLineCount="2"
file="bin/build/tools/path.sh"
fn="pathRemove"
fnMarker="pathremove"
foundNames=([0]="argument")
line="12"
rawComment=$'Remove a path from the PATH environment variable\nArgument: --help - Flag. Optional. Display this help.\nArgument: path - Requires. String. The path to be removed from the `PATH` environment.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/path.sh"
sourceHash="21f0a5cf2e762f067606fe4d4a3c0e6f7a52a264"
sourceLine="12"
summary="Remove a path from the PATH environment variable"
summaryComputed="true"
usage="pathRemove [ --help ] [ path ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpathRemove'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ path ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mpath    '$'\e''[[(value)]mRequires. String. The path to be removed from the '$'\e''[[(code)]mPATH'$'\e''[[(reset)]m environment.'$'\e''[[(reset)]m'$'\n'''$'\n''Remove a path from the PATH environment variable'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: pathRemove [ --help ] [ path ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    path    Requires. String. The path to be removed from the PATH environment.'$'\n'''$'\n''Remove a path from the PATH environment variable'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/path.md"
