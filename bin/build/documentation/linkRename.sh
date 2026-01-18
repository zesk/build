#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="from - Link. Required. Link to rename."$'\n'"to - FileDirectory. Required. New link path."$'\n'""
base="file.sh"
description="Rename a link"$'\n'"Renames a link forcing replacement, and works on different versions of \`mv\` which differs between systems."$'\n'""
file="bin/build/tools/file.sh"
fn="linkRename"
foundNames=([0]="argument" [1]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="mv"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768695708"
summary="Rename a link"
usage="linkRename from to"
