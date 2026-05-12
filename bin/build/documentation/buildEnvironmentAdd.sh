#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--force - Flag. Optional. Replace the existing file if it exists or create it if it does not.\n--quiet - Flag. Optional. No status messages.\n--verbose - Flag. Optional. Display status messages.\n--value value - String. Optional. Set the value to this fixed string in the file. Only valid when a single `environmentName` is used.\nenvironmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Adds an environment variable file to a project\n\n'
descriptionLineCount="2"
file="bin/build/tools/build.sh"
fn="buildEnvironmentAdd"
fnMarker="buildenvironmentadd"
foundNames=([0]="argument")
line="319"
rawComment=$'Adds an environment variable file to a project\nArgument: --help - Flag. Optional. Display this help.\nArgument: --force - Flag. Optional. Replace the existing file if it exists or create it if it does not.\nArgument: --quiet - Flag. Optional. No status messages.\nArgument: --verbose - Flag. Optional. Display status messages.\nArgument: --value value - String. Optional. Set the value to this fixed string in the file. Only valid when a single `environmentName` is used.\nArgument: environmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="50c41962b5ba48f0c8436d5b843a0620d876d061"
sourceLine="319"
summary="Adds an environment variable file to a project"
summaryComputed="true"
usage="buildEnvironmentAdd [ --help ] [ --force ] [ --quiet ] [ --verbose ] [ --value value ] environmentName ..."
