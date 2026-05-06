#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"binary - Required. Binary which must have a \`which\` path."$'\n'""
base="usage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Requires the binaries to be found via \`which\`"$'\n'""$'\n'"Runs \`handler\` on failure"$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/usage.sh"
fn="executableRequire"
fnMarker="executablerequire"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="232"
rawComment="Summary: Check that one or more binaries are installed"$'\n'"Argument: usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"Argument: binary - Required. Binary which must have a \`which\` path."$'\n'"Return Code: 1 - If any \`binary\` is not available within the current path"$'\n'"Requires the binaries to be found via \`which\`"$'\n'"Runs \`handler\` on failure"$'\n'""$'\n'""
return_code="1 - If any \`binary\` is not available within the current path"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="d422aa5ba72eb3aa919a918c054e1c085f507523"
sourceLine="232"
summary="Check that one or more binaries are installed"
summaryComputed=""
usage="executableRequire usageFunction binary"
