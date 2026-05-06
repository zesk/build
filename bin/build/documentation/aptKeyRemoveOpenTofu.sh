#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="tofu.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Remove keys to disable apt to download tofu from opentofu.org"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/tofu.sh"
fn="aptKeyRemoveOpenTofu"
fnMarker="aptkeyremoveopentofu"
foundNames=([0]="see" [1]="argument" [2]="return_code")
line="43"
rawComment="Remove keys to disable apt to download tofu from opentofu.org"$'\n'"See: aptKeyAddOpenTofu"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - Environment problems"$'\n'"Return Code: 0 - All good to install tofu"$'\n'""$'\n'""
return_code="1 - Environment problems"$'\n'"0 - All good to install tofu"$'\n'""
see="aptKeyAddOpenTofu"$'\n'""
sourceFile="bin/build/tools/tofu.sh"
sourceHash="12ae1e9d643df30f925d83b9f55dc8448329fef7"
sourceLine="43"
summary="Remove keys to disable apt to download tofu from opentofu.org"
summaryComputed="true"
usage="aptKeyRemoveOpenTofu [ --help ]"
