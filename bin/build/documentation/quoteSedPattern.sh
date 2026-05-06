#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="text - EmptyString. Required. Text to quote"$'\n'""
base="sed.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Quote a string to be used in a sed pattern on the command line."$'\n'""$'\n'""
descriptionLineCount="2"
example="    sed \"s/\$(quoteSedPattern \"\$1\")/\$(quoteSedPattern \"\$2\")/g\""$'\n'"    needSlash=\$(quoteSedPattern '\$.*/[\\]^')"$'\n'""
file="bin/build/tools/sed.sh"
fn="quoteSedPattern"
fnMarker="quotesedpattern"
foundNames=([0]="summary" [1]="argument" [2]="output" [3]="example" [4]="requires")
line="38"
needSlash=""
output="string quoted and appropriate to insert in a sed search or replacement phrase"$'\n'""
rawComment="Summary: Quote sed search strings for shell use"$'\n'"Quote a string to be used in a sed pattern on the command line."$'\n'"Argument: text - EmptyString. Required. Text to quote"$'\n'"Output: string quoted and appropriate to insert in a sed search or replacement phrase"$'\n'"Example:     sed \"s/\$(quoteSedPattern \"\$1\")/\$(quoteSedPattern \"\$2\")/g\""$'\n'"Example:     needSlash=\$(quoteSedPattern '\$.*/[\\]^')"$'\n'"Requires: printf sed bashDocumentation helpArgument"$'\n'""$'\n'""
requires="printf sed bashDocumentation helpArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sed.sh"
sourceHash="f0fc6b83d684caf722f5b07d53b68ae6ac5fa68a"
sourceLine="38"
summary="Quote sed search strings for shell use"
summaryComputed=""
usage="quoteSedPattern text"
