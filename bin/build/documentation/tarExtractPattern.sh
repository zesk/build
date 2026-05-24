#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'pattern - The file pattern to extract\n'
base="tar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Platform agnostic tar extract with wildcards\n\ne.g. `tar -xf \'*/file.json\'` or `tar -xf --wildcards \'*/file.json\'` depending on OS\n\n`tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments.\n\n'
descriptionLineCount="6"
file="bin/build/tools/tar.sh"
fn="tarExtractPattern"
fnMarker="tarextractpattern"
foundNames=([0]="short_description" [1]="argument" [2]="stdin" [3]="stdout")
line="19"
rawComment=$'Platform agnostic tar extract with wildcards\ne.g. `tar -xf \'*/file.json\'` or `tar -xf --wildcards \'*/file.json\'` depending on OS\n`tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments.\nShort description: Platform agnostic tar extract\nArgument: pattern - The file pattern to extract\nstdin: A gzipped-tar file\nstdout: The desired file\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
short_description=$'Platform agnostic tar extract\n'
sourceFile="bin/build/tools/tar.sh"
sourceHash="7a8a92654406b6853c275aeac20e6584694326aa"
sourceLine="19"
stdin=$'A gzipped-tar file\n'
stdout=$'The desired file\n'
summary="Platform agnostic tar extract with wildcards"
summaryComputed="true"
usage="tarExtractPattern [ pattern ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtarExtractPattern'$'\e''[0m '$'\e''[[(blue)]m[ pattern ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpattern  '$'\e''[[(value)]mThe file pattern to extract'$'\e''[[(reset)]m'$'\n'''$'\n''Platform agnostic tar extract with wildcards'$'\n'''$'\n''e.g. '$'\e''[[(code)]mtar -xf '\'''$'\e''[[(cyan)]m/file.json'\'''$'\e''[[(reset)]m or '$'\e''[[(code)]mtar -xf --wildcards '\'''$'\e''[[(reset)]m/file.json'\'''$'\e''[[(reset)]m depending on OS'$'\n'''$'\n'''$'\e''[[(code)]mtar'$'\e''[[(reset)]m command is not cross-platform so this differentiates between the GNU and BSD command line arguments.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''A gzipped-tar file'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''The desired file'
# shellcheck disable=SC2016
helpPlain='Usage: tarExtractPattern [ pattern ]'$'\n'''$'\n''    pattern  The file pattern to extract'$'\n'''$'\n''Platform agnostic tar extract with wildcards'$'\n'''$'\n''e.g. tar -xf '\''/file.json'\'' or tar -xf --wildcards '\''/file.json'\'' depending on OS'$'\n'''$'\n''tar command is not cross-platform so this differentiates between the GNU and BSD command line arguments.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''A gzipped-tar file'$'\n'''$'\n''Writes to stdout:'$'\n''The desired file'
documentationPath="documentation/source/tools/tar.md"
