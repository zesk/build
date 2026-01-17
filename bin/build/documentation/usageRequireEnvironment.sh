#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/usage.sh"
argument="usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"environmentVariable - String. Optional. One or more environment variables which should be set and non-empty."$'\n'""
base="usage.sh"
deprecated="2024-01-01"$'\n'""
description="Requires environment variables to be set and non-blank"$'\n'"Return Code: 0 - All environment variables are set and non-empty"$'\n'"Return Code: 1 - If any \`environmentVariable\` variables are not set or are empty."$'\n'""$'\n'""
file="bin/build/tools/usage.sh"
fn="usageRequireEnvironment"
foundNames=([0]="argument" [1]="deprecated")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/usage.sh"
sourceModified="1768683999"
summary="Requires environment variables to be set and non-blank"
usage="usageRequireEnvironment usageFunction [ environmentVariable ]"
