#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/tar.sh"
argument="target - The tar.gz file to create"$'\n'"files - A list of files to include in the tar file"$'\n'""
base="tar.sh"
description="Platform agnostic tar cfz which ignores owner and attributes"$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (\`.tgz\` or \`.tar.gz\`) with user and group set to 0 and no extended attributes attached to the files."$'\n'""
file="bin/build/tools/tar.sh"
foundNames=([0]="short_description" [1]="argument")
rawComment="Platform agnostic tar cfz which ignores owner and attributes"$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (\`.tgz\` or \`.tar.gz\`) with user and group set to 0 and no extended attributes attached to the files."$'\n'"Short description: Platform agnostic tar create which keeps user and group as user 0"$'\n'"Argument: target - The tar.gz file to create"$'\n'"Argument: files - A list of files to include in the tar file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
short_description="Platform agnostic tar create which keeps user and group as user 0"$'\n'""
sourceFile="bin/build/tools/tar.sh"
sourceModified="1769063211"
summary="Platform agnostic tar cfz which ignores owner and attributes"
usage="tarCreate [ target ] [ files ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtarCreate'$'\e''[0m '$'\e''[[(blue)]m[ target ]'$'\e''[0m '$'\e''[[(blue)]m[ files ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtarget  '$'\e''[[(value)]mThe tar.gz file to create'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfiles   '$'\e''[[(value)]mA list of files to include in the tar file'$'\e''[[(reset)]m'$'\n'''$'\n''Platform agnostic tar cfz which ignores owner and attributes'$'\n'''$'\e''[[(code)]mtar'$'\e''[[(reset)]m command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file ('$'\e''[[(code)]m.tgz'$'\e''[[(reset)]m or '$'\e''[[(code)]m.tar.gz'$'\e''[[(reset)]m) with user and group set to 0 and no extended attributes attached to the files.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: tarCreate [ target ] [ files ]'$'\n'''$'\n''    target  The tar.gz file to create'$'\n''    files   A list of files to include in the tar file'$'\n'''$'\n''Platform agnostic tar cfz which ignores owner and attributes'$'\n''tar command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (.tgz or .tar.gz) with user and group set to 0 and no extended attributes attached to the files.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.448
