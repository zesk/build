#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="extension - String. Optional. Extension to list. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="List the file(s) of an extension"$'\n'""
exitCode="0"
file="bin/build/tools/git.sh"
foundNames=([0]="argument" [1]="stdout")
rawComment="List the file(s) of an extension"$'\n'"Argument: extension - String. Optional. Extension to list. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: File. One per line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769199547"
stdout="File. One per line."$'\n'""
summary="List the file(s) of an extension"
usage="gitPreCommitListExtension [ extension ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mgitPreCommitListExtension'$'\e''[0m '$'\e''[[blue]m[ extension ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mextension  '$'\e''[[value]mString. Optional. Extension to list. Use '$'\e''[[code]m!'$'\e''[[reset]m for blank extension and '$'\e''[[code]m@'$'\e''[[reset]m for all extensions. Can specify one or more.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help     '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''List the file(s) of an extension'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''File. One per line.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitPreCommitListExtension [ extension ] [ --help ]'$'\n'''$'\n''    extension  String. Optional. Extension to list. Use ! for blank extension and @ for all extensions. Can specify one or more.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''List the file(s) of an extension'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''File. One per line.'$'\n'''
