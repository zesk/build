#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sugar.sh"
argument="handler - Function. Required. Failure command"$'\n'"quietLog - File. Required. File to output log to temporarily for this command. If \`quietLog\` is \`-\` then creates a temporary file for the command which is deleted automatically."$'\n'"command ... - Callable. Required. Thing to run and append output to \`quietLog\`."$'\n'""
base="sugar.sh"
description="Run \`handler\` with an environment error"$'\n'""
file="bin/build/tools/sugar.sh"
fn="catchEnvironmentQuiet"
requires="isFunction returnArgument buildFailed debuggingStack throwEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceModified="1768769473"
summary="Run \`handler\` with an environment error"
usage="catchEnvironmentQuiet handler quietLog command ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcatchEnvironmentQuiet[0m [38;2;255;255;0m[35;48;2;0;0;0mhandler[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mquietLog[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mcommand ...[0m[0m

    [31mhandler      [1;97mFunction. Required. Failure command[0m
    [31mquietLog     [1;97mFile. Required. File to output log to temporarily for this command. If [38;2;0;255;0;48;2;0;0;0mquietLog[0m is [38;2;0;255;0;48;2;0;0;0m-[0m then creates a temporary file for the command which is deleted automatically.[0m
    [31mcommand ...  [1;97mCallable. Required. Thing to run and append output to [38;2;0;255;0;48;2;0;0;0mquietLog[0m.[0m

Run [38;2;0;255;0;48;2;0;0;0mhandler[0m with an environment error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: catchEnvironmentQuiet handler quietLog command ...

    handler      Function. Required. Failure command
    quietLog     File. Required. File to output log to temporarily for this command. If quietLog is - then creates a temporary file for the command which is deleted automatically.
    command ...  Callable. Required. Thing to run and append output to quietLog.

Run handler with an environment error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
