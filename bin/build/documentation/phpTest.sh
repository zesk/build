#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php.sh"
argument="--env-file envFile - File. Optional. Environment file to load."$'\n'"--home homeDirectory - Directory. Optional. Directory for application home."$'\n'""
base="php.sh"
description="Test a docker-based PHP application during build"$'\n'""$'\n'""
file="bin/build/tools/php.sh"
fn="phpTest"
foundNames=""
hook="test-setup - Move or copy files prior to docker-compose build to build test container\""$'\n'"test-runner - Run PHP Unit and any other tests inside the container\""$'\n'"test-cleanup - Reverse of test-setup hook actions\""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceModified="1768759583"
summary="Test a docker-based PHP application during build"
usage="phpTest [ --env-file envFile ] [ --home homeDirectory ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mphpTest[0m [94m[ --env-file envFile ][0m [94m[ --home homeDirectory ][0m

    [94m--env-file envFile    [1;97mFile. Optional. Environment file to load.[0m
    [94m--home homeDirectory  [1;97mDirectory. Optional. Directory for application home.[0m

Test a docker-based PHP application during build

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: phpTest [ --env-file envFile ] [ --home homeDirectory ]

    --env-file envFile    File. Optional. Environment file to load.
    --home homeDirectory  Directory. Optional. Directory for application home.

Test a docker-based PHP application during build

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
