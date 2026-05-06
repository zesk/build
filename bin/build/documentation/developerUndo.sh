#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="developer.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Undo a set of developer functions or aliases"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/developer.sh"
fn="developerUndo"
fnMarker="developerundo"
foundNames=([0]="stdin")
line="68"
rawComment="Undo a set of developer functions or aliases"$'\n'"stdin: List of functions and aliases to remove from the current environment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/developer.sh"
sourceHash="78a593214724db23edf7c0ae664f15c226343bbd"
sourceLine="68"
stdin="List of functions and aliases to remove from the current environment"$'\n'""
summary="Undo a set of developer functions or aliases"
summaryComputed="true"
usage="developerUndo"
