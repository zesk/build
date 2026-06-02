#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-01
# shellcheck disable=SC2034
argument=$'item - String. Optional. Thing to classify\n--help - Flag. Optional. Display this help.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Better type handling of shell objects\n\nOutputs one of `type` output or enhancements:\n- `builtin`, `function`, `alias`, `file`\n- `link-directory`, `link-file`, `link-dead`, `directory`, `integer`, `unknown`\n\n'
descriptionLineCount="6"
file="bin/build/tools/file.sh"
fn="fileType"
fnMarker="filetype"
foundNames=([0]="argument")
line="540"
rawComment=$'Argument: item - String. Optional. Thing to classify\nArgument: --help - Flag. Optional. Display this help.\nBetter type handling of shell objects\nOutputs one of `type` output or enhancements:\n- `builtin`, `function`, `alias`, `file`\n- `link-directory`, `link-file`, `link-dead`, `directory`, `integer`, `unknown`\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="1ddfd7452bcc3ae87f5e31f996487d77938a316d"
sourceLine="540"
summary="Better type handling of shell objects"
summaryComputed="true"
usage="fileType [ item ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileType'$'\e''[0m '$'\e''[[(blue)]m[ item ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mitem    '$'\e''[[(value)]mString. Optional. Thing to classify'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Better type handling of shell objects'$'\n'''$'\n''Outputs one of '$'\e''[[(code)]mtype'$'\e''[[(reset)]m output or enhancements:'$'\n''- '$'\e''[[(code)]mbuiltin'$'\e''[[(reset)]m, '$'\e''[[(code)]mfunction'$'\e''[[(reset)]m, '$'\e''[[(code)]malias'$'\e''[[(reset)]m, '$'\e''[[(code)]mfile'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mlink-directory'$'\e''[[(reset)]m, '$'\e''[[(code)]mlink-file'$'\e''[[(reset)]m, '$'\e''[[(code)]mlink-dead'$'\e''[[(reset)]m, '$'\e''[[(code)]mdirectory'$'\e''[[(reset)]m, '$'\e''[[(code)]minteger'$'\e''[[(reset)]m, '$'\e''[[(code)]munknown'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: fileType [ item ] [ --help ]'$'\n'''$'\n''    item    String. Optional. Thing to classify'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Better type handling of shell objects'$'\n'''$'\n''Outputs one of type output or enhancements:'$'\n''- builtin, function, alias, file'$'\n''- link-directory, link-file, link-dead, directory, integer, unknown'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/file.md"
