#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--verbose - Flag. Optional. Be wordy."$'\n'"--default defaultValue - EmptyString. Optional. Pass \`--default\` flag to \`mapFunction\`"$'\n'"sourcePath - Exists. Required. File or directory to convert."$'\n'"targetPath - FileDirectory. Optional. Outputs to \`stdout\` if not specified, otherwise outputs mirror."$'\n'"mapFunction ... - Function. Optional. Mapping function to use, and any arguments."$'\n'""
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Generate documentation using source markdown and a mapping function."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationMaker"
fnMarker="documentationmaker"
foundNames=([0]="argument" [1]="return_code")
line="443"
rawComment="Generate documentation using source markdown and a mapping function."$'\n'"Argument: --verbose - Flag. Optional. Be wordy."$'\n'"Argument: --default defaultValue - EmptyString. Optional. Pass \`--default\` flag to \`mapFunction\`"$'\n'"Argument: sourcePath - Exists. Required. File or directory to convert."$'\n'"Argument: targetPath - FileDirectory. Optional. Outputs to \`stdout\` if not specified, otherwise outputs mirror."$'\n'"Argument: mapFunction ... - Function. Optional. Mapping function to use, and any arguments."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Template file not found"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Template file not found"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="7487e1e4be50d4eb634f007bfd41adda45ab6d68"
sourceLine="443"
summary="Generate documentation using source markdown and a mapping function."
summaryComputed="true"
usage="documentationMaker [ --verbose ] [ --default defaultValue ] sourcePath [ targetPath ] [ mapFunction ... ]"
