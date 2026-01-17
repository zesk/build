#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt-modules.sh"
argument="listType - String. Optional. One of \`all\`, \`bash\`, \`git\`, \`darwin\`, or \`mysql\`"$'\n'""
base="prompt-modules.sh"
description="Lists of dot files which can be added to the dotFilesApprovedFile"$'\n'"If none specified, returns \`bash\` list."$'\n'"Special value \`all\` returns all values"$'\n'""
file="bin/build/tools/prompt-modules.sh"
fn="dotFilesApproved"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/prompt-modules.sh"
sourceModified="1768683853"
summary="Lists of dot files which can be added to the"
usage="dotFilesApproved [ listType ]"
