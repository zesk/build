#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/version.sh"
argument="none"
base="version.sh"
description="Take one or more versions and strip the leading \`v\`"$'\n'""
file="bin/build/tools/version.sh"
foundNames=([0]="stdin" [1]="stdout")
rawComment="Take one or more versions and strip the leading \`v\`"$'\n'"stdin: Versions containing a preceding \`v\` character (optionally)"$'\n'"stdout: Versions with the initial \`v\` (if it exists) removed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceModified="1769227649"
stdin="Versions containing a preceding \`v\` character (optionally)"$'\n'""
stdout="Versions with the initial \`v\` (if it exists) removed"$'\n'""
summary="Take one or more versions and strip the leading \`v\`"
usage="versionNoVee"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mversionNoVee'$'\e''[0m'$'\n'''$'\n''Take one or more versions and strip the leading '$'\e''[[(code)]mv'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Versions containing a preceding '$'\e''[[(code)]mv'$'\e''[[(reset)]m character (optionally)'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Versions with the initial '$'\e''[[(code)]mv'$'\e''[[(reset)]m (if it exists) removed'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: versionNoVee'$'\n'''$'\n''Take one or more versions and strip the leading v'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Versions containing a preceding v character (optionally)'$'\n'''$'\n''Writes to stdout:'$'\n''Versions with the initial v (if it exists) removed'$'\n'''
# elapsed 0.523
