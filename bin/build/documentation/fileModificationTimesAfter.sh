#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'directory - Directory. Required. Must exist - directory to list.\ntimestamp - PositiveInteger. Required. Timestamp to compare file timestamps with.\nfindArgs - Arguments. Optional. Optional additional arguments to modify the find query\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List files modified after a specific timestamp (inclusive)\n\nOutput is sorted from newest time to oldest time (reverse chronological).\n\n'
descriptionLineCount="4"
example=$'fileModificationTimesAfter "$myDir" "$yesterdayNoon" ! -path "*/.*/*"\n'
file="bin/build/tools/file.sh"
fn="fileModificationTimesAfter"
fnMarker="filemodificationtimesafter"
foundNames=([0]="argument" [1]="example" [2]="output")
line="170"
original="fileModificationTimesAfter"
output=$'1704312758 bin/build/deprecated.sh\n1705347087 bin/build/tools.sh\n1705442647 bin/build/build.json\n'
rawComment=$'List files modified after a specific timestamp (inclusive)\nOutput is sorted from newest time to oldest time (reverse chronological).\nArgument: directory - Directory. Required. Must exist - directory to list.\nArgument: timestamp - PositiveInteger. Required. Timestamp to compare file timestamps with.\nArgument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query\nExample: {fn} "$myDir" "$yesterdayNoon" ! -path "*/.*/*"\nOutput: 1704312758 bin/build/deprecated.sh\nOutput: 1705347087 bin/build/tools.sh\nOutput: 1705442647 bin/build/build.json\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="c688f25ccc836a3de5e08fcee0b11da564d05e7a"
sourceLine="170"
summary="List files modified after a specific timestamp (inclusive)"
summaryComputed="true"
usage="fileModificationTimesAfter directory timestamp [ findArgs ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModificationTimesAfter'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtimestamp'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ findArgs ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdirectory  '$'\e''[[(value)]mDirectory. Required. Must exist - directory to list.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtimestamp  '$'\e''[[(value)]mPositiveInteger. Required. Timestamp to compare file timestamps with.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfindArgs   '$'\e''[[(value)]mArguments. Optional. Optional additional arguments to modify the find query'$'\e''[[(reset)]m'$'\n'''$'\n''List files modified after a specific timestamp (inclusive)'$'\n'''$'\n''Output is sorted from newest time to oldest time (reverse chronological).'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''fileModificationTimesAfter "$myDir" "$yesterdayNoon" ! -path "'$'\e''[[(cyan)]m/.'$'\e''[[(reset)]m/'$'\e''[[(cyan)]m"'$'\e''[[(reset)]m'
# shellcheck disable=SC2016
helpPlain='Usage: fileModificationTimesAfter directory timestamp [ findArgs ]'$'\n'''$'\n''    directory  Directory. Required. Must exist - directory to list.'$'\n''    timestamp  PositiveInteger. Required. Timestamp to compare file timestamps with.'$'\n''    findArgs   Arguments. Optional. Optional additional arguments to modify the find query'$'\n'''$'\n''List files modified after a specific timestamp (inclusive)'$'\n'''$'\n''Output is sorted from newest time to oldest time (reverse chronological).'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''fileModificationTimesAfter "$myDir" "$yesterdayNoon" ! -path "/./"'
documentationPath="documentation/source/tools/file.md"
