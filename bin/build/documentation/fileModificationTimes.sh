#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'directory - Directory. Required. Must exists - directory to list.\nfindArgs - Arguments. Optional. Optional additional arguments to modify the find query\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Lists files in a directory recursively along with their modification time in seconds.\n\nOutput is unsorted.\n\n'
descriptionLineCount="4"
example=$'fileModificationTimes $myDir ! -path "*/.*/*"\n'
file="bin/build/tools/file.sh"
fn="fileModificationTimes"
fnMarker="filemodificationtimes"
foundNames=([0]="argument" [1]="example" [2]="output")
line="225"
output=$'1705347087 bin/build/tools.sh\n1704312758 bin/build/deprecated.sh\n1705442647 bin/build/build.json\n'
rawComment=$'Lists files in a directory recursively along with their modification time in seconds.\nOutput is unsorted.\nArgument: directory - Directory. Required. Must exists - directory to list.\nArgument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query\nExample: {fn} $myDir ! -path "*/.*/*"\nOutput: 1705347087 bin/build/tools.sh\nOutput: 1704312758 bin/build/deprecated.sh\nOutput: 1705442647 bin/build/build.json\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="c688f25ccc836a3de5e08fcee0b11da564d05e7a"
sourceLine="225"
summary="Lists files in a directory recursively along with their modification"
summaryComputed="true"
usage="fileModificationTimes directory [ findArgs ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModificationTimes'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ findArgs ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdirectory  '$'\e''[[(value)]mDirectory. Required. Must exists - directory to list.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfindArgs   '$'\e''[[(value)]mArguments. Optional. Optional additional arguments to modify the find query'$'\e''[[(reset)]m'$'\n'''$'\n''Lists files in a directory recursively along with their modification time in seconds.'$'\n'''$'\n''Output is unsorted.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''fileModificationTimes $myDir ! -path "'$'\e''[[(cyan)]m/.'$'\e''[[(reset)]m/'$'\e''[[(cyan)]m"'$'\e''[[(reset)]m'
# shellcheck disable=SC2016
helpPlain='Usage: fileModificationTimes directory [ findArgs ]'$'\n'''$'\n''    directory  Directory. Required. Must exists - directory to list.'$'\n''    findArgs   Arguments. Optional. Optional additional arguments to modify the find query'$'\n'''$'\n''Lists files in a directory recursively along with their modification time in seconds.'$'\n'''$'\n''Output is unsorted.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''fileModificationTimes $myDir ! -path "/./"'
documentationPath="documentation/source/tools/file.md"
