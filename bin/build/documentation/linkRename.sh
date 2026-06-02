#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-02
# shellcheck disable=SC2034
argument=$'from - Link. Required. Link to rename.\nto - FileDirectory. Required. New link path.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Rename a link\nRenames a link forcing replacement, and works on different versions of `mv` which differs between systems.\n\n'
descriptionLineCount="3"
file="bin/build/tools/file.sh"
fn="linkRename"
fnMarker="linkrename"
foundNames=([0]="argument" [1]="see")
line="579"
rawComment=$'Rename a link\nArgument: from - Link. Required. Link to rename.\nArgument: to - FileDirectory. Required. New link path.\nRenames a link forcing replacement, and works on different versions of `mv` which differs between systems.\nSee: mv\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'mv\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="1ddfd7452bcc3ae87f5e31f996487d77938a316d"
sourceLine="579"
summary="Rename a link"
summaryComputed="true"
usage="linkRename from to"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlinkRename'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfrom'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mto'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfrom  '$'\e''[[(value)]mLink. Required. Link to rename.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mto    '$'\e''[[(value)]mFileDirectory. Required. New link path.'$'\e''[[(reset)]m'$'\n'''$'\n''Rename a link'$'\n''Renames a link forcing replacement, and works on different versions of '$'\e''[[(code)]mmv'$'\e''[[(reset)]m which differs between systems.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: linkRename from to'$'\n'''$'\n''    from  Link. Required. Link to rename.'$'\n''    to    FileDirectory. Required. New link path.'$'\n'''$'\n''Rename a link'$'\n''Renames a link forcing replacement, and works on different versions of mv which differs between systems.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/file.md"
