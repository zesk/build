#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="date - String. Required. String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"format - String. Optional. Format string for the \`date\` command (e.g. \`%s\`)"$'\n'""
base="date.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Converts a date (\`YYYY-MM-DD\`) to another format."$'\n'""$'\n'"Compatible with BSD and GNU date."$'\n'""$'\n'""
descriptionLineCount="4"
example="    dateToFormat 2023-04-20 %s 1681948800"$'\n'"    timestamp=\$(dateToFormat '2023-10-15' %s)"$'\n'""
file="bin/build/tools/date.sh"
fn="dateToFormat"
fnMarker="datetoformat"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="return_code")
line="22"
rawComment="Converts a date (\`YYYY-MM-DD\`) to another format."$'\n'"Summary: Platform agnostic date conversion"$'\n'"Compatible with BSD and GNU date."$'\n'"Argument: date - String. Required. String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"Argument: format - String. Optional. Format string for the \`date\` command (e.g. \`%s\`)"$'\n'"Example:     dateToFormat 2023-04-20 %s 1681948800"$'\n'"Example:     timestamp=\$(dateToFormat '2023-10-15' %s)"$'\n'"Return Code: 1 - if parsing fails"$'\n'"Return Code: 0 - if parsing succeeds"$'\n'""$'\n'""
return_code="1 - if parsing fails"$'\n'"0 - if parsing succeeds"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="8b6a5808143207c1b2329179a4d73d95ea46d8cc"
sourceLine="22"
summary="Platform agnostic date conversion"
summaryComputed=""
timestamp=""
usage="dateToFormat date [ format ]"
