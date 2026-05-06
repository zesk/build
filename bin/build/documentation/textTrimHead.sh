#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Removes any blank lines from the beginning of a stream"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="textTrimHead"
fnMarker="texttrimhead"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="249"
rawComment="Removes any blank lines from the beginning of a stream"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Reads lines from stdin until EOF"$'\n'"stdout: Outputs modified lines"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="249"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs modified lines"$'\n'""
summary="Removes any blank lines from the beginning of a stream"
summaryComputed="true"
usage="textTrimHead [ --help ]"
