#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="tar.sh"
description="Platform agnostic tar cfz which ignores owner and attributes"$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (\`.tgz\` or \`.tar.gz\`) with user and group set to 0 and no extended attributes attached to the files."$'\n'"Short description: Platform agnostic tar create which keeps user and group as user 0"$'\n'"Argument: target - The tar.gz file to create"$'\n'"Argument: files - A list of files to include in the tar file"$'\n'""
file="bin/build/tools/tar.sh"
foundNames=()
rawComment="Platform agnostic tar cfz which ignores owner and attributes"$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (\`.tgz\` or \`.tar.gz\`) with user and group set to 0 and no extended attributes attached to the files."$'\n'"Short description: Platform agnostic tar create which keeps user and group as user 0"$'\n'"Argument: target - The tar.gz file to create"$'\n'"Argument: files - A list of files to include in the tar file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/tar.sh"
sourceHash="1bb7374d4744d22cae253d6b48cc4a9cacc38d55"
summary="Platform agnostic tar cfz which ignores owner and attributes"
usage="tarCreate"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtarCreate'$'\e''[0m'$'\n'''$'\n''Platform agnostic tar cfz which ignores owner and attributes'$'\n'''$'\e''[[(code)]mtar'$'\e''[[(reset)]m command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file ('$'\e''[[(code)]m.tgz'$'\e''[[(reset)]m or '$'\e''[[(code)]m.tar.gz'$'\e''[[(reset)]m) with user and group set to 0 and no extended attributes attached to the files.'$'\n''Short description: Platform agnostic tar create which keeps user and group as user 0'$'\n''Argument: target - The tar.gz file to create'$'\n''Argument: files - A list of files to include in the tar file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: tarCreate'$'\n'''$'\n''Platform agnostic tar cfz which ignores owner and attributes'$'\n''tar command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (.tgz or .tar.gz) with user and group set to 0 and no extended attributes attached to the files.'$'\n''Short description: Platform agnostic tar create which keeps user and group as user 0'$'\n''Argument: target - The tar.gz file to create'$'\n''Argument: files - A list of files to include in the tar file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.759
