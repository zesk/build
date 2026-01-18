#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="number - Number. Required. An integer or floating point number"$'\n'"singular - String. Required. The singular form of a noun"$'\n'"plural - String. Optional. The plural form of a noun. If not specified uses \`singular\` plus an ess."$'\n'""
base="text.sh"
description="Plural word which includes the numeric prefix and the noun."$'\n'""
example="    count=\$(fileLineCount \"\$foxSightings\") || return \$?"$'\n'"    printf \"We saw %s.\\n\" \"\$(pluralWord \"\$count\" fox foxes)\""$'\n'""
file="bin/build/tools/text.sh"
fn="pluralWord"
foundNames=([0]="argument" [1]="example" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768759798"
stdout="\`String\`. The number (direct) and the plural form for non-1 values. e.g. \`\$(pluralWord 2 potato potatoes)\` = \`2 potatoes\`"$'\n'""
summary="Plural word which includes the numeric prefix and the noun."
usage="pluralWord number singular [ plural ]"
