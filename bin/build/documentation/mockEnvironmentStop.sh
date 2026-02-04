#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="globalName ... - EnvironmentVariable. Required. Global to restore from the mocked saved value."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="test.sh"
description="Restore a mocked value. Works solely with the default \`saveGlobalName\` (e.g. \`__MOCK_\${globalName}\`)."$'\n'""
file="bin/build/tools/test.sh"
foundNames=([0]="argument")
rawComment="Restore a mocked value. Works solely with the default \`saveGlobalName\` (e.g. \`__MOCK_\${globalName}\`)."$'\n'"Argument: globalName ... - EnvironmentVariable. Required. Global to restore from the mocked saved value."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="3ada3b92753c9fb7ad54f96d764ea888ad800ab1"
summary="Restore a mocked value. Works solely with the default \`saveGlobalName\`"
summaryComputed="true"
usage="mockEnvironmentStop globalName ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmockEnvironmentStop'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mglobalName ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mglobalName ...  '$'\e''[[(value)]mEnvironmentVariable. Required. Global to restore from the mocked saved value.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help          '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Restore a mocked value. Works solely with the default '$'\e''[[(code)]msaveGlobalName'$'\e''[[(reset)]m (e.g. '$'\e''[[(code)]m__MOCK_${globalName}'$'\e''[[(reset)]m).'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: mockEnvironmentStop globalName ... [ --help ]'$'\n'''$'\n''    globalName ...  EnvironmentVariable. Required. Global to restore from the mocked saved value.'$'\n''    --help          Flag. Optional. Display this help.'$'\n'''$'\n''Restore a mocked value. Works solely with the default saveGlobalName (e.g. __MOCK_${globalName}).'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
