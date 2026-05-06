#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="terraform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/terraform.sh"
fn="aptKeyRemoveHashicorp"
fnMarker="aptkeyremovehashicorp"
foundNames=([0]="argument" [1]="return_code")
line="33"
rawComment="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - All good to install terraform"$'\n'""$'\n'""
return_code="1 - if environment is awry"$'\n'"0 - All good to install terraform"$'\n'""
sourceFile="bin/build/tools/terraform.sh"
sourceHash="a4f8e3a7c7ca38d2b31358ac40b4ce3eafce0d6f"
sourceLine="33"
summary="Add keys to enable apt to download terraform directly from"
summaryComputed="true"
usage="aptKeyRemoveHashicorp [ --help ]"
