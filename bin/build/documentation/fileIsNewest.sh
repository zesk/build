#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-09
# shellcheck disable=SC2034
argument="sourceFile - File. Required. File to check"$'\n'"targetFile ... - File. Optional. One or more files to compare. All must exist."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Check to see if the first file is the newest one"$'\n'"If \`sourceFile\` is modified AFTER ALL \`targetFile\`s, return \`0\`\`"$'\n'"Otherwise return \`1\`\`"$'\n'""
file="bin/build/tools/file.sh"
fn="fileIsNewest"
foundNames=([0]="argument" [1]="return_code")
rawComment="Check to see if the first file is the newest one"$'\n'"If \`sourceFile\` is modified AFTER ALL \`targetFile\`s, return \`0\`\`"$'\n'"Otherwise return \`1\`\`"$'\n'"Argument: sourceFile - File. Required. File to check"$'\n'"Argument: targetFile ... - File. Optional. One or more files to compare. All must exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - \`sourceFile\`, 'targetFile' does not exist, or"$'\n'"Return Code: 0 - All files exist and \`sourceFile\` is the oldest file"$'\n'""$'\n'""
return_code="1 - \`sourceFile\`, 'targetFile' does not exist, or"$'\n'"0 - All files exist and \`sourceFile\` is the oldest file"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="91d537b691b9a05e675b0b8e8fc9b5d80f144523"
summary="Check to see if the first file is the newest"
summaryComputed="true"
usage="fileIsNewest sourceFile [ targetFile ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='➡️ "__usageDocumentCached" "_usageDocument" "/Users/kent/marketacumen/build" "fileIsNewest" "0"'$'\n'''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileIsNewest'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msourceFile'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ targetFile ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]msourceFile      '$'\e''[[(value)]mFile. Required. File to check'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtargetFile ...  '$'\e''[[(value)]mFile. Optional. One or more files to compare. All must exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help          '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Check to see if the first file is the newest one'$'\n''If '$'\e''[[(code)]msourceFile'$'\e''[[(reset)]m is modified AFTER ALL '$'\e''[[(code)]mtargetFile'$'\e''[[(reset)]ms, return '$'\e''[[(code)]m0'$'\e''[[(reset)]m'$'\n''Otherwise return '$'\e''[[(code)]m1'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - '$'\e''[[(code)]msourceFile'$'\e''[[(reset)]m, '\''targetFile'\'' does not exist, or'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All files exist and '$'\e''[[(code)]msourceFile'$'\e''[[(reset)]m is the oldest file'$'\n'''
# shellcheck disable=SC2016
helpPlain='➡️ "__usageDocumentCached" "_usageDocument" "/Users/kent/marketacumen/build" "fileIsNewest" "0"'$'\n''Usage: fileIsNewest sourceFile [ targetFile ... ] [ --help ]'$'\n'''$'\n''    sourceFile      File. Required. File to check'$'\n''    targetFile ...  File. Optional. One or more files to compare. All must exist.'$'\n''    --help          Flag. Optional. Display this help.'$'\n'''$'\n''Check to see if the first file is the newest one'$'\n''If sourceFile is modified AFTER ALL targetFiles, return 0'$'\n''Otherwise return 1'$'\n'''$'\n''Return codes:'$'\n''- 1 - sourceFile, '\''targetFile'\'' does not exist, or'$'\n''- 0 - All files exist and sourceFile is the oldest file'$'\n'''
