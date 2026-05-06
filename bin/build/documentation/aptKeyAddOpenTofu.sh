#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="tofu.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Add keys to enable apt to download tofu directly from opentofu.org"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/tofu.sh"
fn="aptKeyAddOpenTofu"
fnMarker="aptkeyaddopentofu"
foundNames=([0]="argument" [1]="return_code" [2]="see")
line="19"
rawComment="Add keys to enable apt to download tofu directly from opentofu.org"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - All good to install terraform"$'\n'"See: aptKeyRemoveOpenTofu"$'\n'""$'\n'""
return_code="1 - if environment is awry"$'\n'"0 - All good to install terraform"$'\n'""
see="aptKeyRemoveOpenTofu"$'\n'""
sourceFile="bin/build/tools/tofu.sh"
sourceHash="12ae1e9d643df30f925d83b9f55dc8448329fef7"
sourceLine="19"
summary="Add keys to enable apt to download tofu directly from"
summaryComputed="true"
usage="aptKeyAddOpenTofu [ --help ]"
