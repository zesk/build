#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="List the file(s) of an extension"$'\n'"Argument: extension - String. Optional. Extension to list. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: File. One per line."$'\n'""
file="bin/build/tools/git.sh"
foundNames=()
rawComment="List the file(s) of an extension"$'\n'"Argument: extension - String. Optional. Extension to list. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: File. One per line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="3d571e2d1ac61ab50aca59a14e16e0ada007496b"
summary="List the file(s) of an extension"
usage="gitPreCommitListExtension"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitPreCommitListExtension'$'\e''[0m'$'\n'''$'\n''List the file(s) of an extension'$'\n''Argument: extension - String. Optional. Extension to list. Use '$'\e''[[(code)]m!'$'\e''[[(reset)]m for blank extension and '$'\e''[[(code)]m@'$'\e''[[(reset)]m for all extensions. Can specify one or more.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''stdout: File. One per line.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitPreCommitListExtension'$'\n'''$'\n''List the file(s) of an extension'$'\n''Argument: extension - String. Optional. Extension to list. Use ! for blank extension and @ for all extensions. Can specify one or more.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''stdout: File. One per line.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.469
