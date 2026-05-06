#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--clean - Flag. Optional. Clean directory of all files first."$'\n'"directory - Directory. Required. Directory to create extension lists."$'\n'"file0 ... - String. Optional. List of files to add to the extension list."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Generates a directory containing files with \`extension\` as the file names."$'\n'"All files passed to this are added to the \`@\` file, the \`!\` file is used for files without extensions."$'\n'"Extension parsing is done by removing the final dot from the filename:"$'\n'"- \`foo.sh\` -> \`\"sh\"\`"$'\n'"- \`foo.tar.gz\` -> \`\"gz\"\`"$'\n'"- \`foo.\` -> \`\"!\"\`\`"$'\n'"- \`foo-bar\` -> \`\"!\"\`\`"$'\n'""$'\n'""
descriptionLineCount="8"
file="bin/build/tools/platform.sh"
fn="fileExtensionLists"
fnMarker="fileextensionlists"
foundNames=([0]="argument" [1]="input")
input="Takes a list of files, one per line"$'\n'""
line="336"
rawComment="Argument: --clean - Flag. Optional. Clean directory of all files first."$'\n'"Argument: directory - Directory. Required. Directory to create extension lists."$'\n'"Argument: file0 ... - String. Optional. List of files to add to the extension list."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Input: Takes a list of files, one per line"$'\n'"Generates a directory containing files with \`extension\` as the file names."$'\n'"All files passed to this are added to the \`@\` file, the \`!\` file is used for files without extensions."$'\n'"Extension parsing is done by removing the final dot from the filename:"$'\n'"- \`foo.sh\` -> \`\"sh\"\`"$'\n'"- \`foo.tar.gz\` -> \`\"gz\"\`"$'\n'"- \`foo.\` -> \`\"!\"\`\`"$'\n'"- \`foo-bar\` -> \`\"!\"\`\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="097e41ee15602cdab3bc28d8a420362c8b93b425"
sourceLine="336"
summary="Generates a directory containing files with \`extension\` as the file"
summaryComputed="true"
usage="fileExtensionLists [ --clean ] directory [ file0 ... ] [ --help ]"
