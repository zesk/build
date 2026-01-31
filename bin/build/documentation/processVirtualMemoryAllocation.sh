#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="process.sh"
description="Outputs value of virtual memory allocated for a process, value is in kilobytes"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: pid - Process ID of running process"$'\n'"Example:     {fn} 23"$'\n'"Output: 423"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/process.sh"
foundNames=()
rawComment="Outputs value of virtual memory allocated for a process, value is in kilobytes"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: pid - Process ID of running process"$'\n'"Example:     {fn} 23"$'\n'"Output: 423"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/process.sh"
sourceHash="36fbe746ad780ed0b3b8040cb1a41429d089fbbc"
summary="Outputs value of virtual memory allocated for a process, value"
usage="processVirtualMemoryAllocation"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mprocessVirtualMemoryAllocation'$'\e''[0m'$'\n'''$'\n''Outputs value of virtual memory allocated for a process, value is in kilobytes'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: pid - Process ID of running process'$'\n''Example:     processVirtualMemoryAllocation 23'$'\n''Output: 423'$'\n''Return Code: 0 - Success'$'\n''Return Code: 2 - Argument error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: processVirtualMemoryAllocation'$'\n'''$'\n''Outputs value of virtual memory allocated for a process, value is in kilobytes'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: pid - Process ID of running process'$'\n''Example:     processVirtualMemoryAllocation 23'$'\n''Output: 423'$'\n''Return Code: 0 - Success'$'\n''Return Code: 2 - Argument error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.464
