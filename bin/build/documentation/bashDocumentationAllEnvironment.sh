#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-02
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Uses list of functions passed in `stdin`; using the `SEE` template.\nOutput to `allEnvironmentList.md` typically.\n\n'
descriptionLineCount="3"
file="bin/build/tools/documentation.sh"
fn="bashDocumentationAllEnvironment"
fnMarker="bashdocumentationallenvironment"
foundNames=([0]="summary" [1]="argument" [2]="stdin")
line="672"
rawComment=$'Summary: Generate markdown for a list of all functions\nUses list of functions passed in `stdin`; using the `SEE` template.\nOutput to `allEnvironmentList.md` typically.\nArgument: --help - Flag. Optional. Display this help.\nstdin: EnvironmentVariable. One per line.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="13134038a36d80d9eea8bb3ddf5535edac40ac2b"
sourceLine="672"
stdin=$'EnvironmentVariable. One per line.\n'
summary="Generate markdown for a list of all functions"
summaryComputed=""
usage="bashDocumentationAllEnvironment [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDocumentationAllEnvironment'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Uses list of functions passed in '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m; using the '$'\e''[[(code)]mSEE'$'\e''[[(reset)]m template.'$'\n''Output to '$'\e''[[(code)]mallEnvironmentList.md'$'\e''[[(reset)]m typically.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''EnvironmentVariable. One per line.'
# shellcheck disable=SC2016
helpPlain='Usage: bashDocumentationAllEnvironment [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Uses list of functions passed in stdin; using the SEE template.'$'\n''Output to allEnvironmentList.md typically.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''EnvironmentVariable. One per line.'
documentationPath="documentation/source/tools/documentation.md"
