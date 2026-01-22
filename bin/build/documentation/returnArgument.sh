#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="message ... - String. Optional. Message to output."$'\n'""
base="_sugar.sh"
description="Return \`argument\` error code. Outputs \`message ...\` to \`stderr\`."$'\n'"Return Code: 2"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="returnArgument"
foundNames=""
requires="returnMessage"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1769063211"
summary="Return \`argument\` error code. Outputs \`message ...\` to \`stderr\`."
usage="returnArgument [ message ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mreturnArgument[0m [94m[ message ... ][0m

    [94mmessage ...  [1;97mString. Optional. Message to output.[0m

Return [38;2;0;255;0;48;2;0;0;0margument[0m error code. Outputs [38;2;0;255;0;48;2;0;0;0mmessage ...[0m to [38;2;0;255;0;48;2;0;0;0mstderr[0m.
Return Code: 2

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: returnArgument [ message ... ]

    message ...  String. Optional. Message to output.

Return argument error code. Outputs message ... to stderr.
Return Code: 2

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
