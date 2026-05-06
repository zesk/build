#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Determine the default package manager on this platform."$'\n'"Output is one of:"$'\n'"- apk apt brew port"$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/package.sh"
fn="packageManagerDefault"
fnMarker="packagemanagerdefault"
foundNames=([0]="see")
line="625"
rawComment="Determine the default package manager on this platform."$'\n'"Output is one of:"$'\n'"- apk apt brew port"$'\n'"See: platform"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="platform"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="625"
summary="Determine the default package manager on this platform."
summaryComputed="true"
usage="packageManagerDefault"
