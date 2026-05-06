#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and \`export\`ed."$'\n'"--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"--all - Flag. Optional. Load all environment variables defined in BUILD_ENVIRONMENT_DIRS."$'\n'"--print - Flag. Print the environment file loaded first."$'\n'"--quiet - Flag. Optional. No error is displayed when an environment variable does not exist, but return code 1 is returned."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Load one or more environment settings from the environment file path."$'\n'""$'\n'"If BOTH files exist, both are sourced, so application environments should anticipate values"$'\n'"created by build's default."$'\n'""$'\n'"Modifies local environment. Not usually run within a subshell."$'\n'""$'\n'""
descriptionLineCount="7"
environment="BUILD_ENVIRONMENT_DIRS - \`:\` separated list of paths to load env files"$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentLoad"
fnMarker="buildenvironmentload"
foundNames=([0]="argument" [1]="return_code" [2]="environment")
line="389"
rawComment="Load one or more environment settings from the environment file path."$'\n'"Argument: envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and \`export\`ed."$'\n'"Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"Argument: --all - Flag. Optional. Load all environment variables defined in BUILD_ENVIRONMENT_DIRS."$'\n'"Argument: --print - Flag. Print the environment file loaded first."$'\n'"Argument: --quiet - Flag. Optional. No error is displayed when an environment variable does not exist, but return code 1 is returned."$'\n'"Return Code: 1 - The environment variable is not found."$'\n'"Return Code: 0 - The environment variable is found and the file was loaded (which *should* set to the global environment variable named)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"If BOTH files exist, both are sourced, so application environments should anticipate values"$'\n'"created by build's default."$'\n'"Modifies local environment. Not usually run within a subshell."$'\n'"Environment: BUILD_ENVIRONMENT_DIRS - \`:\` separated list of paths to load env files"$'\n'""$'\n'""
return_code="1 - The environment variable is not found."$'\n'"0 - The environment variable is found and the file was loaded (which *should* set to the global environment variable named)"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="8814c5b6b68b94aa734c4c337d9463150c6d754d"
sourceLine="389"
summary="Load one or more environment settings from the environment file"
summaryComputed="true"
usage="buildEnvironmentLoad [ envName ] [ --application applicationHome ] [ --all ] [ --print ] [ --quiet ] [ --help ]"
