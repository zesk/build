#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="listType - String. Optional. One of \`all\`, \`bash\`, \`git\`, \`darwin\`, or \`mysql\`"$'\n'""
base="prompt-modules.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Lists of dot files which can be added to the dotFilesApprovedFile"$'\n'"If none specified, returns \`bash\` list."$'\n'"Special value \`all\` returns all values"$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/prompt-modules.sh"
fn="dotFilesApproved"
fnMarker="dotfilesapproved"
foundNames=([0]="argument")
line="119"
rawComment="Lists of dot files which can be added to the dotFilesApprovedFile"$'\n'"Argument: listType - String. Optional. One of \`all\`, \`bash\`, \`git\`, \`darwin\`, or \`mysql\`"$'\n'"If none specified, returns \`bash\` list."$'\n'"Special value \`all\` returns all values"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt-modules.sh"
sourceHash="88deb9ee5685724c1450f2249c6ebd6a9df5a223"
sourceLine="119"
summary="Lists of dot files which can be added to the"
summaryComputed="true"
usage="dotFilesApproved [ listType ]"
