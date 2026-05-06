#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="quote - String. Required. Must match beginning and end of string."$'\n'"value - String. Required. Value to unquote."$'\n'""
base="quote.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Unquote a string"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/quote.sh"
fn="stringUnquote"
fnMarker="stringunquote"
foundNames=([0]="summary" [1]="argument")
line="120"
rawComment="Unquote a string"$'\n'"Summary: Unquote a string"$'\n'"Argument: quote - String. Required. Must match beginning and end of string."$'\n'"Argument: value - String. Required. Value to unquote."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceHash="3c095cfee529b43ebd935ef3549c279a5af1427c"
sourceLine="120"
summary="Unquote a string"
summaryComputed=""
usage="stringUnquote quote value"
