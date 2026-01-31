#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="interactive.sh"
description="Copy file from source to destination"$'\n'"Supports mapping the file using the current environment, or escalated privileges."$'\n'"Argument: --map - Flag. Optional. Map environment values into file before copying."$'\n'"Argument: --escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges."$'\n'"Argument: source - File. Required. Source path"$'\n'"Argument: destination - File. Required. Destination path"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Failed"$'\n'""
file="bin/build/tools/interactive.sh"
foundNames=()
rawComment="Copy file from source to destination"$'\n'"Supports mapping the file using the current environment, or escalated privileges."$'\n'"Argument: --map - Flag. Optional. Map environment values into file before copying."$'\n'"Argument: --escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges."$'\n'"Argument: source - File. Required. Source path"$'\n'"Argument: destination - File. Required. Destination path"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Failed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="e17f0ea69f1c6cf5eceec027dffd3be9d099fb75"
summary="Copy file from source to destination"
usage="fileCopy"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileCopy'$'\e''[0m'$'\n'''$'\n''Copy file from source to destination'$'\n''Supports mapping the file using the current environment, or escalated privileges.'$'\n''Argument: --map - Flag. Optional. Map environment values into file before copying.'$'\n''Argument: --escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.'$'\n''Argument: source - File. Required. Source path'$'\n''Argument: destination - File. Required. Destination path'$'\n''Return Code: 0 - Success'$'\n''Return Code: 1 - Failed'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileCopy'$'\n'''$'\n''Copy file from source to destination'$'\n''Supports mapping the file using the current environment, or escalated privileges.'$'\n''Argument: --map - Flag. Optional. Map environment values into file before copying.'$'\n''Argument: --escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.'$'\n''Argument: source - File. Required. Source path'$'\n''Argument: destination - File. Required. Destination path'$'\n''Return Code: 0 - Success'$'\n''Return Code: 1 - Failed'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.468
