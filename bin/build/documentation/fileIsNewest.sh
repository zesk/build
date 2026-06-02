#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-01
# shellcheck disable=SC2034
argument=$'--ignore - Flag. Optional. Ignore files which do not exist.\nsourceFile - File. Required. File to check\ntargetFile ... - File. Optional. One or more files to compare. All must exist.\n--help - Flag. Optional. Display this help.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Check to see if the first file is the newest one\n\nIf `sourceFile` is modified AFTER ALL `targetFile`s, return `0``\nOtherwise return `1``\n\n'
descriptionLineCount="5"
file="bin/build/tools/file.sh"
fn="fileIsNewest"
fnMarker="fileisnewest"
foundNames=([0]="argument" [1]="return_code")
line="268"
rawComment=$'Check to see if the first file is the newest one\nIf `sourceFile` is modified AFTER ALL `targetFile`s, return `0``\nOtherwise return `1``\nArgument: --ignore - Flag. Optional. Ignore files which do not exist.\nArgument: sourceFile - File. Required. File to check\nArgument: targetFile ... - File. Optional. One or more files to compare. All must exist.\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 1 - `sourceFile`, \'targetFile\' does not exist, or\nReturn Code: 0 - All files exist and `sourceFile` is the oldest file\n\n'
return_code=$'1 - `sourceFile`, \'targetFile\' does not exist, or\n0 - All files exist and `sourceFile` is the oldest file\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="1ddfd7452bcc3ae87f5e31f996487d77938a316d"
sourceLine="268"
summary="Check to see if the first file is the newest"
summaryComputed="true"
usage="fileIsNewest [ --ignore ] sourceFile [ targetFile ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileIsNewest'$'\e''[0m '$'\e''[[(blue)]m[ --ignore ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msourceFile'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ targetFile ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--ignore        '$'\e''[[(value)]mFlag. Optional. Ignore files which do not exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msourceFile      '$'\e''[[(value)]mFile. Required. File to check'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtargetFile ...  '$'\e''[[(value)]mFile. Optional. One or more files to compare. All must exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help          '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Check to see if the first file is the newest one'$'\n'''$'\n''If '$'\e''[[(code)]msourceFile'$'\e''[[(reset)]m is modified AFTER ALL '$'\e''[[(code)]mtargetFile'$'\e''[[(reset)]ms, return '$'\e''[[(code)]m0'$'\e''[[(reset)]m'$'\n''Otherwise return '$'\e''[[(code)]m1'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - '$'\e''[[(code)]msourceFile'$'\e''[[(reset)]m, '\''targetFile'\'' does not exist, or'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All files exist and '$'\e''[[(code)]msourceFile'$'\e''[[(reset)]m is the oldest file'
# shellcheck disable=SC2016
helpPlain='Usage: fileIsNewest [ --ignore ] sourceFile [ targetFile ... ] [ --help ]'$'\n'''$'\n''    --ignore        Flag. Optional. Ignore files which do not exist.'$'\n''    sourceFile      File. Required. File to check'$'\n''    targetFile ...  File. Optional. One or more files to compare. All must exist.'$'\n''    --help          Flag. Optional. Display this help.'$'\n'''$'\n''Check to see if the first file is the newest one'$'\n'''$'\n''If sourceFile is modified AFTER ALL targetFiles, return 0'$'\n''Otherwise return 1'$'\n'''$'\n''Return codes:'$'\n''- 1 - sourceFile, '\''targetFile'\'' does not exist, or'$'\n''- 0 - All files exist and sourceFile is the oldest file'
documentationPath="documentation/source/tools/file.md"
