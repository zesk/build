#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Environment:"$'\n'"Output the list of environment variable names which can be loaded via \`buildEnvironmentLoad\` or \`buildEnvironmentGet\`"$'\n'""$'\n'""
descriptionLineCount="3"
environment="BUILD_ENVIRONMENT_DIRS BUILD_HOME"$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentNames"
fnMarker="buildenvironmentnames"
foundNames=([0]="summary" [1]="argument" [2]="requires" [3]="environment")
line="198"
rawComment="Summary: List known environment names"$'\n'"Environment:"$'\n'"Output the list of environment variable names which can be loaded via \`buildEnvironmentLoad\` or \`buildEnvironmentGet\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: convertValue _buildEnvironmentPath find sort read helpArgument catchEnvironment"$'\n'"Environment: BUILD_ENVIRONMENT_DIRS BUILD_HOME"$'\n'""$'\n'""
requires="convertValue _buildEnvironmentPath find sort read helpArgument catchEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="8814c5b6b68b94aa734c4c337d9463150c6d754d"
sourceLine="198"
summary="List known environment names"
summaryComputed=""
usage="buildEnvironmentNames [ --help ]"
