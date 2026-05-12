#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.\n--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.\n--all - Flag. Optional. Load all environment variables defined in BUILD_ENVIRONMENT_DIRS.\n--print - Flag. Print the environment file loaded first.\n--quiet - Flag. Optional. No error is displayed when an environment variable does not exist, but return code 1 is returned.\n--help - Flag. Optional. Display this help.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Load one or more environment settings from the environment file path.\n\nIf BOTH files exist, both are sourced, so application environments should anticipate values\ncreated by build\'s default.\n\nModifies local environment. Not usually run within a subshell.\n\n'
descriptionLineCount="7"
environment=$'BUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files\n'
file="bin/build/tools/build.sh"
fn="buildEnvironmentLoad"
fnMarker="buildenvironmentload"
foundNames=([0]="argument" [1]="return_code" [2]="environment")
line="389"
rawComment=$'Load one or more environment settings from the environment file path.\nArgument: envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.\nArgument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.\nArgument: --all - Flag. Optional. Load all environment variables defined in BUILD_ENVIRONMENT_DIRS.\nArgument: --print - Flag. Print the environment file loaded first.\nArgument: --quiet - Flag. Optional. No error is displayed when an environment variable does not exist, but return code 1 is returned.\nReturn Code: 1 - The environment variable is not found.\nReturn Code: 0 - The environment variable is found and the file was loaded (which *should* set to the global environment variable named)\nArgument: --help - Flag. Optional. Display this help.\nIf BOTH files exist, both are sourced, so application environments should anticipate values\ncreated by build\'s default.\nModifies local environment. Not usually run within a subshell.\nEnvironment: BUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files\n\n'
return_code=$'1 - The environment variable is not found.\n0 - The environment variable is found and the file was loaded (which *should* set to the global environment variable named)\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="50c41962b5ba48f0c8436d5b843a0620d876d061"
sourceLine="389"
summary="Load one or more environment settings from the environment file"
summaryComputed="true"
usage="buildEnvironmentLoad [ envName ] [ --application applicationHome ] [ --all ] [ --print ] [ --quiet ] [ --help ]"
