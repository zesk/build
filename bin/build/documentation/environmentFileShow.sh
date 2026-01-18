#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="environmentName - EnvironmentVariable. Optional. A required environment variable name"$'\n'"-- - Separator. Optional. Separates requires from optional environment variables"$'\n'"optionalEnvironmentName - EnvironmentVariable. Optional. An optional environment variable name."$'\n'""
base="environment.sh"
description="Display and validate application variables."$'\n'"Return Code: 1 - If any required application variables are blank, the function fails with an environment error"$'\n'"Return Code: 0 - All required application variables are non-blank"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentFileShow"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768756695"
summary="Display and validate application variables."
usage="environmentFileShow [ environmentName ] [ -- ] [ optionalEnvironmentName ]"
