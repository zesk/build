#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/process.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"pid - Process ID of running process"$'\n'""
base="process.sh"
description="Outputs value of virtual memory allocated for a process, value is in kilobytes"$'\n'""
example="    processVirtualMemoryAllocation 23"$'\n'""
file="bin/build/tools/process.sh"
foundNames=([0]="argument" [1]="example" [2]="output" [3]="return_code")
output="423"$'\n'""
rawComment="Outputs value of virtual memory allocated for a process, value is in kilobytes"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: pid - Process ID of running process"$'\n'"Example:     {fn} 23"$'\n'"Output: 423"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/process.sh"
sourceModified="1769277628"
summary="Outputs value of virtual memory allocated for a process, value"
usage="processVirtualMemoryAllocation [ --help ] [ pid ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mprocessVirtualMemoryAllocation'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ pid ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mpid     '$'\e''[[(value)]mProcess ID of running process'$'\e''[[(reset)]m'$'\n'''$'\n''Outputs value of virtual memory allocated for a process, value is in kilobytes'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    processVirtualMemoryAllocation 23'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: processVirtualMemoryAllocation [ --help ] [ pid ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    pid     Process ID of running process'$'\n'''$'\n''Outputs value of virtual memory allocated for a process, value is in kilobytes'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    processVirtualMemoryAllocation 23'$'\n'''
# elapsed 0.609
