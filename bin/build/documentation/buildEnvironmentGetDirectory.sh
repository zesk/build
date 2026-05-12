#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.\n--subdirectory subdirectory - String. Optional. Name of a subdirectory to return "beneath" the value of environment variable. Created if the flag is set.\n--mode fileMode - String. Optional. Enforce the mode for `mkdir --mode` and `chmod`. Use special mode `-` to mean no mode enforcement.\n--owner ownerName - String. Optional. Enforce the owner of the directory. Use special ownerName `-` to mean no owner enforcement.\n--no-create - Flag. Optional. Do not create the subdirectory if it does not exist.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Load and print one or more environment settings which represents a directory which should be created.\n\nIf BOTH files exist, both are sourced, so application environments should anticipate values\ncreated by build\'s default.\n\nModifies local environment. Not usually run within a subshell.\n\n'
descriptionLineCount="7"
environment=$'$envName\nBUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files\n'
file="bin/build/tools/build.sh"
fn="buildEnvironmentGetDirectory"
fnMarker="buildenvironmentgetdirectory"
foundNames=([0]="argument" [1]="environment")
line="584"
rawComment=$'Load and print one or more environment settings which represents a directory which should be created.\nArgument: envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.\nArgument: --subdirectory subdirectory - String. Optional. Name of a subdirectory to return "beneath" the value of environment variable. Created if the flag is set.\nArgument: --mode fileMode - String. Optional. Enforce the mode for `mkdir --mode` and `chmod`. Use special mode `-` to mean no mode enforcement.\nArgument: --owner ownerName - String. Optional. Enforce the owner of the directory. Use special ownerName `-` to mean no owner enforcement.\nArgument: --no-create - Flag. Optional. Do not create the subdirectory if it does not exist.\nIf BOTH files exist, both are sourced, so application environments should anticipate values\ncreated by build\'s default.\nModifies local environment. Not usually run within a subshell.\nEnvironment: $envName\nEnvironment: BUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="50c41962b5ba48f0c8436d5b843a0620d876d061"
sourceLine="584"
summary="Load and print one or more environment settings which represents"
summaryComputed="true"
usage="buildEnvironmentGetDirectory [ envName ] [ --subdirectory subdirectory ] [ --mode fileMode ] [ --owner ownerName ] [ --no-create ]"
