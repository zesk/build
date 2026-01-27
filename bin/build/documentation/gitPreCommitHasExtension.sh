#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="extension - String. Optional. Extension to check. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'""
base="git.sh"
description="Does this commit have the following file extensions?"$'\n'""
file="bin/build/tools/git.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Does this commit have the following file extensions?"$'\n'"Argument: extension - String. Optional. Extension to check. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"Return code: 0 - if all extensions are present"$'\n'"Return code: 1 - if any extension is not present"$'\n'""$'\n'""
return_code="0 - if all extensions are present"$'\n'"1 - if any extension is not present"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769199547"
summary="Does this commit have the following file extensions?"
usage="gitPreCommitHasExtension [ extension ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitPreCommitHasExtension'$'\e''[0m '$'\e''[[(blue)]m[ extension ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mextension  '$'\e''[[(value)]mString. Optional. Extension to check. Use '$'\e''[[(code)]m!'$'\e''[[(reset)]m for blank extension and '$'\e''[[(code)]m@'$'\e''[[(reset)]m for all extensions. Can specify one or more.'$'\e''[[(reset)]m'$'\n'''$'\n''Does this commit have the following file extensions?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if all extensions are present'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if any extension is not present'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitPreCommitHasExtension [ extension ]'$'\n'''$'\n''    extension  String. Optional. Extension to check. Use ! for blank extension and @ for all extensions. Can specify one or more.'$'\n'''$'\n''Does this commit have the following file extensions?'$'\n'''$'\n''Return codes:'$'\n''- 0 - if all extensions are present'$'\n''- 1 - if any extension is not present'$'\n'''
# elapsed 0.406
