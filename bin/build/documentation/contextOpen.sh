#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/vendor.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="vendor.sh"
description="Open a file in a shell using the program we are using. Supports VSCode and PHPStorm."$'\n'""$'\n'""
environment="EDITOR - Used as a default editor (first)"$'\n'"VISUAL - Used as another default editor (last)"$'\n'""
file="bin/build/tools/vendor.sh"
fn="contextOpen"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceModified="1768721469"
summary="Open a file in a shell using the program we"
usage="contextOpen [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcontextOpen[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.

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
helpPlain='Usage: contextOpen [ --help ]

    --help  Flag. Optional. Display this help.

Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.

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
