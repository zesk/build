#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--env-file envFile - File. Optional. Environment file to load."$'\n'"--home homeDirectory - Directory. Optional. Directory for application home."$'\n'""
base="php.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Test a docker-based PHP application during build"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/php.sh"
fn="phpTest"
fnMarker="phptest"
foundNames=([0]="argument" [1]="hook")
hook="test-setup - Move or copy files prior to docker-compose build to build test container\""$'\n'"test-runner - Run PHP Unit and any other tests inside the container\""$'\n'"test-cleanup - Reverse of test-setup hook actions\""$'\n'""
line="336"
rawComment="Argument: --env-file envFile - File. Optional. Environment file to load."$'\n'"Argument: --home homeDirectory - Directory. Optional. Directory for application home."$'\n'"Test a docker-based PHP application during build"$'\n'"Hook: test-setup - Move or copy files prior to docker-compose build to build test container\""$'\n'"Hook: test-runner - Run PHP Unit and any other tests inside the container\""$'\n'"Hook: test-cleanup - Reverse of test-setup hook actions\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceHash="cd2691e7c6370ed405b6513e2b412ce1541ca05b"
sourceLine="336"
summary="Test a docker-based PHP application during build"
summaryComputed="true"
usage="phpTest [ --env-file envFile ] [ --home homeDirectory ]"
