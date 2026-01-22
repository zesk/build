#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/type.sh"
argument="string - EmptyString. Required. Path to binary to test if it is executable."$'\n'""
base="type.sh"
description="Test if all arguments are callable as a command"$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - All arguments are callable as a command"$'\n'"Return Code: 1 - One or or more arguments are callable as a command"$'\n'""
file="bin/build/tools/type.sh"
fn="isCallable"
foundNames=""
requires="throwArgument __help isExecutable isFunction"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceModified="1768721470"
summary="Test if all arguments are callable as a command"
usage="isCallable string"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misCallable[0m [38;2;255;255;0m[35;48;2;0;0;0mstring[0m[0m

    [31mstring  [1;97mEmptyString. Required. Path to binary to test if it is executable.[0m

Test if all arguments are callable as a command
If no arguments are passed, returns exit code 1.
Return Code: 0 - All arguments are callable as a command
Return Code: 1 - One or or more arguments are callable as a command

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isCallable string

    string  EmptyString. Required. Path to binary to test if it is executable.

Test if all arguments are callable as a command
If no arguments are passed, returns exit code 1.
Return Code: 0 - All arguments are callable as a command
Return Code: 1 - One or or more arguments are callable as a command

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
