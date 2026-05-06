#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="vendor.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Are we within the JetBrains PHPStorm terminal?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/vendor.sh"
fn="isPHPStorm"
fnMarker="isphpstorm"
foundNames=([0]="argument" [1]="return_code" [2]="see")
line="23"
rawComment="Are we within the JetBrains PHPStorm terminal?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - within the PhpStorm terminal"$'\n'"Return Code: 1 - not within the PhpStorm terminal AFAIK"$'\n'"See: contextOpen"$'\n'""$'\n'""
return_code="0 - within the PhpStorm terminal"$'\n'"1 - not within the PhpStorm terminal AFAIK"$'\n'""
see="contextOpen"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceHash="6a1c6758472ed8ae9048cda1a9a026cbbe718421"
sourceLine="23"
summary="Are we within the JetBrains PHPStorm terminal?"
summaryComputed="true"
usage="isPHPStorm [ --help ]"
