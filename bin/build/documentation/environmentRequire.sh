#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'usageFunction - Required. `bash` function already defined to output handler\nenvironmentVariable - String. Optional. One or more environment variables which should be set and non-empty.\n'
base="usage.sh"
deprecated=$'2024-01-01\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Requires environment variables to be set and non-blank\n\n'
descriptionLineCount="2"
file="bin/build/tools/usage.sh"
fn="environmentRequire"
fnMarker="environmentrequire"
foundNames=([0]="argument" [1]="return_code" [2]="deprecated")
line="258"
rawComment=$'Requires environment variables to be set and non-blank\nArgument: usageFunction - Required. `bash` function already defined to output handler\nArgument: environmentVariable - String. Optional. One or more environment variables which should be set and non-empty.\nReturn Code: 0 - All environment variables are set and non-empty\nReturn Code: 1 - If any `environmentVariable` variables are not set or are empty.\nDeprecated: 2024-01-01\n\n'
return_code=$'0 - All environment variables are set and non-empty\n1 - If any `environmentVariable` variables are not set or are empty.\n'
sourceFile="bin/build/tools/usage.sh"
sourceHash="3291d7e64ccb36a84b9d6875ccfaa2cae11670fd"
sourceLine="258"
summary="Requires environment variables to be set and non-blank"
summaryComputed="true"
usage="environmentRequire usageFunction [ environmentVariable ]"
