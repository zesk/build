#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="from - Link. Required. Link to rename."$'\n'"to - FileDirectory. Required. New link path."$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Rename a link"$'\n'"Renames a link forcing replacement, and works on different versions of \`mv\` which differs between systems."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/file.sh"
fn="linkRename"
fnMarker="linkrename"
foundNames=([0]="argument" [1]="see")
line="442"
rawComment="Rename a link"$'\n'"Argument: from - Link. Required. Link to rename."$'\n'"Argument: to - FileDirectory. Required. New link path."$'\n'"Renames a link forcing replacement, and works on different versions of \`mv\` which differs between systems."$'\n'"See: mv"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="mv"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="442"
summary="Rename a link"
summaryComputed="true"
usage="linkRename from to"
