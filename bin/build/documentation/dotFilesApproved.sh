#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt-modules.sh"
argument="listType - String. Optional. One of \`all\`, \`bash\`, \`git\`, \`darwin\`, or \`mysql\`"$'\n'""
base="prompt-modules.sh"
description="Lists of dot files which can be added to the dotFilesApprovedFile"$'\n'"If none specified, returns \`bash\` list."$'\n'"Special value \`all\` returns all values"$'\n'""
file="bin/build/tools/prompt-modules.sh"
fn="dotFilesApproved"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt-modules.sh"
sourceModified="1769063211"
summary="Lists of dot files which can be added to the"
usage="dotFilesApproved [ listType ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdotFilesApproved[0m [94m[ listType ][0m

    [94mlistType  [1;97mString. Optional. One of [38;2;0;255;0;48;2;0;0;0mall[0m, [38;2;0;255;0;48;2;0;0;0mbash[0m, [38;2;0;255;0;48;2;0;0;0mgit[0m, [38;2;0;255;0;48;2;0;0;0mdarwin[0m, or [38;2;0;255;0;48;2;0;0;0mmysql[0m[0m

Lists of dot files which can be added to the dotFilesApprovedFile
If none specified, returns [38;2;0;255;0;48;2;0;0;0mbash[0m list.
Special value [38;2;0;255;0;48;2;0;0;0mall[0m returns all values

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dotFilesApproved [ listType ]

    listType  String. Optional. One of all, bash, git, darwin, or mysql

Lists of dot files which can be added to the dotFilesApprovedFile
If none specified, returns bash list.
Special value all returns all values

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
