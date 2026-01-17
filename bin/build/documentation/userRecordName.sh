#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/user.sh"
argument="user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'""
base="user.sh"
description="Look user up, output user name"$'\n'""
file="bin/build/tools/user.sh"
fn="userRecordName"
foundNames=([0]="summary" [1]="stdout" [2]="file" [3]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""$'\n'""$'\n'""
source="bin/build/tools/user.sh"
sourceModified="1768246145"
stdout="the user name"$'\n'""
summary="Quick user database query of the user name"$'\n'""
usage="userRecordName [ user ] [ database ]"
