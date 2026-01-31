#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="test.sh"
description="Restore a mocked value. Works solely with the default \`saveGlobalName\` (e.g. \`__MOCK_\${globalName}\`)."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: globalName ... - EnvironmentVariable. Required. Global to restore from the mocked saved value."$'\n'""
file="bin/build/tools/test.sh"
foundNames=()
rawComment="Restore a mocked value. Works solely with the default \`saveGlobalName\` (e.g. \`__MOCK_\${globalName}\`)."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: globalName ... - EnvironmentVariable. Required. Global to restore from the mocked saved value."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="d5d12954f38b51540f87d67aa3d877d2c77a97bc"
summary="Restore a mocked value. Works solely with the default \`saveGlobalName\`"
usage="mockEnvironmentStop"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmockEnvironmentStop'$'\e''[0m'$'\n'''$'\n''Restore a mocked value. Works solely with the default '$'\e''[[(code)]msaveGlobalName'$'\e''[[(reset)]m (e.g. '$'\e''[[(code)]m__MOCK_${globalName}'$'\e''[[(reset)]m).'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: globalName ... - EnvironmentVariable. Required. Global to restore from the mocked saved value.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: mockEnvironmentStop'$'\n'''$'\n''Restore a mocked value. Works solely with the default saveGlobalName (e.g. __MOCK_${globalName}).'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: globalName ... - EnvironmentVariable. Required. Global to restore from the mocked saved value.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.452
