#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--map - Flag. Optional. Map environment values into file before copying.\n--escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.\nsource - File. Required. Source path\ndestination - File. Required. Destination path\n'
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Copy file from source to destination\n\nSupports mapping the file using the current environment, or escalated privileges.\n\n'
descriptionLineCount="4"
file="bin/build/tools/interactive.sh"
fn="fileCopy"
fnMarker="filecopy"
foundNames=([0]="argument" [1]="return_code")
line="55"
rawComment=$'Copy file from source to destination\nSupports mapping the file using the current environment, or escalated privileges.\nArgument: --map - Flag. Optional. Map environment values into file before copying.\nArgument: --escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.\nArgument: source - File. Required. Source path\nArgument: destination - File. Required. Destination path\nReturn Code: 0 - Success\nReturn Code: 1 - Failed\n\n'
return_code=$'0 - Success\n1 - Failed\n'
sourceFile="bin/build/tools/interactive.sh"
sourceHash="f4796c0b7d055e906c15497340e62fd7c9cdd8ad"
sourceLine="55"
summary="Copy file from source to destination"
summaryComputed="true"
usage="fileCopy [ --map ] [ --escalate ] source destination"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileCopy'$'\e''[0m '$'\e''[[(blue)]m[ --map ]'$'\e''[0m '$'\e''[[(blue)]m[ --escalate ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdestination'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--map        '$'\e''[[(value)]mFlag. Optional. Map environment values into file before copying.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--escalate   '$'\e''[[(value)]mFlag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msource       '$'\e''[[(value)]mFile. Required. Source path'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mdestination  '$'\e''[[(value)]mFile. Required. Destination path'$'\e''[[(reset)]m'$'\n'''$'\n''Copy file from source to destination'$'\n'''$'\n''Supports mapping the file using the current environment, or escalated privileges.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Failed'
# shellcheck disable=SC2016
helpPlain='Usage: fileCopy [ --map ] [ --escalate ] source destination'$'\n'''$'\n''    --map        Flag. Optional. Map environment values into file before copying.'$'\n''    --escalate   Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.'$'\n''    source       File. Required. Source path'$'\n''    destination  File. Required. Destination path'$'\n'''$'\n''Copy file from source to destination'$'\n'''$'\n''Supports mapping the file using the current environment, or escalated privileges.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Failed'
documentationPath="documentation/source/tools/interactive.md"
