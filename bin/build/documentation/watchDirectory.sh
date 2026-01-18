#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/watch.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"--file modifiedFile - File. Optional. Last known modified file in this directory."$'\n'"--modified modifiedTimestamp - UnsignedInteger. Optional. Last known modification timestamp in this directory."$'\n'"--timeout secondsToRun - UnsignedInteger. Optional. Last known modification timestamp in this directory."$'\n'"--state stateFile - File. Optional. Output of \`fileModificationTimes\` will be saved here (and modified)"$'\n'"directory - Directory. Required. Directory to watch"$'\n'"findArguments ... - Arguments. Optional. Passed to find to filter the files examined."$'\n'""
base="watch.sh"
description="Watch a directory"$'\n'""
file="bin/build/tools/watch.sh"
fn="watchDirectory"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/watch.sh"
sourceModified="1768721469"
summary="Watch a directory"
usage="watchDirectory [ --help ] [ --handler handler ] [ --verbose ] [ --file modifiedFile ] [ --modified modifiedTimestamp ] [ --timeout secondsToRun ] [ --state stateFile ] directory [ findArguments ... ]"
