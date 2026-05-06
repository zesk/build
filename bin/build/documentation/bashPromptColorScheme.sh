#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="colorScheme - String. Optional. Color scheme to choose: \`light\`, \`dark\`, \`forest\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="prompt.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Color schemes for prompts"$'\n'"Options are:"$'\n'"- forest"$'\n'"- light (default)"$'\n'"- dark"$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/prompt.sh"
fn="bashPromptColorScheme"
fnMarker="bashpromptcolorscheme"
foundNames=([0]="argument")
line="166"
rawComment="Color schemes for prompts"$'\n'"Options are:"$'\n'"- forest"$'\n'"- light (default)"$'\n'"- dark"$'\n'"Argument: colorScheme - String. Optional. Color scheme to choose: \`light\`, \`dark\`, \`forest\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceHash="b61c792ae723865297730f9775c4f0b5fcba937d"
sourceLine="166"
summary="Color schemes for prompts"
summaryComputed="true"
usage="bashPromptColorScheme [ colorScheme ] [ --help ]"
