#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/usage.sh"
argument="usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"binary - Required. Binary which must have a \`which\` path."$'\n'""
base="usage.sh"
description="Return Code: 1 - If any \`binary\` is not available within the current path"$'\n'"Requires the binaries to be found via \`which\`"$'\n'""$'\n'"Runs \`handler\` on failure"$'\n'""$'\n'""
file="bin/build/tools/usage.sh"
fn="usageRequireBinary"
foundNames=([0]="summary" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/usage.sh"
sourceModified="1768695708"
summary="Check that one or more binaries are installed"$'\n'""
usage="usageRequireBinary usageFunction binary"
