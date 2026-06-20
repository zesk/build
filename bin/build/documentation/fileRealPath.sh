#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'file ... - File. Required. One or more files to `realpath`.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Find the full, actual path of a file avoiding symlinks or redirection.\nWithout arguments, displays help.\n\n'
descriptionLineCount="3"
file="bin/build/tools/file.sh"
fn="fileRealPath"
fnMarker="filerealpath"
foundNames=([0]="see" [1]="argument" [2]="requires")
line="435"
original="fileRealPath"
rawComment=$'Find the full, actual path of a file avoiding symlinks or redirection.\nSee: readlink realpath\nWithout arguments, displays help.\nArgument: file ... - File. Required. One or more files to `realpath`.\nRequires: executableExists realpath helpArgument bashDocumentation returnArgument\n\n'
requires=$'executableExists realpath helpArgument bashDocumentation returnArgument\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'readlink realpath\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="c688f25ccc836a3de5e08fcee0b11da564d05e7a"
sourceLine="435"
summary="Find the full, actual path of a file avoiding symlinks"
summaryComputed="true"
usage="fileRealPath file ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileRealPath'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfile ...  '$'\e''[[(value)]mFile. Required. One or more files to '$'\e''[[(code)]mrealpath'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Find the full, actual path of a file avoiding symlinks or redirection.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: fileRealPath file ...'$'\n'''$'\n''    file ...  File. Required. One or more files to realpath.'$'\n'''$'\n''Find the full, actual path of a file avoiding symlinks or redirection.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/file.md"
