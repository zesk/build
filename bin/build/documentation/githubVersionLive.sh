#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n--name name - String. Optional. GitHub repository name to use. If not specified, uses `{env:GITHUB_REPOSITORY_NAME}`.\n--owner owner - String. Optional. GitHub repository owner to use. If not specified, uses `{env:GITHUB_REPOSITORY_OWNER}`.\n'
base="github.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Fetch the current live version of software using GitHub APIs\n\n'
descriptionLineCount="2"
environment=$'GITHUB_REPOSITORY_OWNER\nGITHUB_REPOSITORY_NAME\n'
file="bin/build/tools/github.sh"
fn="githubVersionLive"
fnMarker="githubversionlive"
foundNames=([0]="argument" [1]="environment")
line="328"
original="githubVersionLive"
rawComment=$'Fetch the current live version of software using GitHub APIs\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: --name name - String. Optional. GitHub repository name to use. If not specified, uses `{env:GITHUB_REPOSITORY_NAME}`.\nArgument: --owner owner - String. Optional. GitHub repository owner to use. If not specified, uses `{env:GITHUB_REPOSITORY_OWNER}`.\nEnvironment: GITHUB_REPOSITORY_OWNER\nEnvironment: GITHUB_REPOSITORY_NAME\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/github.sh"
sourceHash="9f85a7c547f753beb3c8eab96c8971ada032c885"
sourceLine="328"
summary="Fetch the current live version of software using GitHub APIs"
summaryComputed="true"
usage="githubVersionLive [ --help ] [ --handler handler ] [ --name name ] [ --owner owner ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgithubVersionLive'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(blue)]m[ --name name ]'$'\e''[0m '$'\e''[[(blue)]m[ --owner owner ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--name name        '$'\e''[[(value)]mString. Optional. GitHub repository name to use. If not specified, uses '$'\e''[[(code)]m{env:GITHUB_REPOSITORY_NAME}'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--owner owner      '$'\e''[[(value)]mString. Optional. GitHub repository owner to use. If not specified, uses '$'\e''[[(code)]m{env:GITHUB_REPOSITORY_OWNER}'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Fetch the current live version of software using GitHub APIs'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- GITHUB_REPOSITORY_OWNER'$'\n''- GITHUB_REPOSITORY_NAME'
# shellcheck disable=SC2016
helpPlain='Usage: githubVersionLive [ --help ] [ --handler handler ] [ --name name ] [ --owner owner ]'$'\n'''$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    --name name        String. Optional. GitHub repository name to use. If not specified, uses {env:GITHUB_REPOSITORY_NAME}.'$'\n''    --owner owner      String. Optional. GitHub repository owner to use. If not specified, uses {env:GITHUB_REPOSITORY_OWNER}.'$'\n'''$'\n''Fetch the current live version of software using GitHub APIs'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- GITHUB_REPOSITORY_OWNER'$'\n''- GITHUB_REPOSITORY_NAME'
documentationPath="documentation/source/tools/github.md"
