#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="binary - String. Required. Binary which will exist in PATH after \`group\` is installed if it does not exist."$'\n'"group - String. Required. Package group."$'\n'""
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install a package group to have a binary installed"$'\n'"Any unrecognized groups are installed using the name as-is."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/package.sh"
fn="packageGroupWhich"
fnMarker="packagegroupwhich"
foundNames=([0]="argument")
line="687"
rawComment="Install a package group to have a binary installed"$'\n'"Argument: binary - String. Required. Binary which will exist in PATH after \`group\` is installed if it does not exist."$'\n'"Argument: group - String. Required. Package group."$'\n'"Any unrecognized groups are installed using the name as-is."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="687"
summary="Install a package group to have a binary installed"
summaryComputed="true"
usage="packageGroupWhich binary group"
