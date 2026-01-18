#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="--clean - Flag. Optional.Clean directory of all files first."$'\n'"directory - Directory. Required. Directory to create extension lists."$'\n'"file0 - Optional. List of files to add to the extension list."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="platform.sh"
description="Generates a directory containing files with \`extension\` as the file names."$'\n'"All files passed to this are added to the \`@\` file, the \`!\` file is used for files without extensions."$'\n'"Extension parsing is done by removing the final dot from the filename:"$'\n'"- \`foo.sh\` -> \`\"sh\"\`"$'\n'"- \`foo.tar.gz\` -> \`\"gz\"\`"$'\n'"- \`foo.\` -> \`\"!\"\`\`"$'\n'"- \`foo-bar\` -> \`\"!\"\`\`"$'\n'""$'\n'""
file="bin/build/tools/platform.sh"
fn="extensionLists"
foundNames=([0]="argument" [1]="input")
input="Takes a list of files, one per line"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/platform.sh"
sourceModified="1768695708"
summary="Generates a directory containing files with \`extension\` as the file"
usage="extensionLists [ --clean ] directory [ file0 ] [ --help ]"
