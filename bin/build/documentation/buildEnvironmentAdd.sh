#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--force - Flag. Optional. Replace the existing file if it exists or create it if it does not."$'\n'"--quiet - Flag. Optional. No status messages."$'\n'"--verbose - Flag. Optional. Display status messages."$'\n'"--value value - String. Optional. Set the value to this fixed string in the file. Only valid when a single \`environmentName\` is used."$'\n'"environmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project."$'\n'""
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Adds an environment variable file to a project"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/build.sh"
fn="buildEnvironmentAdd"
fnMarker="buildenvironmentadd"
foundNames=([0]="argument")
line="319"
rawComment="Adds an environment variable file to a project"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --force - Flag. Optional. Replace the existing file if it exists or create it if it does not."$'\n'"Argument: --quiet - Flag. Optional. No status messages."$'\n'"Argument: --verbose - Flag. Optional. Display status messages."$'\n'"Argument: --value value - String. Optional. Set the value to this fixed string in the file. Only valid when a single \`environmentName\` is used."$'\n'"Argument: environmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="8814c5b6b68b94aa734c4c337d9463150c6d754d"
sourceLine="319"
summary="Adds an environment variable file to a project"
summaryComputed="true"
usage="buildEnvironmentAdd [ --help ] [ --force ] [ --quiet ] [ --verbose ] [ --value value ] environmentName ..."
