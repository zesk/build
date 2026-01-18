#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and \`export\`ed."$'\n'"--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"--all - Flag. Optional. Load all environment variables defined in BUILD_ENVIRONMENT_DIRS."$'\n'"--print - Flag. Print the environment file loaded first."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
description="Load one or more environment settings from the environment file path."$'\n'""$'\n'"If BOTH files exist, both are sourced, so application environments should anticipate values"$'\n'"created by build's default."$'\n'""$'\n'"Modifies local environment. Not usually run within a subshell."$'\n'""$'\n'""
environment="BUILD_ENVIRONMENT_DIRS - \`:\` separated list of paths to load env files"$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentLoad"
foundNames=([0]="argument" [1]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/build.sh"
sourceModified="1768721469"
summary="Load one or more environment settings from the environment file"
usage="buildEnvironmentLoad [ envName ] [ --application applicationHome ] [ --all ] [ --print ] [ --help ]"
