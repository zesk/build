#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="php.sh"
description="Argument: --env-file envFile - File. Optional. Environment file to load."$'\n'"Argument: --home homeDirectory - Directory. Optional. Directory for application home."$'\n'"Test a docker-based PHP application during build"$'\n'"Hook: test-setup - Move or copy files prior to docker-compose build to build test container\""$'\n'"Hook: test-runner - Run PHP Unit and any other tests inside the container\""$'\n'"Hook: test-cleanup - Reverse of test-setup hook actions\""$'\n'""
file="bin/build/tools/php.sh"
foundNames=()
rawComment="Argument: --env-file envFile - File. Optional. Environment file to load."$'\n'"Argument: --home homeDirectory - Directory. Optional. Directory for application home."$'\n'"Test a docker-based PHP application during build"$'\n'"Hook: test-setup - Move or copy files prior to docker-compose build to build test container\""$'\n'"Hook: test-runner - Run PHP Unit and any other tests inside the container\""$'\n'"Hook: test-cleanup - Reverse of test-setup hook actions\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceHash="f97f90ea1f46b8f2b14d5889c7debaf5d8e3000c"
summary="Argument: --env-file envFile - File. Optional. Environment file to load."
usage="phpTest"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mphpTest'$'\e''[0m'$'\n'''$'\n''Argument: --env-file envFile - File. Optional. Environment file to load.'$'\n''Argument: --home homeDirectory - Directory. Optional. Directory for application home.'$'\n''Test a docker-based PHP application during build'$'\n''Hook: test-setup - Move or copy files prior to docker-compose build to build test container"'$'\n''Hook: test-runner - Run PHP Unit and any other tests inside the container"'$'\n''Hook: test-cleanup - Reverse of test-setup hook actions"'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: phpTest'$'\n'''$'\n''Argument: --env-file envFile - File. Optional. Environment file to load.'$'\n''Argument: --home homeDirectory - Directory. Optional. Directory for application home.'$'\n''Test a docker-based PHP application during build'$'\n''Hook: test-setup - Move or copy files prior to docker-compose build to build test container"'$'\n''Hook: test-runner - Run PHP Unit and any other tests inside the container"'$'\n''Hook: test-cleanup - Reverse of test-setup hook actions"'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.467
