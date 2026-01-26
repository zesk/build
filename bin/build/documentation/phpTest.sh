#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php.sh"
argument="--env-file envFile - File. Optional. Environment file to load."$'\n'"--home homeDirectory - Directory. Optional. Directory for application home."$'\n'""
base="php.sh"
description="Test a docker-based PHP application during build"$'\n'""
file="bin/build/tools/php.sh"
foundNames=([0]="argument" [1]="hook")
hook="test-setup - Move or copy files prior to docker-compose build to build test container\""$'\n'"test-runner - Run PHP Unit and any other tests inside the container\""$'\n'"test-cleanup - Reverse of test-setup hook actions\""$'\n'""
rawComment="Argument: --env-file envFile - File. Optional. Environment file to load."$'\n'"Argument: --home homeDirectory - Directory. Optional. Directory for application home."$'\n'"Test a docker-based PHP application during build"$'\n'"Hook: test-setup - Move or copy files prior to docker-compose build to build test container\""$'\n'"Hook: test-runner - Run PHP Unit and any other tests inside the container\""$'\n'"Hook: test-cleanup - Reverse of test-setup hook actions\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceModified="1769324125"
summary="Test a docker-based PHP application during build"
usage="phpTest [ --env-file envFile ] [ --home homeDirectory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mphpTest'$'\e''[0m '$'\e''[[(blue)]m[ --env-file envFile ]'$'\e''[0m '$'\e''[[(blue)]m[ --home homeDirectory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--env-file envFile    '$'\e''[[(value)]mFile. Optional. Environment file to load.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--home homeDirectory  '$'\e''[[(value)]mDirectory. Optional. Directory for application home.'$'\e''[[(reset)]m'$'\n'''$'\n''Test a docker-based PHP application during build'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: phpTest [ --env-file envFile ] [ --home homeDirectory ]'$'\n'''$'\n''    --env-file envFile    File. Optional. Environment file to load.'$'\n''    --home homeDirectory  Directory. Optional. Directory for application home.'$'\n'''$'\n''Test a docker-based PHP application during build'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.576
