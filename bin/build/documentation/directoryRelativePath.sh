#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="directory.sh"
description="Given a path to a file, compute the path back up to the top in reverse (../..)"$'\n'"If path is blank, outputs \`.\`."$'\n'"Essentially converts the slash \`/\` to a \`..\`, so convert your source appropriately."$'\n'"     directoryRelativePath \"/\" -> \"..\""$'\n'"     directoryRelativePath \"/a/b/c\" -> ../../.."$'\n'"Argument: directory - String. A path to convert."$'\n'"stdout: Relative paths, one per line"$'\n'""
file="bin/build/tools/directory.sh"
foundNames=()
rawComment="Given a path to a file, compute the path back up to the top in reverse (../..)"$'\n'"If path is blank, outputs \`.\`."$'\n'"Essentially converts the slash \`/\` to a \`..\`, so convert your source appropriately."$'\n'"     directoryRelativePath \"/\" -> \"..\""$'\n'"     directoryRelativePath \"/a/b/c\" -> ../../.."$'\n'"Argument: directory - String. A path to convert."$'\n'"stdout: Relative paths, one per line"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="48944c2d998ec4950146d3ca4b1eba7cb335709c"
summary="Given a path to a file, compute the path back"
usage="directoryRelativePath"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryRelativePath'$'\e''[0m'$'\n'''$'\n''Given a path to a file, compute the path back up to the top in reverse (../..)'$'\n''If path is blank, outputs '$'\e''[[(code)]m.'$'\e''[[(reset)]m'$'\n''Essentially converts the slash '$'\e''[[(code)]m/'$'\e''[[(reset)]m to a '$'\e''[[(code)]m..'$'\e''[[(reset)]m, so convert your source appropriately.'$'\n''     directoryRelativePath "/" -> ".."'$'\n''     directoryRelativePath "/a/b/c" -> ../../..'$'\n''Argument: directory - String. A path to convert.'$'\n''stdout: Relative paths, one per line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: directoryRelativePath'$'\n'''$'\n''Given a path to a file, compute the path back up to the top in reverse (../..)'$'\n''If path is blank, outputs .'$'\n''Essentially converts the slash / to a .., so convert your source appropriately.'$'\n''     directoryRelativePath "/" -> ".."'$'\n''     directoryRelativePath "/a/b/c" -> ../../..'$'\n''Argument: directory - String. A path to convert.'$'\n''stdout: Relative paths, one per line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.473
