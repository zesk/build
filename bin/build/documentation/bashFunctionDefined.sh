#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="functionName - String. Required. Name of function to check."$'\n'"file ... - File. Required. One or more files to check if a function is defined within."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Is a function defined in a bash source file?"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashFunctionDefined"
foundNames=([0]="summary" [1]="argument")
rawComment="Summary: Is a function defined in a bash source file?"$'\n'"Argument: functionName - String. Required. Name of function to check."$'\n'"Argument: file ... - File. Required. One or more files to check if a function is defined within."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="f595398f728c584ee7c7e2255d6ece3e08b0d67d"
summary="Is a function defined in a bash source file?"$'\n'""
usage="bashFunctionDefined functionName file ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
