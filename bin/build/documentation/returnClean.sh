#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="exitCode - Integer. Required. Exit code to return."$'\n'"item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr."$'\n'""
base="_sugar.sh"
description="Delete files or directories and return the same exit code passed in."$'\n'""
file="bin/build/tools/_sugar.sh"
fn="returnClean"
foundNames=""
group="Sugar"$'\n'""
requires="isUnsignedInteger returnArgument throwEnvironment usageDocument throwArgument __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1768721470"
summary="Delete files or directories and return the same exit code"
usage="returnClean exitCode [ item ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mreturnClean[0m [38;2;255;255;0m[35;48;2;0;0;0mexitCode[0m[0m [94m[ item ][0m

    [31mexitCode  [1;97mInteger. Required. Exit code to return.[0m
    [94mitem      [1;97mExists. Optional. One or more files or folders to delete, failures are logged to stderr.[0m

Delete files or directories and return the same exit code passed in.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: returnClean exitCode [ item ]

    exitCode  Integer. Required. Exit code to return.
    item      Exists. Optional. One or more files or folders to delete, failures are logged to stderr.

Delete files or directories and return the same exit code passed in.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
