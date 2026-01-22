#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="directoryPath ... - One or more directories to create"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--mode fileMode - String. Optional. Enforce the directory mode for \`mkdir --mode\` and \`chmod\`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to \`-\` to reset to no value."$'\n'"--owner ownerName - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to \`-\` to reset to no value."$'\n'""
base="directory.sh"
description="Given a list of directories, ensure they exist and create them if they do not."$'\n'""$'\n'""
example="    directoryRequire \"\$cachePath\""$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryRequire"
foundNames=""
requires="throwArgument usageArgumentFunction usageArgumentString decorate catchEnvironment dirname"$'\n'"chmod chown"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceModified="1768756695"
summary="Given a list of directories, ensure they exist and create"
usage="directoryRequire [ directoryPath ... ] [ --help ] [ --mode fileMode ] [ --owner ownerName ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdirectoryRequire[0m [94m[ directoryPath ... ][0m [94m[ --help ][0m [94m[ --mode fileMode ][0m [94m[ --owner ownerName ][0m

    [94mdirectoryPath ...  [1;97mOne or more directories to create[0m
    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--mode fileMode    [1;97mString. Optional. Enforce the directory mode for [38;2;0;255;0;48;2;0;0;0mmkdir --mode[0m and [38;2;0;255;0;48;2;0;0;0mchmod[0m. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to [38;2;0;255;0;48;2;0;0;0m-[0m to reset to no value.[0m
    [94m--owner ownerName  [1;97mString. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to [38;2;0;255;0;48;2;0;0;0m-[0m to reset to no value.[0m

Given a list of directories, ensure they exist and create them if they do not.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    directoryRequire "$cachePath"
'
# shellcheck disable=SC2016
helpPlain='Usage: directoryRequire [ directoryPath ... ] [ --help ] [ --mode fileMode ] [ --owner ownerName ]

    directoryPath ...  One or more directories to create
    --help             Flag. Optional. Display this help.
    --mode fileMode    String. Optional. Enforce the directory mode for mkdir --mode and chmod. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to - to reset to no value.
    --owner ownerName  String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to - to reset to no value.

Given a list of directories, ensure they exist and create them if they do not.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    directoryRequire "$cachePath"
'
