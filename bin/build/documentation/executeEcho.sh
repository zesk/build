#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="command ... - Any command and arguments to run."$'\n'""
base="_sugar.sh"
description="Output the \`command ...\` to stdout prior to running, then \`execute\` it"$'\n'"Return Code: Any"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="executeEcho"
foundNames=""
requires="printf decorate execute __decorateExtensionQuote __decorateExtensionEach"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1768721470"
summary="Output the \`command ...\` to stdout prior to running, then"
usage="executeEcho [ command ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mexecuteEcho[0m [94m[ command ... ][0m

    [94mcommand ...  [1;97mAny command and arguments to run.[0m

Output the [38;2;0;255;0;48;2;0;0;0mcommand ...[0m to stdout prior to running, then [38;2;0;255;0;48;2;0;0;0mexecute[0m it
Return Code: Any

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: executeEcho [ command ... ]

    command ...  Any command and arguments to run.

Output the command ... to stdout prior to running, then execute it
Return Code: Any

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
