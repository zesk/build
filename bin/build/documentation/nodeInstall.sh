#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument="none"
base="node.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Install nodejs\n\n'
descriptionLineCount="2"
file="bin/build/tools/node.sh"
fn="nodeInstall"
fnMarker="nodeinstall"
foundNames=()
line="14"
rawComment=$'Install nodejs\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/node.sh"
sourceHash="acc8eb2718d339810a7c4729acfbef8a6c8ac091"
sourceLine="14"
summary="Install nodejs"
summaryComputed="true"
usage="nodeInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnodeInstall'$'\e''[0m'$'\n'''$'\n''Install nodejs'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: nodeInstall'$'\n'''$'\n''Install nodejs'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/node.md"
