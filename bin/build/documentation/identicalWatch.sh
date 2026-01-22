#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/identical.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"... - Arguments. Required. Arguments to \`identicalCheck\` for your watch."$'\n'""
base="identical.sh"
description="Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution."$'\n'"Still a known bug which trims the last end bracket from files"$'\n'""
file="bin/build/tools/identical.sh"
fn="identicalWatch"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/identical.sh"
sourceModified="1769063211"
summary="Watch a project for changes and propagate them immediately upon"
usage="identicalWatch [ --help ] [ --handler handler ] ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255midenticalWatch[0m [94m[ --help ][0m [94m[ --handler handler ][0m [38;2;255;255;0m[35;48;2;0;0;0m...[0m[0m

    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [31m...                [1;97mArguments. Required. Arguments to [38;2;0;255;0;48;2;0;0;0midenticalCheck[0m for your watch.[0m

Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution.
Still a known bug which trims the last end bracket from files

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: identicalWatch [ --help ] [ --handler handler ] ...

    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    ...                Arguments. Required. Arguments to identicalCheck for your watch.

Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution.
Still a known bug which trims the last end bracket from files

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
