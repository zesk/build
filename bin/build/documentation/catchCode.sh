#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="code - UnsignedInteger. Required. Exit code to return"$'\n'"handler - Function. Required. Failure command, passed remaining arguments and error code."$'\n'"command ... - Callable. Required. Command to run."$'\n'""
base="_sugar.sh"
description="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\` as error"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="catchCode"
foundNames=""
requires="isUnsignedInteger returnArgument isFunction isCallable"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1769063211"
summary="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\`"
usage="catchCode code handler command ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcatchCode[0m [38;2;255;255;0m[35;48;2;0;0;0mcode[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mhandler[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mcommand ...[0m[0m

    [31mcode         [1;97mUnsignedInteger. Required. Exit code to return[0m
    [31mhandler      [1;97mFunction. Required. Failure command, passed remaining arguments and error code.[0m
    [31mcommand ...  [1;97mCallable. Required. Command to run.[0m

Run [38;2;0;255;0;48;2;0;0;0mcommand[0m, handle failure with [38;2;0;255;0;48;2;0;0;0mhandler[0m with [38;2;0;255;0;48;2;0;0;0mcode[0m and [38;2;0;255;0;48;2;0;0;0mcommand[0m as error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: catchCode code handler command ...

    code         UnsignedInteger. Required. Exit code to return
    handler      Function. Required. Failure command, passed remaining arguments and error code.
    command ...  Callable. Required. Command to run.

Run command, handle failure with handler with code and command as error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
