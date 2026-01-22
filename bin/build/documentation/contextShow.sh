#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/vendor.sh"
argument="none"
base="vendor.sh"
description="Show the current editor being used as a text string"$'\n'"Return Code: 1 - If no editor or running program can be determined"$'\n'""
environment="EDITOR - Used as a default editor (first)"$'\n'"VISUAL - Used as another default editor (last)"$'\n'""
file="bin/build/tools/vendor.sh"
fn="contextShow"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceModified="1769063211"
summary="Show the current editor being used as a text string"
usage="contextShow"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcontextShow[0m

Show the current editor being used as a text string
Return Code: 1 - If no editor or running program can be determined

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- EDITOR - Used as a default editor (first)
- VISUAL - Used as another default editor (last)
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: contextShow

Show the current editor being used as a text string
Return Code: 1 - If no editor or running program can be determined

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- EDITOR - Used as a default editor (first)
- VISUAL - Used as another default editor (last)
- 
'
