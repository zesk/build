#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="filename ... - File. Optional. Docker environment file to convert."$'\n'""
base="convert.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"May take a list of files to convert or stdin piped in"$'\n'""$'\n'"Outputs bash-compatible entries to stdout"$'\n'"Any output to stdout is considered valid output"$'\n'"Any output to stderr is errors in the file but is written to be compatible with a bash"$'\n'""$'\n'""
descriptionLineCount="7"
file="bin/build/tools/environment/convert.sh"
fn="environmentFileDockerToBashCompatible"
fnMarker="environmentfiledockertobashcompatible"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="return_code")
line="116"
rawComment="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"May take a list of files to convert or stdin piped in"$'\n'"Outputs bash-compatible entries to stdout"$'\n'"Any output to stdout is considered valid output"$'\n'"Any output to stderr is errors in the file but is written to be compatible with a bash"$'\n'"Argument: filename ... - File. Optional. Docker environment file to convert."$'\n'"stdin: An environment file of any format"$'\n'"stdout: Environment file in Bash-compatible format"$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
return_code="1 - if errors occur"$'\n'"0 - if file is valid"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceHash="3b313a15b9ef0e13f864358aebfe683d919e1efc"
sourceLine="116"
stdin="An environment file of any format"$'\n'""
stdout="Environment file in Bash-compatible format"$'\n'""
summary="Ensure an environment file is compatible with non-quoted docker environment"
summaryComputed="true"
usage="environmentFileDockerToBashCompatible [ filename ... ]"
