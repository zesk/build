#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--ignore prefix. String. Optional. Ignore exact function names."$'\n'"--ignore-prefix prefix - String. Optional. Ignore function names which match the prefix and do not check them."$'\n'"--report - Flag. Optional. Output a report of various functions and handler after processing is complete."$'\n'"--require - Flag. Optional. Requires at least one or more requirements to be listed and met to pass"$'\n'"--unused - Flag. Optional. Check for unused functions and report on them."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Checks a bash script to ensure all requirements are met, outputs a list of unmet requirements"$'\n'"Scans a bash script for lines which look like:"$'\n'""$'\n'"Each requirement token is:"$'\n'""$'\n'"- a bash function which MUST be defined"$'\n'"- a shell script (executable) which must be present"$'\n'""$'\n'"If all requirements are met, exit status of 0."$'\n'"If any requirements are not met, exit status of 1 and a list of unmet requirements are listed"$'\n'""$'\n'""
descriptionLineCount="11"
file="bin/build/tools/bash.sh"
fn="bashCheckRequires"
fnMarker="bashcheckrequires"
foundNames=([0]="requires" [1]="argument")
line="72"
rawComment="Checks a bash script to ensure all requirements are met, outputs a list of unmet requirements"$'\n'"Scans a bash script for lines which look like:"$'\n'"Requires: token1 token2"$'\n'"Each requirement token is:"$'\n'"- a bash function which MUST be defined"$'\n'"- a shell script (executable) which must be present"$'\n'"If all requirements are met, exit status of 0."$'\n'"If any requirements are not met, exit status of 1 and a list of unmet requirements are listed"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --ignore prefix. String. Optional. Ignore exact function names."$'\n'"Argument: --ignore-prefix prefix - String. Optional. Ignore function names which match the prefix and do not check them."$'\n'"Argument: --report - Flag. Optional. Output a report of various functions and handler after processing is complete."$'\n'"Argument: --require - Flag. Optional. Requires at least one or more requirements to be listed and met to pass"$'\n'"Argument: --unused - Flag. Optional. Check for unused functions and report on them."$'\n'""$'\n'""
requires="token1 token2"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="9d7b158a0e679532b85d7d28ad6415566e66b29c"
sourceLine="72"
summary="Checks a bash script to ensure all requirements are met,"
summaryComputed="true"
usage="bashCheckRequires [ --help ] [ --ignore prefix. String. Optional. Ignore exact function names. ] [ --ignore-prefix prefix ] [ --report ] [ --require ] [ --unused ]"
