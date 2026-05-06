#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="target - FileDirectory. Required.The tar.gz file to create."$'\n'"files - File. Optional. A list of files to include in the tar file."$'\n'""
base="tar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Platform agnostic tar cfz which ignores owner and attributes"$'\n'""$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (\`.tgz\` or \`.tar.gz\`) with user and group set to 0 and no extended attributes attached to the files."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/tar.sh"
fn="tarCreate"
fnMarker="tarcreate"
foundNames=([0]="short_description" [1]="argument" [2]="stdin")
line="66"
rawComment="Platform agnostic tar cfz which ignores owner and attributes"$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (\`.tgz\` or \`.tar.gz\`) with user and group set to 0 and no extended attributes attached to the files."$'\n'"Short description: Platform agnostic tar create which keeps user and group as user 0"$'\n'"Argument: target - FileDirectory. Required.The tar.gz file to create."$'\n'"Argument: files - File. Optional. A list of files to include in the tar file."$'\n'"stdin: A list of files to include in the tar file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
short_description="Platform agnostic tar create which keeps user and group as user 0"$'\n'""
sourceFile="bin/build/tools/tar.sh"
sourceHash="7a8a92654406b6853c275aeac20e6584694326aa"
sourceLine="66"
stdin="A list of files to include in the tar file"$'\n'""
summary="Platform agnostic tar cfz which ignores owner and attributes"
summaryComputed="true"
usage="tarCreate target [ files ]"
