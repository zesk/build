#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="directory - String. A path to convert."$'\n'""
base="directory.sh"
description="Given a path to a file, compute the path back up to the top in reverse (../..)"$'\n'"If path is blank, outputs \`.\`."$'\n'"Essentially converts the slash \`/\` to a \`..\`, so convert your source appropriately."$'\n'"     directoryRelativePath \"/\" -> \"..\""$'\n'"     directoryRelativePath \"/a/b/c\" -> ../../.."$'\n'""
exitCode="0"
file="bin/build/tools/directory.sh"
foundNames=([0]="argument" [1]="stdout")
rawComment="Given a path to a file, compute the path back up to the top in reverse (../..)"$'\n'"If path is blank, outputs \`.\`."$'\n'"Essentially converts the slash \`/\` to a \`..\`, so convert your source appropriately."$'\n'"     directoryRelativePath \"/\" -> \"..\""$'\n'"     directoryRelativePath \"/a/b/c\" -> ../../.."$'\n'"Argument: directory - String. A path to convert."$'\n'"stdout: Relative paths, one per line"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769063211"
stdout="Relative paths, one per line"$'\n'""
summary="Given a path to a file, compute the path back"
usage="directoryRelativePath [ directory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdirectoryRelativePath'$'\e''[0m '$'\e''[[blue]m[ directory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mdirectory  '$'\e''[[value]mString. A path to convert.'$'\e''[[reset]m'$'\n'''$'\n''Given a path to a file, compute the path back up to the top in reverse (../..)'$'\n''If path is blank, outputs '$'\e''[[code]m.'$'\e''[[reset]m'$'\n''Essentially converts the slash '$'\e''[[code]m/'$'\e''[[reset]m to a '$'\e''[[code]m..'$'\e''[[reset]m, so convert your source appropriately.'$'\n''     directoryRelativePath "/" -> ".."'$'\n''     directoryRelativePath "/a/b/c" -> ../../..'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''Relative paths, one per line'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: directoryRelativePath [ directory ]'$'\n'''$'\n''    directory  String. A path to convert.'$'\n'''$'\n''Given a path to a file, compute the path back up to the top in reverse (../..)'$'\n''If path is blank, outputs .'$'\n''Essentially converts the slash / to a .., so convert your source appropriately.'$'\n''     directoryRelativePath "/" -> ".."'$'\n''     directoryRelativePath "/a/b/c" -> ../../..'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''Relative paths, one per line'$'\n'''
