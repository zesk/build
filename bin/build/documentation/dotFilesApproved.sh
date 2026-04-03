#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="listType - String. Optional. One of \`all\`, \`bash\`, \`git\`, \`darwin\`, or \`mysql\`"$'\n'""
base="prompt-modules.sh"
description="Lists of dot files which can be added to the dotFilesApprovedFile"$'\n'"If none specified, returns \`bash\` list."$'\n'"Special value \`all\` returns all values"$'\n'""
file="bin/build/tools/prompt-modules.sh"
fn="dotFilesApproved"
foundNames=([0]="argument")
rawComment="Lists of dot files which can be added to the dotFilesApprovedFile"$'\n'"Argument: listType - String. Optional. One of \`all\`, \`bash\`, \`git\`, \`darwin\`, or \`mysql\`"$'\n'"If none specified, returns \`bash\` list."$'\n'"Special value \`all\` returns all values"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt-modules.sh"
sourceHash="63eede76c5295636fbb5072c5ff56c4dea30564b"
summary="Lists of dot files which can be added to the"
summaryComputed="true"
usage="dotFilesApproved [ listType ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdotFilesApproved'$'\e''[0m '$'\e''[[(blue)]m[ listType ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mlistType  '$'\e''[[(value)]mString. Optional. One of '$'\e''[[(code)]mall'$'\e''[[(reset)]m, '$'\e''[[(code)]mbash'$'\e''[[(reset)]m, '$'\e''[[(code)]mgit'$'\e''[[(reset)]m, '$'\e''[[(code)]mdarwin'$'\e''[[(reset)]m, or '$'\e''[[(code)]mmysql'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Lists of dot files which can be added to the dotFilesApprovedFile'$'\n''If none specified, returns '$'\e''[[(code)]mbash'$'\e''[[(reset)]m list.'$'\n''Special value '$'\e''[[(code)]mall'$'\e''[[(reset)]m returns all values'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dotFilesApproved [ listType ]'$'\n'''$'\n''    listType  String. Optional. One of all, bash, git, darwin, or mysql'$'\n'''$'\n''Lists of dot files which can be added to the dotFilesApprovedFile'$'\n''If none specified, returns bash list.'$'\n''Special value all returns all values'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
