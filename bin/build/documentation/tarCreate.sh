#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="target - FileDirectory. Required.The tar.gz file to create."$'\n'"files - File. Optional. A list of files to include in the tar file."$'\n'""
base="tar.sh"
description="Platform agnostic tar cfz which ignores owner and attributes"$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (\`.tgz\` or \`.tar.gz\`) with user and group set to 0 and no extended attributes attached to the files."$'\n'""
file="bin/build/tools/tar.sh"
fn="tarCreate"
foundNames=([0]="short_description" [1]="argument" [2]="stdin")
rawComment="Platform agnostic tar cfz which ignores owner and attributes"$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (\`.tgz\` or \`.tar.gz\`) with user and group set to 0 and no extended attributes attached to the files."$'\n'"Short description: Platform agnostic tar create which keeps user and group as user 0"$'\n'"Argument: target - FileDirectory. Required.The tar.gz file to create."$'\n'"Argument: files - File. Optional. A list of files to include in the tar file."$'\n'"stdin: A list of files to include in the tar file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
short_description="Platform agnostic tar create which keeps user and group as user 0"$'\n'""
sourceFile="bin/build/tools/tar.sh"
sourceHash="653b08cc1c06dc46314ed431523376cc1c8a11d9"
stdin="A list of files to include in the tar file"$'\n'""
summary="Platform agnostic tar cfz which ignores owner and attributes"
summaryComputed="true"
usage="tarCreate target [ files ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtarCreate'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtarget'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ files ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtarget  '$'\e''[[(value)]mFileDirectory. Required.The tar.gz file to create.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfiles   '$'\e''[[(value)]mFile. Optional. A list of files to include in the tar file.'$'\e''[[(reset)]m'$'\n'''$'\n''Platform agnostic tar cfz which ignores owner and attributes'$'\n'''$'\e''[[(code)]mtar'$'\e''[[(reset)]m command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file ('$'\e''[[(code)]m.tgz'$'\e''[[(reset)]m or '$'\e''[[(code)]m.tar.gz'$'\e''[[(reset)]m) with user and group set to 0 and no extended attributes attached to the files.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''A list of files to include in the tar file'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: tarCreate target [ files ]'$'\n'''$'\n''    target  FileDirectory. Required.The tar.gz file to create.'$'\n''    files   File. Optional. A list of files to include in the tar file.'$'\n'''$'\n''Platform agnostic tar cfz which ignores owner and attributes'$'\n''tar command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (.tgz or .tar.gz) with user and group set to 0 and no extended attributes attached to the files.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''A list of files to include in the tar file'$'\n'''
