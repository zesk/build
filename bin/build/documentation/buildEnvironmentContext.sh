#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="contextStart - Directory. Required. Context in which the command should run."$'\n'"command ... - Required. Command to run in new context."$'\n'""
base="build.sh"
description="Run a command and ensure the build tools context matches the current project"$'\n'"Avoid infinite loops here, call down."$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentContext"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/build.sh"
sourceModified="1768695708"
summary="Run a command and ensure the build tools context matches"
usage="buildEnvironmentContext contextStart command ..."
