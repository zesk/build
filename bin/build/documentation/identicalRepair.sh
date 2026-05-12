#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. `# {identical}}`) (may specify more than one)\ntoken - String. Required. The token to repair.\nsource - File. Required. The token file source. First occurrence is used.\ndestination - File. Required. The token file to repair. Can be same as `source`.\n--stdout - Flag. Optional. Output changed file to `stdout`\n'
base="identical.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Repair an identical `token` in `destination` from `source`\n\n'
descriptionLineCount="2"
file="bin/build/tools/identical.sh"
fn="identicalRepair"
fnMarker="identicalrepair"
foundNames=([0]="argument")
line="31"
rawComment=$'Repair an identical `token` in `destination` from `source`\nArgument: --prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. `# {identical}}`) (may specify more than one)\nArgument: token - String. Required. The token to repair.\nArgument: source - File. Required. The token file source. First occurrence is used.\nArgument: destination - File. Required. The token file to repair. Can be same as `source`.\nArgument: --stdout - Flag. Optional. Output changed file to `stdout`\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/identical.sh"
sourceHash="ea8e2888c723217827eadc0bd4d2eac27d87f45e"
sourceLine="31"
summary="Repair an identical \`token\` in \`destination\` from \`source\`"
summaryComputed="true"
usage="identicalRepair --prefix prefix token source destination [ --stdout ]"
