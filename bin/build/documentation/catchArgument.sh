#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="handler - Function. Required. Failure command"$'\n'"command ... - Callable. Required. Command to run."$'\n'""
base="_sugar.sh"
description="Run \`command\`, upon failure run \`handler\` with an argument error"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="catchArgument"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1768721470"
summary="Run \`command\`, upon failure run \`handler\` with an argument error"
usage="catchArgument handler command ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcatchArgument[0m [38;2;255;255;0m[35;48;2;0;0;0mhandler[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mcommand ...[0m[0m

    [31mhandler      [1;97mFunction. Required. Failure command[0m
    [31mcommand ...  [1;97mCallable. Required. Command to run.[0m

Run [38;2;0;255;0;48;2;0;0;0mcommand[0m, upon failure run [38;2;0;255;0;48;2;0;0;0mhandler[0m with an argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: catchArgument handler command ...

    handler      Function. Required. Failure command
    command ...  Callable. Required. Command to run.

Run command, upon failure run handler with an argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
