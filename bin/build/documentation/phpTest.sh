#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'--env-file envFile - File. Optional. Environment file to load.\n--home homeDirectory - Directory. Optional. Directory for application home.\n'
base="php.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Test a docker-based PHP application during build\n\n'
descriptionLineCount="2"
file="bin/build/tools/php.sh"
fn="phpTest"
fnMarker="phptest"
foundNames=([0]="argument" [1]="hook")
hook=$'test-setup - Move or copy files prior to docker-compose build to build test container"\ntest-runner - Run PHP Unit and any other tests inside the container"\ntest-cleanup - Reverse of test-setup hook actions"\n'
line="336"
rawComment=$'Argument: --env-file envFile - File. Optional. Environment file to load.\nArgument: --home homeDirectory - Directory. Optional. Directory for application home.\nTest a docker-based PHP application during build\nHook: test-setup - Move or copy files prior to docker-compose build to build test container"\nHook: test-runner - Run PHP Unit and any other tests inside the container"\nHook: test-cleanup - Reverse of test-setup hook actions"\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/php.sh"
sourceHash="378499878da6ebea46229658d82d5ab6d4d07b85"
sourceLine="336"
summary="Test a docker-based PHP application during build"
summaryComputed="true"
usage="phpTest [ --env-file envFile ] [ --home homeDirectory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mphpTest'$'\e''[0m '$'\e''[[(blue)]m[ --env-file envFile ]'$'\e''[0m '$'\e''[[(blue)]m[ --home homeDirectory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--env-file envFile    '$'\e''[[(value)]mFile. Optional. Environment file to load.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--home homeDirectory  '$'\e''[[(value)]mDirectory. Optional. Directory for application home.'$'\e''[[(reset)]m'$'\n'''$'\n''Test a docker-based PHP application during build'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: phpTest [ --env-file envFile ] [ --home homeDirectory ]'$'\n'''$'\n''    --env-file envFile    File. Optional. Environment file to load.'$'\n''    --home homeDirectory  Directory. Optional. Directory for application home.'$'\n'''$'\n''Test a docker-based PHP application during build'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/php.md"
