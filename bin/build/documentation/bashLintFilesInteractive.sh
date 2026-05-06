#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"fileToCheck ... - File. Optional. Shell file to validate."$'\n'""
base="lint.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run checks interactively until errors are all fixed."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/lint.sh"
fn="bashLintFilesInteractive"
fnMarker="bashlintfilesinteractive"
foundNames=([0]="argument")
line="207"
rawComment="Argument: --exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"Argument: fileToCheck ... - File. Optional. Shell file to validate."$'\n'"Run checks interactively until errors are all fixed."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceHash="7b9146e89f6f2739b967d2534b52727bad65199c"
sourceLine="207"
summary="Run checks interactively until errors are all fixed."
summaryComputed="true"
usage="bashLintFilesInteractive [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]"
