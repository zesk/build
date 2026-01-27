#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/tar.sh"
argument="pattern - The file pattern to extract"$'\n'""
base="tar.sh"
description="Platform agnostic tar extract with wildcards"$'\n'"e.g. \`tar -xf '*/file.json'\` or \`tar -xf --wildcards '*/file.json'\` depending on OS"$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments."$'\n'""
file="bin/build/tools/tar.sh"
foundNames=([0]="short_description" [1]="argument" [2]="stdin" [3]="stdout")
rawComment="Platform agnostic tar extract with wildcards"$'\n'"e.g. \`tar -xf '*/file.json'\` or \`tar -xf --wildcards '*/file.json'\` depending on OS"$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments."$'\n'"Short description: Platform agnostic tar extract"$'\n'"Argument: pattern - The file pattern to extract"$'\n'"stdin: A gzipped-tar file"$'\n'"stdout: The desired file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
short_description="Platform agnostic tar extract"$'\n'""
sourceFile="bin/build/tools/tar.sh"
sourceModified="1769063211"
stdin="A gzipped-tar file"$'\n'""
stdout="The desired file"$'\n'""
summary="Platform agnostic tar extract with wildcards"
usage="tarExtractPattern [ pattern ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtarExtractPattern'$'\e''[0m '$'\e''[[(blue)]m[ pattern ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpattern  '$'\e''[[(value)]mThe file pattern to extract'$'\e''[[(reset)]m'$'\n'''$'\n''Platform agnostic tar extract with wildcards'$'\n''e.g. '$'\e''[[(code)]mtar -xf '\'''$'\e''[[(cyan)]m/file.json'\'''$'\e''[[(reset)]m or '$'\e''[[(code)]mtar -xf --wildcards '\'''$'\e''[[(reset)]m/file.json'\'''$'\e''[[(reset)]m depending on OS'$'\n'''$'\e''[[(code)]mtar'$'\e''[[(reset)]m command is not cross-platform so this differentiates between the GNU and BSD command line arguments.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''A gzipped-tar file'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''The desired file'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: tarExtractPattern [ pattern ]'$'\n'''$'\n''    pattern  The file pattern to extract'$'\n'''$'\n''Platform agnostic tar extract with wildcards'$'\n''e.g. tar -xf '\''/file.json'\'' or tar -xf --wildcards '\''/file.json'\'' depending on OS'$'\n''tar command is not cross-platform so this differentiates between the GNU and BSD command line arguments.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''A gzipped-tar file'$'\n'''$'\n''Writes to stdout:'$'\n''The desired file'$'\n'''
# elapsed 0.596
