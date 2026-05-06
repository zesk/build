#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="path.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Cleans the path and removes non-directory entries and duplicates"$'\n'""$'\n'"Maintains ordering."$'\n'""$'\n'""
descriptionLineCount="4"
environment="PATH"$'\n'""
file="bin/build/tools/path.sh"
fn="pathCleanDuplicates"
fnMarker="pathcleanduplicates"
foundNames=([0]="argument" [1]="environment")
line="95"
rawComment="Cleans the path and removes non-directory entries and duplicates"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Maintains ordering."$'\n'"Environment: PATH"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/path.sh"
sourceHash="21f0a5cf2e762f067606fe4d4a3c0e6f7a52a264"
sourceLine="95"
summary="Cleans the path and removes non-directory entries and duplicates"
summaryComputed="true"
usage="pathCleanDuplicates [ --help ]"
