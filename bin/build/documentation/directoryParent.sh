#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="directory.sh"
description="Finds a file above \`startingDirectory\`, uses \`testExpression\` to test (defaults to \`-d\`)"$'\n'"Argument: startingDirectory - Required. EmptyString|RealDirectory. Uses the current directory if blank."$'\n'"Argument: --pattern filePattern - RelativePath. Required. The file or directory to find the home for."$'\n'"Argument: --test testExpression - String. Optional. Zero or more. The \`test\` argument to test the targeted \`filePattern\`. By default uses \`-d\`."$'\n'""
file="bin/build/tools/directory.sh"
foundNames=()
rawComment="Finds a file above \`startingDirectory\`, uses \`testExpression\` to test (defaults to \`-d\`)"$'\n'"Argument: startingDirectory - Required. EmptyString|RealDirectory. Uses the current directory if blank."$'\n'"Argument: --pattern filePattern - RelativePath. Required. The file or directory to find the home for."$'\n'"Argument: --test testExpression - String. Optional. Zero or more. The \`test\` argument to test the targeted \`filePattern\`. By default uses \`-d\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="48944c2d998ec4950146d3ca4b1eba7cb335709c"
summary="Finds a file above \`startingDirectory\`, uses \`testExpression\` to test (defaults"
usage="directoryParent"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryParent'$'\e''[0m'$'\n'''$'\n''Finds a file above '$'\e''[[(code)]mstartingDirectory'$'\e''[[(reset)]m, uses '$'\e''[[(code)]mtestExpression'$'\e''[[(reset)]m to test (defaults to '$'\e''[[(code)]m-d'$'\e''[[(reset)]m)'$'\n''Argument: startingDirectory - Required. EmptyString|RealDirectory. Uses the current directory if blank.'$'\n''Argument: --pattern filePattern - RelativePath. Required. The file or directory to find the home for.'$'\n''Argument: --test testExpression - String. Optional. Zero or more. The '$'\e''[[(code)]mtest'$'\e''[[(reset)]m argument to test the targeted '$'\e''[[(code)]mfilePattern'$'\e''[[(reset)]m. By default uses '$'\e''[[(code)]m-d'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: directoryParent'$'\n'''$'\n''Finds a file above startingDirectory, uses testExpression to test (defaults to -d)'$'\n''Argument: startingDirectory - Required. EmptyString|RealDirectory. Uses the current directory if blank.'$'\n''Argument: --pattern filePattern - RelativePath. Required. The file or directory to find the home for.'$'\n''Argument: --test testExpression - String. Optional. Zero or more. The test argument to test the targeted filePattern. By default uses -d.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.486
