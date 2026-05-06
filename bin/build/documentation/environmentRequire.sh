#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"environmentVariable - String. Optional. One or more environment variables which should be set and non-empty."$'\n'""
base="usage.sh"
deprecated="2024-01-01"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Requires environment variables to be set and non-blank"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/usage.sh"
fn="environmentRequire"
fnMarker="environmentrequire"
foundNames=([0]="argument" [1]="return_code" [2]="deprecated")
line="258"
rawComment="Requires environment variables to be set and non-blank"$'\n'"Argument: usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"Argument: environmentVariable - String. Optional. One or more environment variables which should be set and non-empty."$'\n'"Return Code: 0 - All environment variables are set and non-empty"$'\n'"Return Code: 1 - If any \`environmentVariable\` variables are not set or are empty."$'\n'"Deprecated: 2024-01-01"$'\n'""$'\n'""
return_code="0 - All environment variables are set and non-empty"$'\n'"1 - If any \`environmentVariable\` variables are not set or are empty."$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="d422aa5ba72eb3aa919a918c054e1c085f507523"
sourceLine="258"
summary="Requires environment variables to be set and non-blank"
summaryComputed="true"
usage="environmentRequire usageFunction [ environmentVariable ]"
