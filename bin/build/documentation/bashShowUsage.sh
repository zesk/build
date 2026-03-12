#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="functionName - String. Required. Function which should be called somewhere within a file."$'\n'"file - File. Required. File to search for function handler."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Show function handler in files"$'\n'"This check is simplistic and does not verify actual coverage or code paths."$'\n'""
file="bin/build/tools/bash.sh"
fn="bashShowUsage"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
rawComment="Show function handler in files"$'\n'"Argument: functionName - String. Required. Function which should be called somewhere within a file."$'\n'"Argument: file - File. Required. File to search for function handler."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Function is used within the file"$'\n'"Return Code: 1 - Function is *not* used within the file"$'\n'"This check is simplistic and does not verify actual coverage or code paths."$'\n'"Requires: throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep"$'\n'""$'\n'""
requires="throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep"$'\n'""
return_code="0 - Function is used within the file"$'\n'"1 - Function is *not* used within the file"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="f595398f728c584ee7c7e2255d6ece3e08b0d67d"
summary="Show function handler in files"
summaryComputed="true"
usage="bashShowUsage functionName file [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
