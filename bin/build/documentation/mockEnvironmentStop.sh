#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"globalName ... - EnvironmentVariable. Required. Global to restore from the mocked saved value."$'\n'""
base="test.sh"
description="Restore a mocked value. Works solely with the default \`saveGlobalName\` (e.g. \`__MOCK_\${globalName}\`)."$'\n'""
file="bin/build/tools/test.sh"
foundNames=([0]="argument")
rawComment="Restore a mocked value. Works solely with the default \`saveGlobalName\` (e.g. \`__MOCK_\${globalName}\`)."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: globalName ... - EnvironmentVariable. Required. Global to restore from the mocked saved value."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="39704e552c45a3f31ac90c8d6dbc887ea13290f6"
summary="Restore a mocked value. Works solely with the default \`saveGlobalName\`"
usage="mockEnvironmentStop [ --help ] globalName ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmockEnvironmentStop'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mglobalName ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help          '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mglobalName ...  '$'\e''[[(value)]mEnvironmentVariable. Required. Global to restore from the mocked saved value.'$'\e''[[(reset)]m'$'\n'''$'\n''Restore a mocked value. Works solely with the default '$'\e''[[(code)]msaveGlobalName'$'\e''[[(reset)]m (e.g. '$'\e''[[(code)]m__MOCK_${globalName}'$'\e''[[(reset)]m).'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: mockEnvironmentStop [ --help ] globalName ...'$'\n'''$'\n''    --help          Flag. Optional. Display this help.'$'\n''    globalName ...  EnvironmentVariable. Required. Global to restore from the mocked saved value.'$'\n'''$'\n''Restore a mocked value. Works solely with the default saveGlobalName (e.g. __MOCK_${globalName}).'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.588
