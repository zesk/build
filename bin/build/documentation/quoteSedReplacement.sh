#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="text - EmptyString. Required. Text to quote"$'\n'"separatorChar - The character used to separate the sed pattern and replacement. Defaults to \`/\`."$'\n'""
base="sed.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Quote sed replacement strings for shell use"
descriptionLineCount=""
example="    sed \"s/\$(quoteSedPattern \"\$1\")/\$(quoteSedReplacement \"\$2\")/g\""$'\n'"    needSlash=\$(quoteSedPattern '\$.*/[\\]^')"$'\n'""
file="bin/build/tools/sed.sh"
fn="quoteSedReplacement"
fnMarker="quotesedreplacement"
foundNames=([0]="summary" [1]="argument" [2]="output" [3]="example" [4]="requires")
line="57"
needSlash=""
output="string quoted and appropriate to insert in a \`sed\` replacement phrase"$'\n'""
rawComment="Summary: Quote sed replacement strings for shell use"$'\n'"Argument: text - EmptyString. Required. Text to quote"$'\n'"Argument: separatorChar - The character used to separate the sed pattern and replacement. Defaults to \`/\`."$'\n'"Output: string quoted and appropriate to insert in a \`sed\` replacement phrase"$'\n'"Example:     sed \"s/\$(quoteSedPattern \"\$1\")/\$(quoteSedReplacement \"\$2\")/g\""$'\n'"Example:     needSlash=\$(quoteSedPattern '\$.*/[\\]^')"$'\n'"Requires: printf sed bashDocumentation helpArgument"$'\n'""$'\n'""
requires="printf sed bashDocumentation helpArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sed.sh"
sourceHash="f0fc6b83d684caf722f5b07d53b68ae6ac5fa68a"
sourceLine="57"
summary="Quote sed replacement strings for shell use"
summaryComputed=""
usage="quoteSedReplacement text [ separatorChar ]"
