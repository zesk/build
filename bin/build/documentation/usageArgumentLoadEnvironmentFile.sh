#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deprecated.sh"
argument="usageFunction - Function. Required. Run if handler fails"$'\n'"variableName - String. Required. Name of variable being tested"$'\n'"variableValue - String. Required. Required. only in that if it's blank, it fails."$'\n'"noun - String. Optional. Noun used to describe the argument in errors, defaults to \`file\`"$'\n'""
base="deprecated.sh"
description="Validates a value is not blank and is an environment file which is loaded immediately."$'\n'""$'\n'"Return Code: 2 - Argument error"$'\n'"Return Code: 0 - Success"$'\n'"Upon success, outputs the file name to stdout, outputs a console message to stderr"$'\n'""
file="bin/build/tools/deprecated.sh"
fn="usageArgumentLoadEnvironmentFile"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/deprecated.sh"
summary="Validates a value is not blank and is an environment"
usage="usageArgumentLoadEnvironmentFile usageFunction variableName variableValue [ noun ]"
