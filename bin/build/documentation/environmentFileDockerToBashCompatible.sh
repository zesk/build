#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment/convert.sh"
argument="filename ... - File. Optional. Docker environment file to convert."$'\n'""
base="convert.sh"
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"May take a list of files to convert or stdin piped in"$'\n'""$'\n'"Outputs bash-compatible entries to stdout"$'\n'"Any output to stdout is considered valid output"$'\n'"Any output to stderr is errors in the file but is written to be compatible with a bash"$'\n'""$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
file="bin/build/tools/environment/convert.sh"
fn="environmentFileDockerToBashCompatible"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment/convert.sh"
sourceModified="1768683853"
stdin="An environment file of any format"$'\n'""
stdout="Environment file in Bash-compatible format"$'\n'""
summary="Ensure an environment file is compatible with non-quoted docker environment"
usage="environmentFileDockerToBashCompatible [ filename ... ]"
