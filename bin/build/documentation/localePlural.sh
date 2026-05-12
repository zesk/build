#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="number - Number. Required. An integer or floating point number"$'\n'"singular - String. Required. The singular form of a noun"$'\n'"localePlural - String. Optional. The localePlural form of a noun. If not specified uses \`singular\` plus an ess."$'\n'""
base="text.sh"
count=""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Outputs the \`singular\` value to standard out when the value of \`number\` is one."$'\n'"Otherwise, outputs the \`localePlural\` value to standard out."$'\n'""$'\n'"Example:"$'\n'""$'\n'""
descriptionLineCount="5"
example="    count=\$(fileLineCount \"\$foxSightings\") || return \$?"$'\n'"    printf \"We saw %d %s.\\n\" \"\$count\" \"\$(localePlural \"\$count\" fox foxes)\""$'\n'"    n=\$((\$(date +%s)) - start))"$'\n'"    printf \"That took %d %s\" \"\$n\" \"\$(localePlural \"\$n\" second seconds)\""$'\n'""
file="bin/build/tools/text.sh"
fn="localePlural"
fnMarker="localeplural"
foundNames=([0]="short_description" [1]="argument" [2]="return_code" [3]="example" [4]="stdout")
line="829"
n=""
rawComment="Outputs the \`singular\` value to standard out when the value of \`number\` is one."$'\n'"Otherwise, outputs the \`localePlural\` value to standard out."$'\n'"Short description: Output numeric messages which are grammatically accurate"$'\n'"Argument: number - Number. Required. An integer or floating point number"$'\n'"Argument: singular - String. Required. The singular form of a noun"$'\n'"Argument: localePlural - String. Optional. The localePlural form of a noun. If not specified uses \`singular\` plus an ess."$'\n'"Return Code: 1 - If count is non-numeric"$'\n'"Return Code: 0 - If count is numeric"$'\n'"Example:     count=\$(fileLineCount \"\$foxSightings\") || return \$?"$'\n'"Example:     printf \"We saw %d %s.\\n\" \"\$count\" \"\$(localePlural \"\$count\" fox foxes)\""$'\n'"Example:"$'\n'"Example:     n=\$((\$(date +%s)) - start))"$'\n'"Example:     printf \"That took %d %s\" \"\$n\" \"\$(localePlural \"\$n\" second seconds)\""$'\n'"stdout: \`String\`. The localePlural form for non-1 values. e.g. \`\$(localePlural 2 potato potatoes)\` = \`potatoes\`"$'\n'""$'\n'""
return_code="1 - If count is non-numeric"$'\n'"0 - If count is numeric"$'\n'""
short_description="Output numeric messages which are grammatically accurate"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="829"
stdout="\`String\`. The localePlural form for non-1 values. e.g. \`\$(localePlural 2 potato potatoes)\` = \`potatoes\`"$'\n'""
summary="Outputs the \`singular\` value to standard out when the value"
summaryComputed="true"
usage="localePlural number singular [ localePlural ]"
