#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="source - File. Required. File where the function is defined."$'\n'"lineNumber - String. Required. Previously computed line number of the function."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashFileComment"
foundNames=([0]="argument" [1]="requires")
rawComment="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'"Argument: source - File. Required. File where the function is defined."$'\n'"Argument: lineNumber - String. Required. Previously computed line number of the function."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: head bashFinalComment"$'\n'"Requires: __help usageDocument"$'\n'""$'\n'""
requires="head bashFinalComment"$'\n'"__help usageDocument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="f595398f728c584ee7c7e2255d6ece3e08b0d67d"
summary="Extract a bash comment from a file. Excludes lines containing"
summaryComputed="true"
usage="bashFileComment source lineNumber [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
