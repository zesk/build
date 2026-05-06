#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="target - Exists. File. Source file name or path."$'\n'"linkName - String. Required. Link short name, created next to \`target\`."$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Create a link"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="linkCreate"
fnMarker="linkcreate"
foundNames=([0]="argument")
line="730"
rawComment="Create a link"$'\n'"Argument: target - Exists. File. Source file name or path."$'\n'"Argument: linkName - String. Required. Link short name, created next to \`target\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="730"
summary="Create a link"
summaryComputed="true"
usage="linkCreate [ target ] linkName"
