#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="functionName - String. Required. Function which should be called somewhere within a file."$'\n'"file - File. Required. File to search for function handler."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="bash.sh"
description="Show function handler in files"$'\n'"Return Code: 0 - Function is used within the file"$'\n'"Return Code: 1 - Function is *not* used within the file"$'\n'"This check is simplistic and does not verify actual coverage or code paths."$'\n'""
file="bin/build/tools/bash.sh"
fn="bashShowUsage"
foundNames=([0]="argument" [1]="requires")
requires="throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/bash.sh"
sourceModified="1768695708"
summary="Show function handler in files"
usage="bashShowUsage functionName file [ --help ]"
