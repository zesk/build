#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="handler - Function. Required. Failure command"$'\n'"message ... - String. Optional. Error message to display."$'\n'""
base="_sugar.sh"
description="Run \`handler\` with an environment error"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="throwEnvironment"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1768721470"
summary="Run \`handler\` with an environment error"
usage="throwEnvironment handler [ message ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mthrowEnvironment[0m [38;2;255;255;0m[35;48;2;0;0;0mhandler[0m[0m [94m[ message ... ][0m

    [31mhandler      [1;97mFunction. Required. Failure command[0m
    [94mmessage ...  [1;97mString. Optional. Error message to display.[0m

Run [38;2;0;255;0;48;2;0;0;0mhandler[0m with an environment error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: throwEnvironment handler [ message ... ]

    handler      Function. Required. Failure command
    message ...  String. Optional. Error message to display.

Run handler with an environment error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
