#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-31
# shellcheck disable=SC2034
argument=$'pid - Integer. Required. Process ID of running process\n'
base="process.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Outputs value of resident memory used by a process, value is in kilobytes\n\n'
descriptionLineCount="2"
example=$'    > processMemoryUsage 23\n'
file="bin/build/tools/process.sh"
fn="processMemoryUsage"
fnMarker="processmemoryusage"
foundNames=([0]="argument" [1]="example" [2]="output" [3]="return_code")
line="150"
output=$'423\n'
rawComment=$'Outputs value of resident memory used by a process, value is in kilobytes\nArgument: pid - Integer. Required. Process ID of running process\nExample:     > {fn} 23\nOutput: 423\nReturn Code: 0 - Success\nReturn Code: 2 - Argument error\n\n'
return_code=$'0 - Success\n2 - Argument error\n'
sourceFile="bin/build/tools/process.sh"
sourceHash="0b517df56f78b0f4641c01677f31d5f0db9297ca"
sourceLine="150"
summary="Outputs value of resident memory used by a process, value"
summaryComputed="true"
usage="processMemoryUsage pid"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mprocessMemoryUsage'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpid'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mpid  '$'\e''[[(value)]mInteger. Required. Process ID of running process'$'\e''[[(reset)]m'$'\n'''$'\n''Outputs value of resident memory used by a process, value is in kilobytes'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    > processMemoryUsage 23'
# shellcheck disable=SC2016
helpPlain='Usage: processMemoryUsage pid'$'\n'''$'\n''    pid  Integer. Required. Process ID of running process'$'\n'''$'\n''Outputs value of resident memory used by a process, value is in kilobytes'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    > processMemoryUsage 23'
documentationPath="documentation/source/tools/process.md"
