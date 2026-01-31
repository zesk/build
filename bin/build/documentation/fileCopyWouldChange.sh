#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="interactive.sh"
description="Check whether copying a file would change it"$'\n'"This function does not modify the source or destination."$'\n'"Argument: --map - Flag. Optional. Map environment values into file before copying."$'\n'"Argument: source - File. Required. Source path"$'\n'"Argument: destination - File. Required. Destination path"$'\n'"Return Code: 0 - Something would change"$'\n'"Return Code: 1 - Nothing would change"$'\n'""
file="bin/build/tools/interactive.sh"
foundNames=()
rawComment="Check whether copying a file would change it"$'\n'"This function does not modify the source or destination."$'\n'"Argument: --map - Flag. Optional. Map environment values into file before copying."$'\n'"Argument: source - File. Required. Source path"$'\n'"Argument: destination - File. Required. Destination path"$'\n'"Return Code: 0 - Something would change"$'\n'"Return Code: 1 - Nothing would change"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="e17f0ea69f1c6cf5eceec027dffd3be9d099fb75"
summary="Check whether copying a file would change it"
usage="fileCopyWouldChange"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileCopyWouldChange'$'\e''[0m'$'\n'''$'\n''Check whether copying a file would change it'$'\n''This function does not modify the source or destination.'$'\n''Argument: --map - Flag. Optional. Map environment values into file before copying.'$'\n''Argument: source - File. Required. Source path'$'\n''Argument: destination - File. Required. Destination path'$'\n''Return Code: 0 - Something would change'$'\n''Return Code: 1 - Nothing would change'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileCopyWouldChange'$'\n'''$'\n''Check whether copying a file would change it'$'\n''This function does not modify the source or destination.'$'\n''Argument: --map - Flag. Optional. Map environment values into file before copying.'$'\n''Argument: source - File. Required. Source path'$'\n''Argument: destination - File. Required. Destination path'$'\n''Return Code: 0 - Something would change'$'\n''Return Code: 1 - Nothing would change'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.506
