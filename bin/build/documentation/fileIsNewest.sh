#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Check to see if the first file is the newest one"$'\n'"If \`sourceFile\` is modified AFTER ALL \`targetFile\`s, return \`0\`\`"$'\n'"Otherwise return \`1\`\`"$'\n'"Argument: sourceFile - File. Required. File to check"$'\n'"Argument: targetFile ... - File. Optional. One or more files to compare. All must exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - \`sourceFile\`, 'targetFile' does not exist, or"$'\n'"Return Code: 0 - All files exist and \`sourceFile\` is the oldest file"$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Check to see if the first file is the newest one"$'\n'"If \`sourceFile\` is modified AFTER ALL \`targetFile\`s, return \`0\`\`"$'\n'"Otherwise return \`1\`\`"$'\n'"Argument: sourceFile - File. Required. File to check"$'\n'"Argument: targetFile ... - File. Optional. One or more files to compare. All must exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - \`sourceFile\`, 'targetFile' does not exist, or"$'\n'"Return Code: 0 - All files exist and \`sourceFile\` is the oldest file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Check to see if the first file is the newest"
usage="fileIsNewest"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileIsNewest'$'\e''[0m'$'\n'''$'\n''Check to see if the first file is the newest one'$'\n''If '$'\e''[[(code)]msourceFile'$'\e''[[(reset)]m is modified AFTER ALL '$'\e''[[(code)]mtargetFile'$'\e''[[(reset)]ms, return '$'\e''[[(code)]m0'$'\e''[[(reset)]m'$'\n''Otherwise return '$'\e''[[(code)]m1'$'\e''[[(reset)]m'$'\n''Argument: sourceFile - File. Required. File to check'$'\n''Argument: targetFile ... - File. Optional. One or more files to compare. All must exist.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 1 - '$'\e''[[(code)]msourceFile'$'\e''[[(reset)]m, '\''targetFile'\'' does not exist, or'$'\n''Return Code: 0 - All files exist and '$'\e''[[(code)]msourceFile'$'\e''[[(reset)]m is the oldest file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileIsNewest'$'\n'''$'\n''Check to see if the first file is the newest one'$'\n''If sourceFile is modified AFTER ALL targetFiles, return 0'$'\n''Otherwise return 1'$'\n''Argument: sourceFile - File. Required. File to check'$'\n''Argument: targetFile ... - File. Optional. One or more files to compare. All must exist.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 1 - sourceFile, '\''targetFile'\'' does not exist, or'$'\n''Return Code: 0 - All files exist and sourceFile is the oldest file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.509
