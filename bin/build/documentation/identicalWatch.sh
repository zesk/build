#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"... - Arguments. Required. Arguments to \`identicalCheck\` for your watch."$'\n'""
base="identical.sh"
description="Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution."$'\n'"Still a known bug which trims the last end bracket from files"$'\n'""
file="bin/build/tools/identical.sh"
fn="identicalWatch"
foundNames=([0]="argument")
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: ... - Arguments. Required. Arguments to \`identicalCheck\` for your watch."$'\n'"Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution."$'\n'"Still a known bug which trims the last end bracket from files"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/identical.sh"
sourceHash="3d17e0e52d21bf0984ad94f99e9132c29a6aaed3"
summary="Watch a project for changes and propagate them immediately upon"
summaryComputed="true"
usage="identicalWatch [ --help ] [ --handler handler ] ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]midenticalWatch'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m...                '$'\e''[[(value)]mArguments. Required. Arguments to '$'\e''[[(code)]midenticalCheck'$'\e''[[(reset)]m for your watch.'$'\e''[[(reset)]m'$'\n'''$'\n''Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution.'$'\n''Still a known bug which trims the last end bracket from files'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: identicalWatch [ --help ] [ --handler handler ] ...'$'\n'''$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    ...                Arguments. Required. Arguments to identicalCheck for your watch.'$'\n'''$'\n''Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution.'$'\n''Still a known bug which trims the last end bracket from files'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
