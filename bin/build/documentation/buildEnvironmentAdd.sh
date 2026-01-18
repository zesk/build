#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"environmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project."$'\n'""
base="environment.sh"
description="Adds an environment variable file to a project"$'\n'""
file="bin/build/tools/environment.sh"
fn="buildEnvironmentAdd"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768695708"
summary="Adds an environment variable file to a project"
usage="buildEnvironmentAdd [ --help ] environmentName ..."
