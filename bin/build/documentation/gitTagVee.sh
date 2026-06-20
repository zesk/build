#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"\nDelete the old tag as well\n\n'
descriptionLineCount="3"
file="bin/build/tools/git.sh"
fn="gitTagVee"
fnMarker="gittagvee"
foundNames=()
line="185"
original="gitTagVee"
rawComment=$'Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"\nDelete the old tag as well\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="5e91a5d4b3beafc28e8b01755133cb215bd453d8"
sourceLine="185"
summary="Given a tag in the form \"1.1.3\" convert it to"
summaryComputed="true"
usage="gitTagVee"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitTagVee'$'\e''[0m'$'\n'''$'\n''Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"'$'\n''Delete the old tag as well'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: gitTagVee'$'\n'''$'\n''Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"'$'\n''Delete the old tag as well'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/git.md"
