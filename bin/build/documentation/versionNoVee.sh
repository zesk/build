#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="none"
base="version.sh"
description="Take one or more versions and strip the leading \`v\`"$'\n'""
file="bin/build/tools/version.sh"
foundNames=([0]="stdin" [1]="stdout")
rawComment="Take one or more versions and strip the leading \`v\`"$'\n'"stdin: Versions containing a preceding \`v\` character (optionally)"$'\n'"stdout: Versions with the initial \`v\` (if it exists) removed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceHash="d77afda1e8e2f6fc82e83a8aab8cb537d29f8c0e"
stdin="Versions containing a preceding \`v\` character (optionally)"$'\n'""
stdout="Versions with the initial \`v\` (if it exists) removed"$'\n'""
summary="Take one or more versions and strip the leading \`v\`"
usage="versionNoVee"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mversionNoVee'$'\e''[0m'$'\n'''$'\n''Take one or more versions and strip the leading '$'\e''[[(code)]mv'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Versions containing a preceding '$'\e''[[(code)]mv'$'\e''[[(reset)]m character (optionally)'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Versions with the initial '$'\e''[[(code)]mv'$'\e''[[(reset)]m (if it exists) removed'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mversionNoVee'$'\n'''$'\n''Take one or more versions and strip the leading [[(code)]mv[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m1[[(reset)]m - Environment error'$'\n''- [[(code)]m2[[(reset)]m - Argument error'$'\n'''$'\n''Reads from [[(code)]mstdin[[(reset)]m:'$'\n''Versions containing a preceding [[(code)]mv[[(reset)]m character (optionally)'$'\n'''$'\n''Writes to [[(code)]mstdout[[(reset)]m:'$'\n''Versions with the initial [[(code)]mv[[(reset)]m (if it exists) removed'$'\n'''
# elapsed 1.905
