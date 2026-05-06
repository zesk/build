#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="environmentName ... - EnvironmentVariable. Optional. A required environment variable name"$'\n'"-- - Separator. Optional. Separates requires from optional environment variables"$'\n'"optionalEnvironmentName ... - EnvironmentVariable. Optional. An optional environment variable name."$'\n'""
base="environment.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Display and validate application variables."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/environment.sh"
fn="environmentFileShow"
fnMarker="environmentfileshow"
foundNames=([0]="return_code" [1]="argument")
line="61"
rawComment="Display and validate application variables."$'\n'"Return Code: 1 - If any required application variables are blank, the function fails with an environment error"$'\n'"Return Code: 0 - All required application variables are non-blank"$'\n'"Argument: environmentName ... - EnvironmentVariable. Optional. A required environment variable name"$'\n'"Argument: -- - Separator. Optional. Separates requires from optional environment variables"$'\n'"Argument: optionalEnvironmentName ... - EnvironmentVariable. Optional. An optional environment variable name."$'\n'""$'\n'""
return_code="1 - If any required application variables are blank, the function fails with an environment error"$'\n'"0 - All required application variables are non-blank"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceHash="fd4da5f1d9a2c52100a1a281185a474bae9aba02"
sourceLine="61"
summary="Display and validate application variables."
summaryComputed="true"
usage="environmentFileShow [ environmentName ... ] [ -- ] [ optionalEnvironmentName ... ]"
