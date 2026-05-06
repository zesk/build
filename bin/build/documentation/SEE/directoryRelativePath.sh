#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="directory - String. A path to convert."$'\n'""
base="directory.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Given a path to a file, compute the path back up to the top in reverse (../..)"$'\n'"If path is blank, outputs \`.\`."$'\n'""$'\n'"Essentially converts the slash \`/\` to a \`..\`, so convert your source appropriately."$'\n'""$'\n'"     directoryRelativePath \"/\" -> \"..\""$'\n'"     directoryRelativePath \"/a/b/c\" -> ../../.."$'\n'""$'\n'""
descriptionLineCount="8"
file="bin/build/tools/directory.sh"
fn="directoryRelativePath"
fnMarker="directoryrelativepath"
foundNames=([0]="argument" [1]="stdout")
line="291"
rawComment="Given a path to a file, compute the path back up to the top in reverse (../..)"$'\n'"If path is blank, outputs \`.\`."$'\n'"Essentially converts the slash \`/\` to a \`..\`, so convert your source appropriately."$'\n'"     directoryRelativePath \"/\" -> \"..\""$'\n'"     directoryRelativePath \"/a/b/c\" -> ../../.."$'\n'"Argument: directory - String. A path to convert."$'\n'"stdout: Relative paths, one per line"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="da838a55948477df4605f58aff4c29b4f13319f7"
sourceLine="291"
stdout="Relative paths, one per line"$'\n'""
summary="Given a path to a file, compute the path back"
summaryComputed="true"
usage="directoryRelativePath [ directory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryRelativePath'$'\e''[0m '$'\e''[[(blue)]m[ directory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mdirectory  '$'\e''[[(value)]mString. A path to convert.'$'\e''[[(reset)]m'$'\n'''$'\n''Given a path to a file, compute the path back up to the top in reverse (../..)'$'\n''If path is blank, outputs '$'\e''[[(code)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Essentially converts the slash '$'\e''[[(code)]m/'$'\e''[[(reset)]m to a '$'\e''[[(code)]m..'$'\e''[[(reset)]m, so convert your source appropriately.'$'\n'''$'\n''     directoryRelativePath "/" -> ".."'$'\n''     directoryRelativePath "/a/b/c" -> ../../..'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Relative paths, one per line'
# shellcheck disable=SC2016
helpPlain='Usage: directoryRelativePath [ directory ]'$'\n'''$'\n''    directory  String. A path to convert.'$'\n'''$'\n''Given a path to a file, compute the path back up to the top in reverse (../..)'$'\n''If path is blank, outputs .'$'\n'''$'\n''Essentially converts the slash / to a .., so convert your source appropriately.'$'\n'''$'\n''     directoryRelativePath "/" -> ".."'$'\n''     directoryRelativePath "/a/b/c" -> ../../..'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''Relative paths, one per line'
documentationPath="documentation/source/tools/directory.md"
