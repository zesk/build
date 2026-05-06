#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="index - PositiveInteger. Required. Index (1-based) of field to select."$'\n'"user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'""
base="user.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Look user up, output a single user database record."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/user.sh"
fn="userRecord"
fnMarker="userrecord"
foundNames=([0]="argument" [1]="summary" [2]="stdout" [3]="file" [4]="requires")
line="38"
rawComment="Argument: index - PositiveInteger. Required. Index (1-based) of field to select."$'\n'"Argument: user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"Argument: database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'"Summary: Quick user database look up"$'\n'"Look user up, output a single user database record."$'\n'"stdout: String. Associated record with \`index\` and \`user\`."$'\n'"File: /etc/passwd"$'\n'"Requires: grep cut returnMessage printf /etc/passwd whoami"$'\n'""$'\n'""
requires="grep cut returnMessage printf /etc/passwd whoami"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/user.sh"
sourceHash="748c273a0fe671ed2423893475bacc1706b94267"
sourceLine="38"
stdout="String. Associated record with \`index\` and \`user\`."$'\n'""
summary="Quick user database look up"
summaryComputed=""
usage="userRecord index [ user ] [ database ]"
