#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/map.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--path cannonPath - Directory. Optional. Run cannon operation starting in this directory."$'\n'"fromText - Required. String of text to search for."$'\n'"toText - Required. String of text to replace."$'\n'"findArgs ... - Arguments. Optional. Any additional arguments are meant to filter files."$'\n'""
base="map.sh"
description="Replace text \`fromText\` with \`toText\` in files, using \`findArgs\` to filter files if needed."$'\n'""$'\n'"This can break your files so use with caution. Blank searchText is not allowed."$'\n'"The term \`cannon\` is not a mistake - it will break something at some point."$'\n'""$'\n'"Return Code: 0 - Success, no files changed"$'\n'"Return Code: 3 - At least one or more files were modified successfully"$'\n'"Return Code: 1 - --path is not a directory"$'\n'"Return Code: 1 - searchText is not blank"$'\n'"Return Code: 1 - fileTemporaryName failed"$'\n'"Return Code: 2 - Arguments are identical"$'\n'""
example="    cannon master main ! -path '*/old-version/*')"$'\n'""
file="bin/build/tools/map.sh"
fn="cannon"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceModified="1768756695"
summary="Replace text \`fromText\` with \`toText\` in files, using \`findArgs\` to"
usage="cannon [ --help ] [ --handler handler ] [ --path cannonPath ] fromText toText [ findArgs ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcannon[0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ --path cannonPath ][0m [38;2;255;255;0m[35;48;2;0;0;0mfromText[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mtoText[0m[0m [94m[ findArgs ... ][0m

    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94m--path cannonPath  [1;97mDirectory. Optional. Run cannon operation starting in this directory.[0m
    [31mfromText           [1;97mRequired. String of text to search for.[0m
    [31mtoText             [1;97mRequired. String of text to replace.[0m
    [94mfindArgs ...       [1;97mArguments. Optional. Any additional arguments are meant to filter files.[0m

Replace text [38;2;0;255;0;48;2;0;0;0mfromText[0m with [38;2;0;255;0;48;2;0;0;0mtoText[0m in files, using [38;2;0;255;0;48;2;0;0;0mfindArgs[0m to filter files if needed.

This can break your files so use with caution. Blank searchText is not allowed.
The term [38;2;0;255;0;48;2;0;0;0mcannon[0m is not a mistake - it will break something at some point.

Return Code: 0 - Success, no files changed
Return Code: 3 - At least one or more files were modified successfully
Return Code: 1 - --path is not a directory
Return Code: 1 - searchText is not blank
Return Code: 1 - fileTemporaryName failed
Return Code: 2 - Arguments are identical

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    cannon master main ! -path '\''[36m/old-version/[0m'\'')
'
# shellcheck disable=SC2016
helpPlain='Usage: cannon [ --help ] [ --handler handler ] [ --path cannonPath ] fromText toText [ findArgs ... ]

    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    --path cannonPath  Directory. Optional. Run cannon operation starting in this directory.
    fromText           Required. String of text to search for.
    toText             Required. String of text to replace.
    findArgs ...       Arguments. Optional. Any additional arguments are meant to filter files.

Replace text fromText with toText in files, using findArgs to filter files if needed.

This can break your files so use with caution. Blank searchText is not allowed.
The term cannon is not a mistake - it will break something at some point.

Return Code: 0 - Success, no files changed
Return Code: 3 - At least one or more files were modified successfully
Return Code: 1 - --path is not a directory
Return Code: 1 - searchText is not blank
Return Code: 1 - fileTemporaryName failed
Return Code: 2 - Arguments are identical

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    cannon master main ! -path '\''/old-version/'\'')
'
