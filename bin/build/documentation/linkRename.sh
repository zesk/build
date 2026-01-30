#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="from - Link. Required. Link to rename."$'\n'"to - FileDirectory. Required. New link path."$'\n'""
base="file.sh"
description="Rename a link"$'\n'"Renames a link forcing replacement, and works on different versions of \`mv\` which differs between systems."$'\n'""
file="bin/build/tools/file.sh"
foundNames=([0]="argument" [1]="see")
rawComment="Rename a link"$'\n'"Argument: from - Link. Required. Link to rename."$'\n'"Argument: to - FileDirectory. Required. New link path."$'\n'"Renames a link forcing replacement, and works on different versions of \`mv\` which differs between systems."$'\n'"See: mv"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="mv"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="5a3166bdcad258247586af970c54a4cbceb9dce7"
summary="Rename a link"
usage="linkRename from to"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlinkRename'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfrom'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mto'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfrom  '$'\e''[[(value)]mLink. Required. Link to rename.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mto    '$'\e''[[(value)]mFileDirectory. Required. New link path.'$'\e''[[(reset)]m'$'\n'''$'\n''Rename a link'$'\n''Renames a link forcing replacement, and works on different versions of '$'\e''[[(code)]mmv'$'\e''[[(reset)]m which differs between systems.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mlinkRename [[(magenta)]mfrom [[(magenta)]mto'$'\n'''$'\n''    [[(red)]mfrom  Link. Required. Link to rename.'$'\n''    [[(red)]mto    FileDirectory. Required. New link path.'$'\n'''$'\n''Rename a link'$'\n''Renames a link forcing replacement, and works on different versions of mv which differs between systems.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.623
