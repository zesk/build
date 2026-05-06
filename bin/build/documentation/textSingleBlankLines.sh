#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Ensures blank lines are singular"$'\n'"Used often to clean up markdown \`.md\` files, but can be used for any line-based configuration file which allows blank lines."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="textSingleBlankLines"
fnMarker="textsingleblanklines"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="279"
rawComment="Ensures blank lines are singular"$'\n'"Used often to clean up markdown \`.md\` files, but can be used for any line-based configuration file which allows blank lines."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Reads lines from stdin until EOF"$'\n'"stdout: Outputs modified lines where any blank lines are replaced with a single blank line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="279"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs modified lines where any blank lines are replaced with a single blank line."$'\n'""
summary="Ensures blank lines are singular"
summaryComputed="true"
usage="textSingleBlankLines [ --help ]"
