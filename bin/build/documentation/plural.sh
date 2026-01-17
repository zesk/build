#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="number - Required. An integer or floating point number"$'\n'"singular - Required. The singular form of a noun"$'\n'"plural - Optional. The plural form of a noun. If not specified uses \`singular\` plus an ess."$'\n'""
base="text.sh"
description="Outputs the \`singular\` value to standard out when the value of \`number\` is one."$'\n'"Otherwise, outputs the \`plural\` value to standard out."$'\n'""$'\n'"Short description: Output numeric messages which are grammatically accurate"$'\n'""$'\n'"Return Code: 1 - If count is non-numeric"$'\n'"Return Code: 0 - If count is numeric"$'\n'"Example:"$'\n'""
example="    count=\$(fileLineCount \"\$foxSightings\") || return \$?"$'\n'"    printf \"We saw %d %s.\\n\" \"\$count\" \"\$(plural \"\$count\" fox foxes)\""$'\n'"    n=\$((\$(date +%s)) - start))"$'\n'"    printf \"That took %d %s\" \"\$n\" \"\$(plural \"\$n\" second seconds)\""$'\n'""
file="bin/build/tools/text.sh"
fn="plural"
foundNames=([0]="argument" [1]="example" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768686587"
stdout="\`String\`. The plural form for non-1 values. e.g. \`\$(plural 2 potato potatoes)\` = \`potatoes\`"$'\n'""
summary="Outputs the \`singular\` value to standard out when the value"
usage="plural number singular [ plural ]"
