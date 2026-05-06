#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="functionName - String. Required. Function which should be called somewhere within a file."$'\n'"file - File. Required. File to search for function handler."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Show function handler in files"$'\n'"This check is simplistic and does not verify actual coverage or code paths."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/bash.sh"
fn="bashShowUsage"
fnMarker="bashshowusage"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="315"
rawComment="Show function handler in files"$'\n'"Argument: functionName - String. Required. Function which should be called somewhere within a file."$'\n'"Argument: file - File. Required. File to search for function handler."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Function is used within the file"$'\n'"Return Code: 1 - Function is *not* used within the file"$'\n'"This check is simplistic and does not verify actual coverage or code paths."$'\n'"Requires: throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep"$'\n'""$'\n'""
requires="throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep"$'\n'""
return_code="0 - Function is used within the file"$'\n'"1 - Function is *not* used within the file"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="9d7b158a0e679532b85d7d28ad6415566e66b29c"
sourceLine="315"
summary="Show function handler in files"
summaryComputed="true"
usage="bashShowUsage functionName file [ --help ]"
