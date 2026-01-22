#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--mode fileMode - String. Optional. Enforce the directory mode for \`mkdir --mode\` and \`chmod\`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to \`-\` to reset to no value."$'\n'"--owner ownerName - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to \`-\` to reset to no value."$'\n'"fileDirectory ... - FileDirectory. Required. Test if file directory exists (file does not have to exist)"$'\n'""
base="directory.sh"
description="Given a list of files, ensure their parent directories exist"$'\n'""$'\n'"Creates the directories for all files passed in."$'\n'""$'\n'""
example="    logFile=./.build/\$me.log"$'\n'"    fileDirectoryRequire \"\$logFile\""$'\n'""
file="bin/build/tools/directory.sh"
fn="fileDirectoryRequire"
foundNames=""
logFile=""
requires="chmod throwArgument usageArgumentString decorate catchEnvironment dirname"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceModified="1769063211"
summary="Given a list of files, ensure their parent directories exist"
usage="fileDirectoryRequire [ --help ] [ --mode fileMode ] [ --owner ownerName ] fileDirectory ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileDirectoryRequire[0m [94m[ --help ][0m [94m[ --mode fileMode ][0m [94m[ --owner ownerName ][0m [38;2;255;255;0m[35;48;2;0;0;0mfileDirectory ...[0m[0m

    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--mode fileMode    [1;97mString. Optional. Enforce the directory mode for [38;2;0;255;0;48;2;0;0;0mmkdir --mode[0m and [38;2;0;255;0;48;2;0;0;0mchmod[0m. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to [38;2;0;255;0;48;2;0;0;0m-[0m to reset to no value.[0m
    [94m--owner ownerName  [1;97mString. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to [38;2;0;255;0;48;2;0;0;0m-[0m to reset to no value.[0m
    [31mfileDirectory ...  [1;97mFileDirectory. Required. Test if file directory exists (file does not have to exist)[0m

Given a list of files, ensure their parent directories exist

Creates the directories for all files passed in.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    logFile=./.build/$me.log
    fileDirectoryRequire "$logFile"
'
# shellcheck disable=SC2016
helpPlain='Usage: fileDirectoryRequire [ --help ] [ --mode fileMode ] [ --owner ownerName ] fileDirectory ...

    --help             Flag. Optional. Display this help.
    --mode fileMode    String. Optional. Enforce the directory mode for mkdir --mode and chmod. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to - to reset to no value.
    --owner ownerName  String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to - to reset to no value.
    fileDirectory ...  FileDirectory. Required. Test if file directory exists (file does not have to exist)

Given a list of files, ensure their parent directories exist

Creates the directories for all files passed in.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    logFile=./.build/$me.log
    fileDirectoryRequire "$logFile"
'
