#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and \`export\`ed."$'\n'"--subdirectory subdirectory - String. Optional. Name of a subdirectory to return \"beneath\" the value of environment variable. Created if the flag is set."$'\n'"--mode fileMode - String. Optional. Enforce the mode for \`mkdir --mode\` and \`chmod\`. Use special mode \`-\` to mean no mode enforcement."$'\n'"--owner ownerName - String. Optional. Enforce the owner of the directory. Use special ownerName \`-\` to mean no owner enforcement."$'\n'"--no-create - Flag. Optional. Do not create the subdirectory if it does not exist."$'\n'""
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Load and print one or more environment settings which represents a directory which should be created."$'\n'""$'\n'"If BOTH files exist, both are sourced, so application environments should anticipate values"$'\n'"created by build's default."$'\n'""$'\n'"Modifies local environment. Not usually run within a subshell."$'\n'""$'\n'""
descriptionLineCount="7"
environment="\$envName"$'\n'"BUILD_ENVIRONMENT_DIRS - \`:\` separated list of paths to load env files"$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentGetDirectory"
fnMarker="buildenvironmentgetdirectory"
foundNames=([0]="argument" [1]="environment")
line="584"
rawComment="Load and print one or more environment settings which represents a directory which should be created."$'\n'"Argument: envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and \`export\`ed."$'\n'"Argument: --subdirectory subdirectory - String. Optional. Name of a subdirectory to return \"beneath\" the value of environment variable. Created if the flag is set."$'\n'"Argument: --mode fileMode - String. Optional. Enforce the mode for \`mkdir --mode\` and \`chmod\`. Use special mode \`-\` to mean no mode enforcement."$'\n'"Argument: --owner ownerName - String. Optional. Enforce the owner of the directory. Use special ownerName \`-\` to mean no owner enforcement."$'\n'"Argument: --no-create - Flag. Optional. Do not create the subdirectory if it does not exist."$'\n'"If BOTH files exist, both are sourced, so application environments should anticipate values"$'\n'"created by build's default."$'\n'"Modifies local environment. Not usually run within a subshell."$'\n'"Environment: \$envName"$'\n'"Environment: BUILD_ENVIRONMENT_DIRS - \`:\` separated list of paths to load env files"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="8814c5b6b68b94aa734c4c337d9463150c6d754d"
sourceLine="584"
summary="Load and print one or more environment settings which represents"
summaryComputed="true"
usage="buildEnvironmentGetDirectory [ envName ] [ --subdirectory subdirectory ] [ --mode fileMode ] [ --owner ownerName ] [ --no-create ]"
