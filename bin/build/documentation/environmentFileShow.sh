#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="environmentName - EnvironmentVariable. Optional. A required environment variable name"$'\n'"-- - Separator. Optional. Separates requires from optional environment variables"$'\n'"optionalEnvironmentName - EnvironmentVariable. Optional. An optional environment variable name."$'\n'""
base="environment.sh"
description="Display and validate application variables."$'\n'""
file="bin/build/tools/environment.sh"
foundNames=([0]="return_code" [1]="argument")
rawComment="Display and validate application variables."$'\n'"Return Code: 1 - If any required application variables are blank, the function fails with an environment error"$'\n'"Return Code: 0 - All required application variables are non-blank"$'\n'"Argument: environmentName - EnvironmentVariable. Optional. A required environment variable name"$'\n'"Argument: -- - Separator. Optional. Separates requires from optional environment variables"$'\n'"Argument: optionalEnvironmentName - EnvironmentVariable. Optional. An optional environment variable name."$'\n'""$'\n'""
return_code="1 - If any required application variables are blank, the function fails with an environment error"$'\n'"0 - All required application variables are non-blank"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769451204"
summary="Display and validate application variables."
usage="environmentFileShow [ environmentName ] [ -- ] [ optionalEnvironmentName ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentFileShow'$'\e''[0m '$'\e''[[(blue)]m[ environmentName ]'$'\e''[0m '$'\e''[[(blue)]m[ -- ]'$'\e''[0m '$'\e''[[(blue)]m[ optionalEnvironmentName ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]menvironmentName          '$'\e''[[(value)]mEnvironmentVariable. Optional. A required environment variable name'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--                       '$'\e''[[(value)]mSeparator. Optional. Separates requires from optional environment variables'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]moptionalEnvironmentName  '$'\e''[[(value)]mEnvironmentVariable. Optional. An optional environment variable name.'$'\e''[[(reset)]m'$'\n'''$'\n''Display and validate application variables.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If any required application variables are blank, the function fails with an environment error'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All required application variables are non-blank'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileShow [ environmentName ] [ -- ] [ optionalEnvironmentName ]'$'\n'''$'\n''    environmentName          EnvironmentVariable. Optional. A required environment variable name'$'\n''    --                       Separator. Optional. Separates requires from optional environment variables'$'\n''    optionalEnvironmentName  EnvironmentVariable. Optional. An optional environment variable name.'$'\n'''$'\n''Display and validate application variables.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If any required application variables are blank, the function fails with an environment error'$'\n''- 0 - All required application variables are non-blank'$'\n'''
# elapsed 0.43
