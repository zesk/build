#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Fetch the binary name for the default package in a group"$'\n'"Groups are:"$'\n'"- mysql"$'\n'"- mysqldump"$'\n'""$'\n'""
descriptionLineCount="5"
file="bin/build/tools/package.sh"
fn="packageDefault"
fnMarker="packagedefault"
foundNames=()
line="175"
rawComment="Fetch the binary name for the default package in a group"$'\n'"Groups are:"$'\n'"- mysql"$'\n'"- mysqldump"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="175"
summary="Fetch the binary name for the default package in a"
summaryComputed="true"
usage="packageDefault"
