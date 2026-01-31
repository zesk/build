#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="environment.sh"
description="Display and validate application variables."$'\n'"Return Code: 1 - If any required application variables are blank, the function fails with an environment error"$'\n'"Return Code: 0 - All required application variables are non-blank"$'\n'"Argument: environmentName - EnvironmentVariable. Optional. A required environment variable name"$'\n'"Argument: -- - Separator. Optional. Separates requires from optional environment variables"$'\n'"Argument: optionalEnvironmentName - EnvironmentVariable. Optional. An optional environment variable name."$'\n'""
file="bin/build/tools/environment.sh"
foundNames=()
rawComment="Display and validate application variables."$'\n'"Return Code: 1 - If any required application variables are blank, the function fails with an environment error"$'\n'"Return Code: 0 - All required application variables are non-blank"$'\n'"Argument: environmentName - EnvironmentVariable. Optional. A required environment variable name"$'\n'"Argument: -- - Separator. Optional. Separates requires from optional environment variables"$'\n'"Argument: optionalEnvironmentName - EnvironmentVariable. Optional. An optional environment variable name."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceHash="4226efba8a29858c837cfce31f7416e4226eaa32"
summary="Display and validate application variables."
usage="environmentFileShow"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentFileShow'$'\e''[0m'$'\n'''$'\n''Display and validate application variables.'$'\n''Return Code: 1 - If any required application variables are blank, the function fails with an environment error'$'\n''Return Code: 0 - All required application variables are non-blank'$'\n''Argument: environmentName - EnvironmentVariable. Optional. A required environment variable name'$'\n''Argument: -- - Separator. Optional. Separates requires from optional environment variables'$'\n''Argument: optionalEnvironmentName - EnvironmentVariable. Optional. An optional environment variable name.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileShow'$'\n'''$'\n''Display and validate application variables.'$'\n''Return Code: 1 - If any required application variables are blank, the function fails with an environment error'$'\n''Return Code: 0 - All required application variables are non-blank'$'\n''Argument: environmentName - EnvironmentVariable. Optional. A required environment variable name'$'\n''Argument: -- - Separator. Optional. Separates requires from optional environment variables'$'\n''Argument: optionalEnvironmentName - EnvironmentVariable. Optional. An optional environment variable name.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.428
