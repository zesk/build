#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="value - Set the restart flag to this value (blank to remove)"$'\n'""
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="INTERNAL - has \`packageUpdate\` set the \`restart\` flag at some point?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/package.sh"
fn="packageNeedRestartFlag"
fnMarker="packageneedrestartflag"
foundNames=([0]="argument")
line="658"
rawComment="INTERNAL - has \`packageUpdate\` set the \`restart\` flag at some point?"$'\n'"Argument: value - Set the restart flag to this value (blank to remove)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="658"
summary="INTERNAL - has \`packageUpdate\` set the \`restart\` flag at some"
summaryComputed="true"
usage="packageNeedRestartFlag [ value ]"
