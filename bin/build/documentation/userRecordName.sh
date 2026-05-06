#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'""
base="user.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Look user up, output user name"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/user.sh"
fn="userRecordName"
fnMarker="userrecordname"
foundNames=([0]="summary" [1]="stdout" [2]="file" [3]="argument")
line="58"
rawComment="Summary: Quick user database query of the user name"$'\n'"Look user up, output user name"$'\n'"stdout: the user name"$'\n'"File: /etc/passwd"$'\n'"Argument: user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"Argument: database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/user.sh"
sourceHash="748c273a0fe671ed2423893475bacc1706b94267"
sourceLine="58"
stdout="the user name"$'\n'""
summary="Quick user database query of the user name"
summaryComputed=""
usage="userRecordName [ user ] [ database ]"
