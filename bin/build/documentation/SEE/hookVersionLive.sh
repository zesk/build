#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--application application - Directory. Optional. Application home directory."$'\n'""
base="hooks.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Application deployed version"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/hooks.sh"
fn="hookVersionLive"
fnMarker="hookversionlive"
foundNames=([0]="argument")
line="80"
rawComment="Application deployed version"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --application application - Directory. Optional. Application home directory."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/hooks.sh"
sourceHash="570428982fce9483238ecdd12bae69f0c2276727"
sourceLine="80"
summary="Application deployed version"
summaryComputed="true"
usage="hookVersionLive [ --help ] [ --application application ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mhookVersionLive'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --application application ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--application application  '$'\e''[[(value)]mDirectory. Optional. Application home directory.'$'\e''[[(reset)]m'$'\n'''$'\n''Application deployed version'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: hookVersionLive [ --help ] [ --application application ]'$'\n'''$'\n''    --help                     Flag. Optional. Display this help.'$'\n''    --application application  Directory. Optional. Application home directory.'$'\n'''$'\n''Application deployed version'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/hooks.md"
