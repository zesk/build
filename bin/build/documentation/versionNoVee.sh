#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="version.sh"
description="Take one or more versions and strip the leading \`v\`"$'\n'"stdin: Versions containing a preceding \`v\` character (optionally)"$'\n'"stdout: Versions with the initial \`v\` (if it exists) removed"$'\n'""
file="bin/build/tools/version.sh"
foundNames=()
rawComment="Take one or more versions and strip the leading \`v\`"$'\n'"stdin: Versions containing a preceding \`v\` character (optionally)"$'\n'"stdout: Versions with the initial \`v\` (if it exists) removed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceHash="d77afda1e8e2f6fc82e83a8aab8cb537d29f8c0e"
summary="Take one or more versions and strip the leading \`v\`"
usage="versionNoVee"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mversionNoVee'$'\e''[0m'$'\n'''$'\n''Take one or more versions and strip the leading '$'\e''[[(code)]mv'$'\e''[[(reset)]m'$'\n''stdin: Versions containing a preceding '$'\e''[[(code)]mv'$'\e''[[(reset)]m character (optionally)'$'\n''stdout: Versions with the initial '$'\e''[[(code)]mv'$'\e''[[(reset)]m (if it exists) removed'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: versionNoVee'$'\n'''$'\n''Take one or more versions and strip the leading v'$'\n''stdin: Versions containing a preceding v character (optionally)'$'\n''stdout: Versions with the initial v (if it exists) removed'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.473
