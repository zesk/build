#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/vendor.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="vendor.sh"
description="Are we within the JetBrains PHPStorm terminal?"$'\n'""$'\n'"Return Code: 0 - within the PhpStorm terminal"$'\n'"Return Code: 1 - not within the PhpStorm terminal AFAIK"$'\n'""
file="bin/build/tools/vendor.sh"
fn="isPHPStorm"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="contextOpen"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceModified="1769063211"
summary="Are we within the JetBrains PHPStorm terminal?"
usage="isPHPStorm [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misPHPStorm[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Are we within the JetBrains PHPStorm terminal?

Return Code: 0 - within the PhpStorm terminal
Return Code: 1 - not within the PhpStorm terminal AFAIK

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isPHPStorm [ --help ]

    --help  Flag. Optional. Display this help.

Are we within the JetBrains PHPStorm terminal?

Return Code: 0 - within the PhpStorm terminal
Return Code: 1 - not within the PhpStorm terminal AFAIK

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
