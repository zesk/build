#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--map - Flag. Optional. Map environment values into file before copying."$'\n'"source - File. Required. Source path"$'\n'"destination - File. Required. Destination path"$'\n'""
base="interactive.sh"
description="Check whether copying a file would change it"$'\n'"This function does not modify the source or destination."$'\n'""
file="bin/build/tools/interactive.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Check whether copying a file would change it"$'\n'"This function does not modify the source or destination."$'\n'"Argument: --map - Flag. Optional. Map environment values into file before copying."$'\n'"Argument: source - File. Required. Source path"$'\n'"Argument: destination - File. Required. Destination path"$'\n'"Return Code: 0 - Something would change"$'\n'"Return Code: 1 - Nothing would change"$'\n'""$'\n'""
return_code="0 - Something would change"$'\n'"1 - Nothing would change"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1769063211"
summary="Check whether copying a file would change it"
usage="fileCopyWouldChange [ --map ] source destination"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileCopyWouldChange'$'\e''[0m '$'\e''[[(blue)]m[ --map ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdestination'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--map        '$'\e''[[(value)]mFlag. Optional. Map environment values into file before copying.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msource       '$'\e''[[(value)]mFile. Required. Source path'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mdestination  '$'\e''[[(value)]mFile. Required. Destination path'$'\e''[[(reset)]m'$'\n'''$'\n''Check whether copying a file would change it'$'\n''This function does not modify the source or destination.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Something would change'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Nothing would change'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileCopyWouldChange [ --map ] source destination'$'\n'''$'\n''    --map        Flag. Optional. Map environment values into file before copying.'$'\n''    source       File. Required. Source path'$'\n''    destination  File. Required. Destination path'$'\n'''$'\n''Check whether copying a file would change it'$'\n''This function does not modify the source or destination.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Something would change'$'\n''- 1 - Nothing would change'$'\n'''
# elapsed 0.458
