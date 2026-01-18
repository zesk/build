#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"--ignore prefix. String. Optional. Ignore exact function names."$'\n'"--ignore-prefix prefix. String. Optional. Ignore function names which match the prefix and do not check them."$'\n'"--report - Flag. Optional. Output a report of various functions and handler after processing is complete."$'\n'"--require - Flag. Optional. Requires at least one or more requirements to be listed and met to pass"$'\n'"--unused - Flag. Optional. Check for unused functions and report on them."$'\n'""
base="bash.sh"
description="Checks a bash script to ensure all requirements are met, outputs a list of unmet requirements"$'\n'"Scans a bash script for lines which look like:"$'\n'""$'\n'""$'\n'"Each requirement token is:"$'\n'""$'\n'"- a bash function which MUST be defined"$'\n'"- a shell script (executable) which must be present"$'\n'""$'\n'"If all requirements are met, exit status of 0."$'\n'"If any requirements are not met, exit status of 1 and a list of unmet requirements are listed"$'\n'""$'\n'""
file="bin/build/tools/bash.sh"
fn="bashCheckRequires"
foundNames=([0]="requires" [1]="argument")
requires="token1 token2"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/bash.sh"
sourceModified="1768695708"
summary="Checks a bash script to ensure all requirements are met,"
usage="bashCheckRequires [ --help ] [ --ignore prefix. String. Optional. Ignore exact function names. ] [ --ignore-prefix prefix. String. Optional. Ignore function names which match the prefix and do not check them. ] [ --report ] [ --require ] [ --unused ]"
