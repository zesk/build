#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="functionName - String. Required. Function which should be called somewhere within a file."$'\n'"file - File. Required. File to search for function handler."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Show function handler in files"$'\n'"Return Code: 0 - Function is used within the file"$'\n'"Return Code: 1 - Function is *not* used within the file"$'\n'"This check is simplistic and does not verify actual coverage or code paths."$'\n'""
file="bin/build/tools/bash.sh"
fn="bashShowUsage"
foundNames=""
requires="throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1769063211"
summary="Show function handler in files"
usage="bashShowUsage functionName file [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashShowUsage[0m [38;2;255;255;0m[35;48;2;0;0;0mfunctionName[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfile[0m[0m [94m[ --help ][0m

    [31mfunctionName  [1;97mString. Required. Function which should be called somewhere within a file.[0m
    [31mfile          [1;97mFile. Required. File to search for function handler.[0m
    [94m--help        [1;97mFlag. Optional. Display this help.[0m

Show function handler in files
Return Code: 0 - Function is used within the file
Return Code: 1 - Function is [36mnot[0m used within the file
This check is simplistic and does not verify actual coverage or code paths.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashShowUsage functionName file [ --help ]

    functionName  String. Required. Function which should be called somewhere within a file.
    file          File. Required. File to search for function handler.
    --help        Flag. Optional. Display this help.

Show function handler in files
Return Code: 0 - Function is used within the file
Return Code: 1 - Function is not used within the file
This check is simplistic and does not verify actual coverage or code paths.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
