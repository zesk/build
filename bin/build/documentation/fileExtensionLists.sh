#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--clean - Flag. Optional. Clean directory of all files first."$'\n'"directory - Directory. Required. Directory to create extension lists."$'\n'"file0 ... - String. Optional. List of files to add to the extension list."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
description="Generates a directory containing files with \`extension\` as the file names."$'\n'"All files passed to this are added to the \`@\` file, the \`!\` file is used for files without extensions."$'\n'"Extension parsing is done by removing the final dot from the filename:"$'\n'"- \`foo.sh\` -> \`\"sh\"\`"$'\n'"- \`foo.tar.gz\` -> \`\"gz\"\`"$'\n'"- \`foo.\` -> \`\"!\"\`\`"$'\n'"- \`foo-bar\` -> \`\"!\"\`\`"$'\n'""
file="bin/build/tools/platform.sh"
fn="fileExtensionLists"
foundNames=([0]="argument" [1]="input")
input="Takes a list of files, one per line"$'\n'""
line="336"
lowerFn="fileextensionlists"
rawComment="Argument: --clean - Flag. Optional. Clean directory of all files first."$'\n'"Argument: directory - Directory. Required. Directory to create extension lists."$'\n'"Argument: file0 ... - String. Optional. List of files to add to the extension list."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Input: Takes a list of files, one per line"$'\n'"Generates a directory containing files with \`extension\` as the file names."$'\n'"All files passed to this are added to the \`@\` file, the \`!\` file is used for files without extensions."$'\n'"Extension parsing is done by removing the final dot from the filename:"$'\n'"- \`foo.sh\` -> \`\"sh\"\`"$'\n'"- \`foo.tar.gz\` -> \`\"gz\"\`"$'\n'"- \`foo.\` -> \`\"!\"\`\`"$'\n'"- \`foo-bar\` -> \`\"!\"\`\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="097e41ee15602cdab3bc28d8a420362c8b93b425"
sourceLine="336"
summary="Generates a directory containing files with \`extension\` as the file"
summaryComputed="true"
usage="fileExtensionLists [ --clean ] directory [ file0 ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileExtensionLists'$'\e''[0m '$'\e''[[(blue)]m[ --clean ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ file0 ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--clean    '$'\e''[[(value)]mFlag. Optional. Clean directory of all files first.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mdirectory  '$'\e''[[(value)]mDirectory. Required. Directory to create extension lists.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfile0 ...  '$'\e''[[(value)]mString. Optional. List of files to add to the extension list.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Generates a directory containing files with '$'\e''[[(code)]mextension'$'\e''[[(reset)]m as the file names.'$'\n''All files passed to this are added to the '$'\e''[[(code)]m@'$'\e''[[(reset)]m file, the '$'\e''[[(code)]m!'$'\e''[[(reset)]m file is used for files without extensions.'$'\n''Extension parsing is done by removing the final dot from the filename:'$'\n''- '$'\e''[[(code)]mfoo.sh'$'\e''[[(reset)]m -> '$'\e''[[(code)]m"sh"'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mfoo.tar.gz'$'\e''[[(reset)]m -> '$'\e''[[(code)]m"gz"'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mfoo.'$'\e''[[(reset)]m -> '$'\e''[[(code)]m"!"'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mfoo-bar'$'\e''[[(reset)]m -> '$'\e''[[(code)]m"!"'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileExtensionLists [ --clean ] directory [ file0 ... ] [ --help ]'$'\n'''$'\n''    --clean    Flag. Optional. Clean directory of all files first.'$'\n''    directory  Directory. Required. Directory to create extension lists.'$'\n''    file0 ...  String. Optional. List of files to add to the extension list.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Generates a directory containing files with extension as the file names.'$'\n''All files passed to this are added to the @ file, the ! file is used for files without extensions.'$'\n''Extension parsing is done by removing the final dot from the filename:'$'\n''- foo.sh -> "sh"'$'\n''- foo.tar.gz -> "gz"'$'\n''- foo. -> "!"'$'\n''- foo-bar -> "!"'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/utilities.md"
