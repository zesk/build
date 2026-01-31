#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"environmentVariable - String. Optional. One or more environment variables which should be set and non-empty."$'\n'""
base="usage.sh"
deprecated="2024-01-01"$'\n'""
description="Requires environment variables to be set and non-blank"$'\n'""
file="bin/build/tools/usage.sh"
foundNames=([0]="argument" [1]="return_code" [2]="deprecated")
rawComment="Requires environment variables to be set and non-blank"$'\n'"Argument: usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"Argument: environmentVariable - String. Optional. One or more environment variables which should be set and non-empty."$'\n'"Return Code: 0 - All environment variables are set and non-empty"$'\n'"Return Code: 1 - If any \`environmentVariable\` variables are not set or are empty."$'\n'"Deprecated: 2024-01-01"$'\n'""$'\n'""
return_code="0 - All environment variables are set and non-empty"$'\n'"1 - If any \`environmentVariable\` variables are not set or are empty."$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="ac3427c7ff1c70c560bb4ac0c164fb1f45f71bc5"
summary="Requires environment variables to be set and non-blank"
usage="usageRequireEnvironment usageFunction [ environmentVariable ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]musageRequireEnvironment'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]musageFunction'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ environmentVariable ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]musageFunction        '$'\e''[[(value)]mRequired. '$'\e''[[(code)]mbash'$'\e''[[(reset)]m function already defined to output handler'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]menvironmentVariable  '$'\e''[[(value)]mString. Optional. One or more environment variables which should be set and non-empty.'$'\e''[[(reset)]m'$'\n'''$'\n''Requires environment variables to be set and non-blank'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All environment variables are set and non-empty'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If any '$'\e''[[(code)]menvironmentVariable'$'\e''[[(reset)]m variables are not set or are empty.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: usageRequireEnvironment usageFunction [ environmentVariable ]'$'\n'''$'\n''    usageFunction        Required. bash function already defined to output handler'$'\n''    environmentVariable  String. Optional. One or more environment variables which should be set and non-empty.'$'\n'''$'\n''Requires environment variables to be set and non-blank'$'\n'''$'\n''Return codes:'$'\n''- 0 - All environment variables are set and non-empty'$'\n''- 1 - If any environmentVariable variables are not set or are empty.'$'\n'''
# elapsed 0.677
