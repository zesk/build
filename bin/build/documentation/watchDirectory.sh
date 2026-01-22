#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/watch.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"--file modifiedFile - File. Optional. Last known modified file in this directory."$'\n'"--modified modifiedTimestamp - UnsignedInteger. Optional. Last known modification timestamp in this directory."$'\n'"--timeout secondsToRun - UnsignedInteger. Optional. Last known modification timestamp in this directory."$'\n'"--state stateFile - File. Optional. Output of \`fileModificationTimes\` will be saved here (and modified)"$'\n'"directory - Directory. Required. Directory to watch"$'\n'"findArguments ... - Arguments. Optional. Passed to find to filter the files examined."$'\n'""
base="watch.sh"
description="Watch a directory"$'\n'""
file="bin/build/tools/watch.sh"
fn="watchDirectory"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/watch.sh"
sourceModified="1768721469"
summary="Watch a directory"
usage="watchDirectory [ --help ] [ --handler handler ] [ --verbose ] [ --file modifiedFile ] [ --modified modifiedTimestamp ] [ --timeout secondsToRun ] [ --state stateFile ] directory [ findArguments ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mwatchDirectory[0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ --verbose ][0m [94m[ --file modifiedFile ][0m [94m[ --modified modifiedTimestamp ][0m [94m[ --timeout secondsToRun ][0m [94m[ --state stateFile ][0m [38;2;255;255;0m[35;48;2;0;0;0mdirectory[0m[0m [94m[ findArguments ... ][0m

    [94m--help                        [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler             [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94m--verbose                     [1;97mFlag. Optional. Be verbose.[0m
    [94m--file modifiedFile           [1;97mFile. Optional. Last known modified file in this directory.[0m
    [94m--modified modifiedTimestamp  [1;97mUnsignedInteger. Optional. Last known modification timestamp in this directory.[0m
    [94m--timeout secondsToRun        [1;97mUnsignedInteger. Optional. Last known modification timestamp in this directory.[0m
    [94m--state stateFile             [1;97mFile. Optional. Output of [38;2;0;255;0;48;2;0;0;0mfileModificationTimes[0m will be saved here (and modified)[0m
    [31mdirectory                     [1;97mDirectory. Required. Directory to watch[0m
    [94mfindArguments ...             [1;97mArguments. Optional. Passed to find to filter the files examined.[0m

Watch a directory

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: watchDirectory [ --help ] [ --handler handler ] [ --verbose ] [ --file modifiedFile ] [ --modified modifiedTimestamp ] [ --timeout secondsToRun ] [ --state stateFile ] directory [ findArguments ... ]

    --help                        Flag. Optional. Display this help.
    --handler handler             Function. Optional. Use this error handler instead of the default error handler.
    --verbose                     Flag. Optional. Be verbose.
    --file modifiedFile           File. Optional. Last known modified file in this directory.
    --modified modifiedTimestamp  UnsignedInteger. Optional. Last known modification timestamp in this directory.
    --timeout secondsToRun        UnsignedInteger. Optional. Last known modification timestamp in this directory.
    --state stateFile             File. Optional. Output of fileModificationTimes will be saved here (and modified)
    directory                     Directory. Required. Directory to watch
    findArguments ...             Arguments. Optional. Passed to find to filter the files examined.

Watch a directory

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
