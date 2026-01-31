#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="Does this commit have the following file extensions?"$'\n'"Argument: extension - String. Optional. Extension to check. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"Return code: 0 - if all extensions are present"$'\n'"Return code: 1 - if any extension is not present"$'\n'""
file="bin/build/tools/git.sh"
foundNames=()
rawComment="Does this commit have the following file extensions?"$'\n'"Argument: extension - String. Optional. Extension to check. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"Return code: 0 - if all extensions are present"$'\n'"Return code: 1 - if any extension is not present"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="3d571e2d1ac61ab50aca59a14e16e0ada007496b"
summary="Does this commit have the following file extensions?"
usage="gitPreCommitHasExtension"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitPreCommitHasExtension'$'\e''[0m'$'\n'''$'\n''Does this commit have the following file extensions?'$'\n''Argument: extension - String. Optional. Extension to check. Use '$'\e''[[(code)]m!'$'\e''[[(reset)]m for blank extension and '$'\e''[[(code)]m@'$'\e''[[(reset)]m for all extensions. Can specify one or more.'$'\n''Return code: 0 - if all extensions are present'$'\n''Return code: 1 - if any extension is not present'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitPreCommitHasExtension'$'\n'''$'\n''Does this commit have the following file extensions?'$'\n''Argument: extension - String. Optional. Extension to check. Use ! for blank extension and @ for all extensions. Can specify one or more.'$'\n''Return code: 0 - if all extensions are present'$'\n''Return code: 1 - if any extension is not present'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.447
