#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/type.sh"
argument="string - Required. String to test if it is a bash function. Builtins are supported. \`.\` is explicitly not supported to disambiguate it from the current directory \`.\`."$'\n'""
base="type.sh"
description="Test if argument are bash functions"$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - argument is bash function"$'\n'"Return Code: 1 - argument is not a bash function"$'\n'""
file="bin/build/tools/type.sh"
fn="isFunction"
foundNames=""
requires="catchArgument isUnsignedInteger usageDocument type"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceModified="1769063211"
summary="Test if argument are bash functions"
usage="isFunction string"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misFunction[0m [38;2;255;255;0m[35;48;2;0;0;0mstring[0m[0m

    [31mstring  [1;97mRequired. String to test if it is a bash function. Builtins are supported. [38;2;0;255;0;48;2;0;0;0m.[0m is explicitly not supported to disambiguate it from the current directory [38;2;0;255;0;48;2;0;0;0m.[0m[0m

Test if argument are bash functions
If no arguments are passed, returns exit code 1.
Return Code: 0 - argument is bash function
Return Code: 1 - argument is not a bash function

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isFunction string

    string  Required. String to test if it is a bash function. Builtins are supported. . is explicitly not supported to disambiguate it from the current directory .

Test if argument are bash functions
If no arguments are passed, returns exit code 1.
Return Code: 0 - argument is bash function
Return Code: 1 - argument is not a bash function

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
