#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="searchPattern - String. Required. The string to search for."$'\n'"replacePattern - String. Required. The replacement to replace with."$'\n'""
base="sed.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Quote a sed command for search and replace"$'\n'"Without arguments, displays help."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/sed.sh"
fn="sedReplacePattern"
fnMarker="sedreplacepattern"
foundNames=([0]="argument")
line="19"
rawComment="Quote a sed command for search and replace"$'\n'"Argument: searchPattern - String. Required. The string to search for."$'\n'"Argument: replacePattern - String. Required. The replacement to replace with."$'\n'"Without arguments, displays help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sed.sh"
sourceHash="f0fc6b83d684caf722f5b07d53b68ae6ac5fa68a"
sourceLine="19"
summary="Quote a sed command for search and replace"
summaryComputed="true"
usage="sedReplacePattern searchPattern replacePattern"
