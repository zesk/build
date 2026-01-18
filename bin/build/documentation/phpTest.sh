#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php.sh"
argument="--env-file envFile - File. Optional.Environment file to load."$'\n'"--home homeDirectory - Directory. Optional.Directory for application home."$'\n'""
base="php.sh"
description="Test a docker-based PHP application during build"$'\n'""$'\n'""
file="bin/build/tools/php.sh"
fn="phpTest"
foundNames=([0]="argument" [1]="hook")
hook="test-setup - Move or copy files prior to docker-compose build to build test container\""$'\n'"test-runner - Run PHP Unit and any other tests inside the container\""$'\n'"test-cleanup - Reverse of test-setup hook actions\""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/php.sh"
sourceModified="1768695708"
summary="Test a docker-based PHP application during build"
usage="phpTest [ --env-file envFile ] [ --home homeDirectory ]"
