#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="text - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input."$'\n'""
base="text.sh"
credits="Chris F.A. Johnson (2008)"$'\n'""
description="Trim spaces and only spaces from arguments or a pipe"$'\n'""
example="    trimSpace \"\$token\""$'\n'"    grep \"\$tokenPattern\" | trimSpace > \"\$tokensFound\""$'\n'""
file="bin/build/tools/text.sh"
fn="trimSpace"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="example" [4]="summary" [5]="source" [6]="credits")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768721469"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs trimmed lines"$'\n'""
summary="Trim whitespace of a bash argument"$'\n'""
usage="trimSpace [ text ]"
