#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--map - Flag. Optional. Map environment values into file before copying."$'\n'"--escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges."$'\n'"source - File. Required. Source path"$'\n'"destination - File. Required. Destination path"$'\n'""
base="interactive.sh"
description="Copy file from source to destination"$'\n'"Supports mapping the file using the current environment, or escalated privileges."$'\n'""
file="bin/build/tools/interactive.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Copy file from source to destination"$'\n'"Supports mapping the file using the current environment, or escalated privileges."$'\n'"Argument: --map - Flag. Optional. Map environment values into file before copying."$'\n'"Argument: --escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges."$'\n'"Argument: source - File. Required. Source path"$'\n'"Argument: destination - File. Required. Destination path"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Failed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Failed"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="e17f0ea69f1c6cf5eceec027dffd3be9d099fb75"
summary="Copy file from source to destination"
summaryComputed="true"
usage="fileCopy [ --map ] [ --escalate ] source destination"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileCopy'$'\e''[0m '$'\e''[[(blue)]m[ --map ]'$'\e''[0m '$'\e''[[(blue)]m[ --escalate ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdestination'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--map        '$'\e''[[(value)]mFlag. Optional. Map environment values into file before copying.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--escalate   '$'\e''[[(value)]mFlag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msource       '$'\e''[[(value)]mFile. Required. Source path'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mdestination  '$'\e''[[(value)]mFile. Required. Destination path'$'\e''[[(reset)]m'$'\n'''$'\n''Copy file from source to destination'$'\n''Supports mapping the file using the current environment, or escalated privileges.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Failed'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileCopy [ --map ] [ --escalate ] source destination'$'\n'''$'\n''    --map        Flag. Optional. Map environment values into file before copying.'$'\n''    --escalate   Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.'$'\n''    source       File. Required. Source path'$'\n''    destination  File. Required. Destination path'$'\n'''$'\n''Copy file from source to destination'$'\n''Supports mapping the file using the current environment, or escalated privileges.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Failed'$'\n'''
# elapsed 4.161
