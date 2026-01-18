#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="date - String. Required. String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"format - String. Optional. Format string for the \`date\` command (e.g. \`%s\`)"$'\n'""
base="date.sh"
description="Converts a date (\`YYYY-MM-DD\`) to another format."$'\n'""$'\n'"Compatible with BSD and GNU date."$'\n'"Return Code: 1 - if parsing fails"$'\n'"Return Code: 0 - if parsing succeeds"$'\n'""
example="    dateToFormat 2023-04-20 %s 1681948800"$'\n'"    timestamp=\$(dateToFormat '2023-10-15' %s)"$'\n'""
file="bin/build/tools/date.sh"
fn="dateToFormat"
foundNames=([0]="summary" [1]="argument" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/date.sh"
sourceModified="1768721469"
summary="Platform agnostic date conversion"$'\n'""
usage="dateToFormat date [ format ]"
