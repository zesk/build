#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="script - File. Required. Bash script to fetch requires tokens from."$'\n'""
base="bash.sh"
description="Gets a list of the \`Requires:\` comments in a bash file"$'\n'"Returns a unique list of tokens"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashGetRequires"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1769063211"
summary="Gets a list of the \`Requires:\` comments in a bash"
usage="bashGetRequires script"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashGetRequires[0m [38;2;255;255;0m[35;48;2;0;0;0mscript[0m[0m

    [31mscript  [1;97mFile. Required. Bash script to fetch requires tokens from.[0m

Gets a list of the [38;2;0;255;0;48;2;0;0;0mRequires:[0m comments in a bash file
Returns a unique list of tokens

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashGetRequires script

    script  File. Required. Bash script to fetch requires tokens from.

Gets a list of the Requires: comments in a bash file
Returns a unique list of tokens

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
