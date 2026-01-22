#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="--clean - Flag. Optional. Clean directory of all files first."$'\n'"directory - Directory. Required. Directory to create extension lists."$'\n'"file0 ... - String. Optional. List of files to add to the extension list."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
description="Generates a directory containing files with \`extension\` as the file names."$'\n'"All files passed to this are added to the \`@\` file, the \`!\` file is used for files without extensions."$'\n'"Extension parsing is done by removing the final dot from the filename:"$'\n'"- \`foo.sh\` -> \`\"sh\"\`"$'\n'"- \`foo.tar.gz\` -> \`\"gz\"\`"$'\n'"- \`foo.\` -> \`\"!\"\`\`"$'\n'"- \`foo-bar\` -> \`\"!\"\`\`"$'\n'""$'\n'""
file="bin/build/tools/platform.sh"
fn="extensionLists"
foundNames=""
input="Takes a list of files, one per line"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceModified="1768873865"
summary="Generates a directory containing files with \`extension\` as the file"
usage="extensionLists [ --clean ] directory [ file0 ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mextensionLists[0m [94m[ --clean ][0m [38;2;255;255;0m[35;48;2;0;0;0mdirectory[0m[0m [94m[ file0 ... ][0m [94m[ --help ][0m

    [94m--clean    [1;97mFlag. Optional. Clean directory of all files first.[0m
    [31mdirectory  [1;97mDirectory. Required. Directory to create extension lists.[0m
    [94mfile0 ...  [1;97mString. Optional. List of files to add to the extension list.[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

Generates a directory containing files with [38;2;0;255;0;48;2;0;0;0mextension[0m as the file names.
All files passed to this are added to the [38;2;0;255;0;48;2;0;0;0m@[0m file, the [38;2;0;255;0;48;2;0;0;0m![0m file is used for files without extensions.
Extension parsing is done by removing the final dot from the filename:
- [38;2;0;255;0;48;2;0;0;0mfoo.sh[0m -> [38;2;0;255;0;48;2;0;0;0m"sh"[0m
- [38;2;0;255;0;48;2;0;0;0mfoo.tar.gz[0m -> [38;2;0;255;0;48;2;0;0;0m"gz"[0m
- [38;2;0;255;0;48;2;0;0;0mfoo.[0m -> [38;2;0;255;0;48;2;0;0;0m"!"[0m
- [38;2;0;255;0;48;2;0;0;0mfoo-bar[0m -> [38;2;0;255;0;48;2;0;0;0m"!"[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: extensionLists [ --clean ] directory [ file0 ... ] [ --help ]

    --clean    Flag. Optional. Clean directory of all files first.
    directory  Directory. Required. Directory to create extension lists.
    file0 ...  String. Optional. List of files to add to the extension list.
    --help     Flag. Optional. Display this help.

Generates a directory containing files with extension as the file names.
All files passed to this are added to the @ file, the ! file is used for files without extensions.
Extension parsing is done by removing the final dot from the filename:
- foo.sh -> "sh"
- foo.tar.gz -> "gz"
- foo. -> "!"
- foo-bar -> "!"

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
