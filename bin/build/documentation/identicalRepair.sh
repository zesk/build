#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. \`# {identical}}\`) (may specify more than one)"$'\n'"token - String. Required. The token to repair."$'\n'"source - File. Required. The token file source. First occurrence is used."$'\n'"destination - File. Required. The token file to repair. Can be same as \`source\`."$'\n'"--stdout - Flag. Optional. Output changed file to \`stdout\`"$'\n'""
base="identical.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Repair an identical \`token\` in \`destination\` from \`source\`"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/identical.sh"
fn="identicalRepair"
fnMarker="identicalrepair"
foundNames=([0]="argument")
line="31"
rawComment="Repair an identical \`token\` in \`destination\` from \`source\`"$'\n'"Argument: --prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. \`# {identical}}\`) (may specify more than one)"$'\n'"Argument: token - String. Required. The token to repair."$'\n'"Argument: source - File. Required. The token file source. First occurrence is used."$'\n'"Argument: destination - File. Required. The token file to repair. Can be same as \`source\`."$'\n'"Argument: --stdout - Flag. Optional. Output changed file to \`stdout\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/identical.sh"
sourceHash="9b062c3d858b37e9d0bb2c6dc51ad89ca20e549b"
sourceLine="31"
summary="Repair an identical \`token\` in \`destination\` from \`source\`"
summaryComputed="true"
usage="identicalRepair --prefix prefix token source destination [ --stdout ]"
