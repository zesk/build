#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/tar.sh"
argument="target - The tar.gz file to create"$'\n'"files - A list of files to include in the tar file"$'\n'""
base="tar.sh"
description="Platform agnostic tar cfz which ignores owner and attributes"$'\n'""$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (\`.tgz\` or \`.tar.gz\`) with user and group set to 0 and no extended attributes attached to the files."$'\n'"Short description: Platform agnostic tar create which keeps user and group as user 0"$'\n'""$'\n'""
file="bin/build/tools/tar.sh"
fn="tarCreate"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/tar.sh"
sourceModified="1768513812"
summary="Platform agnostic tar cfz which ignores owner and attributes"
usage="tarCreate [ target ] [ files ]"
