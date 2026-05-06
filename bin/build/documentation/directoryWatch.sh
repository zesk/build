#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"--file modifiedFile - File. Optional. Last known modified file in this directory."$'\n'"--modified modifiedTimestamp - UnsignedInteger. Optional. Last known modification timestamp in this directory."$'\n'"--timeout secondsToRun - UnsignedInteger. Optional. Last known modification timestamp in this directory."$'\n'"--state stateFile - File. Optional. Output of \`fileModificationTimes\` will be saved here (and modified)"$'\n'"directory - Directory. Required. Directory to watch"$'\n'"findArguments ... - Arguments. Optional. Passed to find to filter the files examined."$'\n'""
base="watch.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Watch a directory"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/watch.sh"
fn="directoryWatch"
fnMarker="directorywatch"
foundNames=([0]="argument")
line="20"
rawComment="Watch a directory"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: --file modifiedFile - File. Optional. Last known modified file in this directory."$'\n'"Argument: --modified modifiedTimestamp - UnsignedInteger. Optional. Last known modification timestamp in this directory."$'\n'"Argument: --timeout secondsToRun - UnsignedInteger. Optional. Last known modification timestamp in this directory."$'\n'"Argument: --state stateFile - File. Optional. Output of \`fileModificationTimes\` will be saved here (and modified)"$'\n'"Argument: directory - Directory. Required. Directory to watch"$'\n'"Argument: findArguments ... - Arguments. Optional. Passed to find to filter the files examined."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/watch.sh"
sourceHash="5652a7bcd233cdde9e94c67330e08fbc61b7685b"
sourceLine="20"
summary="Watch a directory"
summaryComputed="true"
usage="directoryWatch [ --help ] [ --handler handler ] [ --verbose ] [ --file modifiedFile ] [ --modified modifiedTimestamp ] [ --timeout secondsToRun ] [ --state stateFile ] directory [ findArguments ... ]"
