#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="binary ... - Executable. Required. Any arguments are passed to \`binary\`."$'\n'""
base="_sugar.sh"
description="Run binary and output failed command upon error"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="execute"
foundNames=""
requires="returnMessage"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1769063211"
summary="Run binary and output failed command upon error"
usage="execute binary ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mexecute[0m [38;2;255;255;0m[35;48;2;0;0;0mbinary ...[0m[0m

    [31mbinary ...  [1;97mExecutable. Required. Any arguments are passed to [38;2;0;255;0;48;2;0;0;0mbinary[0m.[0m

Run binary and output failed command upon error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: execute binary ...

    binary ...  Executable. Required. Any arguments are passed to binary.

Run binary and output failed command upon error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
