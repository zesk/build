#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="usage.sh"
description="Requires environment variables to be set and non-blank"$'\n'"Argument: usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"Argument: environmentVariable - String. Optional. One or more environment variables which should be set and non-empty."$'\n'"Return Code: 0 - All environment variables are set and non-empty"$'\n'"Return Code: 1 - If any \`environmentVariable\` variables are not set or are empty."$'\n'"Deprecated: 2024-01-01"$'\n'""
file="bin/build/tools/usage.sh"
foundNames=()
rawComment="Requires environment variables to be set and non-blank"$'\n'"Argument: usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"Argument: environmentVariable - String. Optional. One or more environment variables which should be set and non-empty."$'\n'"Return Code: 0 - All environment variables are set and non-empty"$'\n'"Return Code: 1 - If any \`environmentVariable\` variables are not set or are empty."$'\n'"Deprecated: 2024-01-01"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="ac3427c7ff1c70c560bb4ac0c164fb1f45f71bc5"
summary="Requires environment variables to be set and non-blank"
usage="usageRequireEnvironment"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]musageRequireEnvironment'$'\e''[0m'$'\n'''$'\n''Requires environment variables to be set and non-blank'$'\n''Argument: usageFunction - Required. '$'\e''[[(code)]mbash'$'\e''[[(reset)]m function already defined to output handler'$'\n''Argument: environmentVariable - String. Optional. One or more environment variables which should be set and non-empty.'$'\n''Return Code: 0 - All environment variables are set and non-empty'$'\n''Return Code: 1 - If any '$'\e''[[(code)]menvironmentVariable'$'\e''[[(reset)]m variables are not set or are empty.'$'\n''Deprecated: 2024-01-01'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: usageRequireEnvironment'$'\n'''$'\n''Requires environment variables to be set and non-blank'$'\n''Argument: usageFunction - Required. bash function already defined to output handler'$'\n''Argument: environmentVariable - String. Optional. One or more environment variables which should be set and non-empty.'$'\n''Return Code: 0 - All environment variables are set and non-empty'$'\n''Return Code: 1 - If any environmentVariable variables are not set or are empty.'$'\n''Deprecated: 2024-01-01'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.443
