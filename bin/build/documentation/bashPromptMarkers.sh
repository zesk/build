#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"prefix - EmptyString. Optional. Prefix for all prompts."$'\n'"suffix - EmptyString. Optional. Suffix for all prompts."$'\n'""
base="prompt.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Set markers for terminal integration"$'\n'"Outputs the current marker settings, one per line (0, 1, or 2 lines will be output)."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/prompt.sh"
fn="bashPromptMarkers"
fnMarker="bashpromptmarkers"
foundNames=([0]="argument")
line="127"
rawComment="Set markers for terminal integration"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: prefix - EmptyString. Optional. Prefix for all prompts."$'\n'"Argument: suffix - EmptyString. Optional. Suffix for all prompts."$'\n'"Outputs the current marker settings, one per line (0, 1, or 2 lines will be output)."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceHash="b61c792ae723865297730f9775c4f0b5fcba937d"
sourceLine="127"
summary="Set markers for terminal integration"
summaryComputed="true"
usage="bashPromptMarkers [ --help ] [ prefix ] [ suffix ]"
