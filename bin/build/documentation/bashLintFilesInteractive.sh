#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/lint.sh"
argument="--exec binary -  Callable. Optional.Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"--delay delaySeconds -  Integer. Optional.Delay in seconds between checks in interactive mode."$'\n'"fileToCheck ... -  File. Optional.Shell file to validate."$'\n'""
base="lint.sh"
description="Run checks interactively until errors are all fixed."$'\n'""
file="bin/build/tools/lint.sh"
fn="bashLintFilesInteractive"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/lint.sh"
sourceModified="1768684846"
summary="Run checks interactively until errors are all fixed."
usage="bashLintFilesInteractive [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]"
