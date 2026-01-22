#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deprecated.sh"
argument="usageFunction - Function. Required. Run if handler fails"$'\n'"variableName - String. Required. Name of variable being tested"$'\n'"variableValue - String. Required. Required. only in that if it's blank, it fails."$'\n'"noun - String. Optional. Noun used to describe the argument in errors, defaults to \`file\`"$'\n'""
base="deprecated.sh"
description="Validates a value is not blank and is an environment file which is loaded immediately."$'\n'""$'\n'"Return Code: 2 - Argument error"$'\n'"Return Code: 0 - Success"$'\n'"Upon success, outputs the file name to stdout, outputs a console message to stderr"$'\n'""
file="bin/build/tools/deprecated.sh"
fn="usageArgumentLoadEnvironmentFile"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deprecated.sh"
sourceModified="1769063211"
summary="Validates a value is not blank and is an environment"
usage="usageArgumentLoadEnvironmentFile usageFunction variableName variableValue [ noun ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255musageArgumentLoadEnvironmentFile[0m [38;2;255;255;0m[35;48;2;0;0;0musageFunction[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mvariableName[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mvariableValue[0m[0m [94m[ noun ][0m

    [31musageFunction  [1;97mFunction. Required. Run if handler fails[0m
    [31mvariableName   [1;97mString. Required. Name of variable being tested[0m
    [31mvariableValue  [1;97mString. Required. Required. only in that if it'\''s blank, it fails.[0m
    [94mnoun           [1;97mString. Optional. Noun used to describe the argument in errors, defaults to [38;2;0;255;0;48;2;0;0;0mfile[0m[0m

Validates a value is not blank and is an environment file which is loaded immediately.

Return Code: 2 - Argument error
Return Code: 0 - Success
Upon success, outputs the file name to stdout, outputs a console message to stderr

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: usageArgumentLoadEnvironmentFile usageFunction variableName variableValue [ noun ]

    usageFunction  Function. Required. Run if handler fails
    variableName   String. Required. Name of variable being tested
    variableValue  String. Required. Required. only in that if it'\''s blank, it fails.
    noun           String. Optional. Noun used to describe the argument in errors, defaults to file

Validates a value is not blank and is an environment file which is loaded immediately.

Return Code: 2 - Argument error
Return Code: 0 - Success
Upon success, outputs the file name to stdout, outputs a console message to stderr

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
