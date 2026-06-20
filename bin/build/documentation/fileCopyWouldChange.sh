#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--map - Flag. Optional. Map environment values into file before copying.\nsource - File. Required. Source path\ndestination - File. Required. Destination path\n'
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Check whether copying a file would change it\nThis function does not modify the source or destination.\n\n'
descriptionLineCount="3"
file="bin/build/tools/interactive.sh"
fn="fileCopyWouldChange"
fnMarker="filecopywouldchange"
foundNames=([0]="argument" [1]="return_code")
line="70"
original="fileCopyWouldChange"
rawComment=$'Check whether copying a file would change it\nThis function does not modify the source or destination.\nArgument: --map - Flag. Optional. Map environment values into file before copying.\nArgument: source - File. Required. Source path\nArgument: destination - File. Required. Destination path\nReturn Code: 0 - Something would change\nReturn Code: 1 - Nothing would change\n\n'
return_code=$'0 - Something would change\n1 - Nothing would change\n'
sourceFile="bin/build/tools/interactive.sh"
sourceHash="6e0d41188cc236cd7170c65cbacacbb7f30b9788"
sourceLine="70"
summary="Check whether copying a file would change it"
summaryComputed="true"
usage="fileCopyWouldChange [ --map ] source destination"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileCopyWouldChange'$'\e''[0m '$'\e''[[(blue)]m[ --map ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdestination'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--map        '$'\e''[[(value)]mFlag. Optional. Map environment values into file before copying.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msource       '$'\e''[[(value)]mFile. Required. Source path'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mdestination  '$'\e''[[(value)]mFile. Required. Destination path'$'\e''[[(reset)]m'$'\n'''$'\n''Check whether copying a file would change it'$'\n''This function does not modify the source or destination.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Something would change'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Nothing would change'
# shellcheck disable=SC2016
helpPlain='Usage: fileCopyWouldChange [ --map ] source destination'$'\n'''$'\n''    --map        Flag. Optional. Map environment values into file before copying.'$'\n''    source       File. Required. Source path'$'\n''    destination  File. Required. Destination path'$'\n'''$'\n''Check whether copying a file would change it'$'\n''This function does not modify the source or destination.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Something would change'$'\n''- 1 - Nothing would change'
documentationPath="documentation/source/tools/interactive.md"
