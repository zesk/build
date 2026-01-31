#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="build.sh"
description="Generate the path for a quiet log in the build cache directory, creating it if necessary."$'\n'"Argument: name - String. Required. The log file name to create. Trims leading \`_\` if present."$'\n'"Argument: --no-create - Flag. Optional. Do not require creation of the directory where the log file will appear."$'\n'""
file="bin/build/tools/build.sh"
foundNames=()
rawComment="Generate the path for a quiet log in the build cache directory, creating it if necessary."$'\n'"Argument: name - String. Required. The log file name to create. Trims leading \`_\` if present."$'\n'"Argument: --no-create - Flag. Optional. Do not require creation of the directory where the log file will appear."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="267ae3edaa9016ac7b2e56308eee0e1fd805c66e"
summary="Generate the path for a quiet log in the build"
usage="buildQuietLog"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildQuietLog'$'\e''[0m'$'\n'''$'\n''Generate the path for a quiet log in the build cache directory, creating it if necessary.'$'\n''Argument: name - String. Required. The log file name to create. Trims leading '$'\e''[[(code)]m_'$'\e''[[(reset)]m if present.'$'\n''Argument: --no-create - Flag. Optional. Do not require creation of the directory where the log file will appear.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildQuietLog'$'\n'''$'\n''Generate the path for a quiet log in the build cache directory, creating it if necessary.'$'\n''Argument: name - String. Required. The log file name to create. Trims leading _ if present.'$'\n''Argument: --no-create - Flag. Optional. Do not require creation of the directory where the log file will appear.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.464
