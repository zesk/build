#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Rename a link"$'\n'"Argument: from - Link. Required. Link to rename."$'\n'"Argument: to - FileDirectory. Required. New link path."$'\n'"Renames a link forcing replacement, and works on different versions of \`mv\` which differs between systems."$'\n'"See: mv"$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Rename a link"$'\n'"Argument: from - Link. Required. Link to rename."$'\n'"Argument: to - FileDirectory. Required. New link path."$'\n'"Renames a link forcing replacement, and works on different versions of \`mv\` which differs between systems."$'\n'"See: mv"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Rename a link"
usage="linkRename"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlinkRename'$'\e''[0m'$'\n'''$'\n''Rename a link'$'\n''Argument: from - Link. Required. Link to rename.'$'\n''Argument: to - FileDirectory. Required. New link path.'$'\n''Renames a link forcing replacement, and works on different versions of '$'\e''[[(code)]mmv'$'\e''[[(reset)]m which differs between systems.'$'\n''See: mv'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: linkRename'$'\n'''$'\n''Rename a link'$'\n''Argument: from - Link. Required. Link to rename.'$'\n''Argument: to - FileDirectory. Required. New link path.'$'\n''Renames a link forcing replacement, and works on different versions of mv which differs between systems.'$'\n''See: mv'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.43
