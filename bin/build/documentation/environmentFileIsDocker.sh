#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="filename - Docker environment file to check for common issues"$'\n'""
base="convert.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/environment/convert.sh"
fn="environmentFileIsDocker"
fnMarker="environmentfileisdocker"
foundNames=([0]="argument" [1]="return_code")
line="16"
rawComment="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"Argument: filename - Docker environment file to check for common issues"$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
return_code="1 - if errors occur"$'\n'"0 - if file is valid"$'\n'""
sourceFile="bin/build/tools/environment/convert.sh"
sourceHash="3b313a15b9ef0e13f864358aebfe683d919e1efc"
sourceLine="16"
summary="Ensure an environment file is compatible with non-quoted docker environment"
summaryComputed="true"
usage="environmentFileIsDocker [ filename ]"
