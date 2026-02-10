#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-10
# shellcheck disable=SC2034
argument="extension - String. Optional. Extension to check. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Does this commit have the following file extensions?"$'\n'""
file="bin/build/tools/git.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Does this commit have the following file extensions?"$'\n'"Argument: extension - String. Optional. Extension to check. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return code: 0 - if all extensions are present"$'\n'"Return code: 1 - if any extension is not present"$'\n'""$'\n'""
return_code="0 - if all extensions are present"$'\n'"1 - if any extension is not present"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="1c51d81ea9e59d2e079d5ba420ada503a43bd31a"
summary="Does this commit have the following file extensions?"
summaryComputed="true"
usage="gitPreCommitHasExtension [ extension ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitPreCommitHasExtension'$'\e''[0m '$'\e''[[(blue)]m[ extension ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mextension  '$'\e''[[(value)]mString. Optional. Extension to check. Use '$'\e''[[(code)]m!'$'\e''[[(reset)]m for blank extension and '$'\e''[[(code)]m@'$'\e''[[(reset)]m for all extensions. Can specify one or more.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Does this commit have the following file extensions?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if all extensions are present'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if any extension is not present'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitPreCommitHasExtension [ extension ] [ --help ]'$'\n'''$'\n''    extension  String. Optional. Extension to check. Use ! for blank extension and @ for all extensions. Can specify one or more.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Does this commit have the following file extensions?'$'\n'''$'\n''Return codes:'$'\n''- 0 - if all extensions are present'$'\n''- 1 - if any extension is not present'$'\n'''
