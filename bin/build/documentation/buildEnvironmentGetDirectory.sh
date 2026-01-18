#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and \`export\`ed."$'\n'"--subdirectory subdirectory - String. Optional. Name of a subdirectory to return \"beneath\" the value of environment variable. Created if the flag is set."$'\n'"--mode fileMode - String. Optional. Enforce the mode for \`mkdir --mode\` and \`chmod\`. Use special mode \`-\` to mean no mode enforcement."$'\n'"--owner ownerName - String. Optional. Enforce the owner of the directory. Use special ownerName \`-\` to mean no owner enforcement."$'\n'""
base="build.sh"
description="Load and print one or more environment settings which represents a directory which should be created."$'\n'""$'\n'"If BOTH files exist, both are sourced, so application environments should anticipate values"$'\n'"created by build's default."$'\n'""$'\n'"Modifies local environment. Not usually run within a subshell."$'\n'""$'\n'""$'\n'""
environment="\$envName"$'\n'"BUILD_ENVIRONMENT_DIRS - \`:\` separated list of paths to load env files"$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentGetDirectory"
foundNames=([0]="argument" [1]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/build.sh"
sourceModified="1768695708"
summary="Load and print one or more environment settings which represents"
usage="buildEnvironmentGetDirectory [ envName ] [ --subdirectory subdirectory ] [ --mode fileMode ] [ --owner ownerName ]"
