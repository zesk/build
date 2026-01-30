#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="pid - Integer. Required. Process ID of running process"$'\n'""
base="process.sh"
description="Outputs value of resident memory used by a process, value is in kilobytes"$'\n'""
example="    > processMemoryUsage 23"$'\n'""
file="bin/build/tools/process.sh"
foundNames=([0]="argument" [1]="example" [2]="output" [3]="return_code")
output="423"$'\n'""
rawComment="Outputs value of resident memory used by a process, value is in kilobytes"$'\n'"Argument: pid - Integer. Required. Process ID of running process"$'\n'"Example:     > {fn} 23"$'\n'"Output: 423"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/process.sh"
sourceHash="36fbe746ad780ed0b3b8040cb1a41429d089fbbc"
summary="Outputs value of resident memory used by a process, value"
usage="processMemoryUsage pid"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mprocessMemoryUsage'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpid'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mpid  '$'\e''[[(value)]mInteger. Required. Process ID of running process'$'\e''[[(reset)]m'$'\n'''$'\n''Outputs value of resident memory used by a process, value is in kilobytes'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    > processMemoryUsage 23'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: processMemoryUsage [[(bold)]m[[(magenta)]mpid'$'\n'''$'\n''    [[(red)]mpid  [[(value)]mInteger. Required. Process ID of running process'$'\n'''$'\n''Outputs value of resident memory used by a process, value is in kilobytes'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m2 - Argument error'$'\n'''$'\n''Example:'$'\n''    > processMemoryUsage 23'$'\n'''
# elapsed 2.84
