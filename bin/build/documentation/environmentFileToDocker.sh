#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="envFile ... - File. Required. One or more files to convert."$'\n'""
base="convert.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Takes any environment file and makes it docker-compatible"$'\n'""$'\n'"Outputs the compatible env to stdout"$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/environment/convert.sh"
fn="environmentFileToDocker"
fnMarker="environmentfiletodocker"
foundNames=([0]="argument")
line="78"
rawComment="Takes any environment file and makes it docker-compatible"$'\n'"Outputs the compatible env to stdout"$'\n'"Argument: envFile ... - File. Required. One or more files to convert."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceHash="3b313a15b9ef0e13f864358aebfe683d919e1efc"
sourceLine="78"
summary="Takes any environment file and makes it docker-compatible"
summaryComputed="true"
usage="environmentFileToDocker envFile ..."
