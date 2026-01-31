#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="tar.sh"
description="Platform agnostic tar extract with wildcards"$'\n'"e.g. \`tar -xf '*/file.json'\` or \`tar -xf --wildcards '*/file.json'\` depending on OS"$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments."$'\n'"Short description: Platform agnostic tar extract"$'\n'"Argument: pattern - The file pattern to extract"$'\n'"stdin: A gzipped-tar file"$'\n'"stdout: The desired file"$'\n'""
file="bin/build/tools/tar.sh"
foundNames=()
rawComment="Platform agnostic tar extract with wildcards"$'\n'"e.g. \`tar -xf '*/file.json'\` or \`tar -xf --wildcards '*/file.json'\` depending on OS"$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments."$'\n'"Short description: Platform agnostic tar extract"$'\n'"Argument: pattern - The file pattern to extract"$'\n'"stdin: A gzipped-tar file"$'\n'"stdout: The desired file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/tar.sh"
sourceHash="1bb7374d4744d22cae253d6b48cc4a9cacc38d55"
summary="Platform agnostic tar extract with wildcards"
usage="tarExtractPattern"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtarExtractPattern'$'\e''[0m'$'\n'''$'\n''Platform agnostic tar extract with wildcards'$'\n''e.g. '$'\e''[[(code)]mtar -xf '\'''$'\e''[[(cyan)]m/file.json'\'''$'\e''[[(reset)]m or '$'\e''[[(code)]mtar -xf --wildcards '\'''$'\e''[[(reset)]m/file.json'\'''$'\e''[[(reset)]m depending on OS'$'\n'''$'\e''[[(code)]mtar'$'\e''[[(reset)]m command is not cross-platform so this differentiates between the GNU and BSD command line arguments.'$'\n''Short description: Platform agnostic tar extract'$'\n''Argument: pattern - The file pattern to extract'$'\n''stdin: A gzipped-tar file'$'\n''stdout: The desired file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: tarExtractPattern'$'\n'''$'\n''Platform agnostic tar extract with wildcards'$'\n''e.g. tar -xf '\''/file.json'\'' or tar -xf --wildcards '\''/file.json'\'' depending on OS'$'\n''tar command is not cross-platform so this differentiates between the GNU and BSD command line arguments.'$'\n''Short description: Platform agnostic tar extract'$'\n''Argument: pattern - The file pattern to extract'$'\n''stdin: A gzipped-tar file'$'\n''stdout: The desired file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.502
