#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/security.sh"
argument="none"
base="security.sh"
description="Check files to ensure \`eval\`s in code have been checked"$'\n'""
file="bin/build/tools/security.sh"
fn="evalCheck"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/security.sh"
sourceModified="1768513812"
summary="Check files to ensure \`eval\`s in code have been checked"
usage="evalCheck"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mevalCheck[0m

Check files to ensure [38;2;0;255;0;48;2;0;0;0meval[0ms in code have been checked

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: evalCheck

Check files to ensure evals in code have been checked

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
