#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'directoryPath ... - One or more directories to create\n--help - Flag. Optional. Display this help.\n--mode fileMode - String. Optional. Enforce the directory mode for `mkdir --mode` and `chmod`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to `-` to reset to no value.\n--owner ownerName - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to `-` to reset to no value.\n'
base="directory.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Given a list of directories, ensure they exist and create them if they do not.\n\n'
descriptionLineCount="2"
example=$'    directoryRequire "$cachePath"\n'
file="bin/build/tools/directory.sh"
fn="directoryRequire"
fnMarker="directoryrequire"
foundNames=([0]="argument" [1]="example" [2]="requires")
line="194"
rawComment=$'Given a list of directories, ensure they exist and create them if they do not.\nArgument: directoryPath ... - One or more directories to create\nExample:     {fn} "$cachePath"\nArgument: --help - Flag. Optional. Display this help.\nArgument: --mode fileMode - String. Optional. Enforce the directory mode for `mkdir --mode` and `chmod`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to `-` to reset to no value.\nArgument: --owner ownerName - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to `-` to reset to no value.\nRequires: throwArgument decorate catchEnvironment dirname\nRequires: chmod chown\n\n'
requires=$'throwArgument decorate catchEnvironment dirname\nchmod chown\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/directory.sh"
sourceHash="56e2e47efbd4d48b0fa152ed5f06ec8d0ff20d9e"
sourceLine="194"
summary="Given a list of directories, ensure they exist and create"
summaryComputed="true"
usage="directoryRequire [ directoryPath ... ] [ --help ] [ --mode fileMode ] [ --owner ownerName ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryRequire'$'\e''[0m '$'\e''[[(blue)]m[ directoryPath ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --mode fileMode ]'$'\e''[0m '$'\e''[[(blue)]m[ --owner ownerName ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mdirectoryPath ...  '$'\e''[[(value)]mOne or more directories to create'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--mode fileMode    '$'\e''[[(value)]mString. Optional. Enforce the directory mode for '$'\e''[[(code)]mmkdir --mode'$'\e''[[(reset)]m and '$'\e''[[(code)]mchmod'$'\e''[[(reset)]m. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to '$'\e''[[(code)]m-'$'\e''[[(reset)]m to reset to no value.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--owner ownerName  '$'\e''[[(value)]mString. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to '$'\e''[[(code)]m-'$'\e''[[(reset)]m to reset to no value.'$'\e''[[(reset)]m'$'\n'''$'\n''Given a list of directories, ensure they exist and create them if they do not.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    directoryRequire "$cachePath"'
# shellcheck disable=SC2016
helpPlain='Usage: directoryRequire [ directoryPath ... ] [ --help ] [ --mode fileMode ] [ --owner ownerName ]'$'\n'''$'\n''    directoryPath ...  One or more directories to create'$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --mode fileMode    String. Optional. Enforce the directory mode for mkdir --mode and chmod. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to - to reset to no value.'$'\n''    --owner ownerName  String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to - to reset to no value.'$'\n'''$'\n''Given a list of directories, ensure they exist and create them if they do not.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    directoryRequire "$cachePath"'
documentationPath="documentation/source/tools/directory.md"
