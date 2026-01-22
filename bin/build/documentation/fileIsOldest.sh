#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="sourceFile - File. Required. File to check"$'\n'"targetFile ... - File. Optional. One or more files to compare. All must exist."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Check to see if the first file is the newest one"$'\n'""$'\n'"If \`sourceFile\` is modified AFTER ALL \`targetFile\`s, return \`0\`\`"$'\n'"Otherwise return \`1\`\`"$'\n'""$'\n'"Return Code: 1 - \`sourceFile\`, 'targetFile' does not exist, or"$'\n'"Return Code: 0 - All files exist and \`sourceFile\` is the oldest file"$'\n'""$'\n'""
file="bin/build/tools/file.sh"
fn="fileIsOldest"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1769063211"
summary="Check to see if the first file is the newest"
usage="fileIsOldest sourceFile [ targetFile ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileIsOldest[0m [38;2;255;255;0m[35;48;2;0;0;0msourceFile[0m[0m [94m[ targetFile ... ][0m [94m[ --help ][0m

    [31msourceFile      [1;97mFile. Required. File to check[0m
    [94mtargetFile ...  [1;97mFile. Optional. One or more files to compare. All must exist.[0m
    [94m--help          [1;97mFlag. Optional. Display this help.[0m

Check to see if the first file is the newest one

If [38;2;0;255;0;48;2;0;0;0msourceFile[0m is modified AFTER ALL [38;2;0;255;0;48;2;0;0;0mtargetFile[0ms, return [38;2;0;255;0;48;2;0;0;0m0[0m
Otherwise return [38;2;0;255;0;48;2;0;0;0m1[0m

Return Code: 1 - [38;2;0;255;0;48;2;0;0;0msourceFile[0m, '\''targetFile'\'' does not exist, or
Return Code: 0 - All files exist and [38;2;0;255;0;48;2;0;0;0msourceFile[0m is the oldest file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: fileIsOldest sourceFile [ targetFile ... ] [ --help ]

    sourceFile      File. Required. File to check
    targetFile ...  File. Optional. One or more files to compare. All must exist.
    --help          Flag. Optional. Display this help.

Check to see if the first file is the newest one

If sourceFile is modified AFTER ALL targetFiles, return 0
Otherwise return 1

Return Code: 1 - sourceFile, '\''targetFile'\'' does not exist, or
Return Code: 0 - All files exist and sourceFile is the oldest file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
