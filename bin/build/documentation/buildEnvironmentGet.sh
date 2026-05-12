#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.\n--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.\n--quiet - Flag. Optional. No error is displayed when an environment variable does not exist, but return code 1 is returned.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Load and print one or more environment settings\n\nIf BOTH files exist, both are sourced, so application environments should anticipate values\ncreated by build\'s default.\nModifies local environment. Not usually run within a subshell.\n\n'
descriptionLineCount="6"
environment=$'$envName\nBUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files\n'
file="bin/build/tools/build.sh"
fn="buildEnvironmentGet"
fnMarker="buildenvironmentget"
foundNames=([0]="argument" [1]="return_code" [2]="stdout" [3]="environment")
line="538"
rawComment=$'Load and print one or more environment settings\nArgument: envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.\nArgument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.\nArgument: --quiet - Flag. Optional. No error is displayed when an environment variable does not exist, but return code 1 is returned.\nIf BOTH files exist, both are sourced, so application environments should anticipate values\ncreated by build\'s default.\nReturn Code: 1 - The environment variable is not found.\nReturn Code: 0 - The environment variable is found and the value was output to `stdout`\nstdout: The environment variable(s) requested, one per line\nModifies local environment. Not usually run within a subshell.\nEnvironment: $envName\nEnvironment: BUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files\n\n'
return_code=$'1 - The environment variable is not found.\n0 - The environment variable is found and the value was output to `stdout`\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="50c41962b5ba48f0c8436d5b843a0620d876d061"
sourceLine="538"
stdout=$'The environment variable(s) requested, one per line\n'
summary="Load and print one or more environment settings"
summaryComputed="true"
usage="buildEnvironmentGet [ envName ] [ --application applicationHome ] [ --quiet ]"
