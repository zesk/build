#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/user.sh"
argument="index - PositiveInteger. Required. Index (1-based) of field to select."$'\n'"user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'""
base="user.sh"
description="Look user up, output a single user database record."$'\n'""
file="bin/build/tools/user.sh"
fn="userRecord"
foundNames=([0]="argument" [1]="summary" [2]="stdout" [3]="file" [4]="requires")
requires="grep cut returnMessage printf /etc/passwd whoami"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/user.sh"
sourceModified="1768246145"
stdout="String. Associated record with \`index\` and \`user\`."$'\n'""
summary="Quick user database look up"$'\n'""
usage="userRecord index [ user ] [ database ]"
