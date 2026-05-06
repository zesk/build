#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="number - Number. Required. An integer or floating point number"$'\n'"singular - String. Required. The singular form of a noun"$'\n'"localePlural - String. Optional. The localePlural form of a noun. If not specified uses \`singular\` plus an ess."$'\n'""
base="text.sh"
count=""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Plural word which includes the numeric prefix and the noun."$'\n'""$'\n'""
descriptionLineCount="2"
example="    count=\$(fileLineCount \"\$foxSightings\") || return \$?"$'\n'"    printf \"We saw %s.\\n\" \"\$(localePluralWord \"\$count\" fox foxes)\""$'\n'""
file="bin/build/tools/text.sh"
fn="localePluralWord"
fnMarker="localepluralword"
foundNames=([0]="argument" [1]="example" [2]="stdout")
line="802"
rawComment="Plural word which includes the numeric prefix and the noun."$'\n'"Argument: number - Number. Required. An integer or floating point number"$'\n'"Argument: singular - String. Required. The singular form of a noun"$'\n'"Argument: localePlural - String. Optional. The localePlural form of a noun. If not specified uses \`singular\` plus an ess."$'\n'"Example:     count=\$(fileLineCount \"\$foxSightings\") || return \$?"$'\n'"Example:     printf \"We saw %s.\\n\" \"\$(localePluralWord \"\$count\" fox foxes)\""$'\n'"stdout: \`String\`. The number (direct) and the localePlural form for non-1 values. e.g. \`\$(localePluralWord 2 potato potatoes)\` = \`2 potatoes\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="802"
stdout="\`String\`. The number (direct) and the localePlural form for non-1 values. e.g. \`\$(localePluralWord 2 potato potatoes)\` = \`2 potatoes\`"$'\n'""
summary="Plural word which includes the numeric prefix and the noun."
summaryComputed="true"
usage="localePluralWord number singular [ localePlural ]"
