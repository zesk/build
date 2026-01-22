#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/vendor.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="vendor.sh"
description="Are we within the JetBrains PyCharm terminal?"$'\n'""$'\n'"Return Code: 0 - within the PyCharm terminal"$'\n'"Return Code: 1 - not within the PyCharm terminal AFAIK"$'\n'""
file="bin/build/tools/vendor.sh"
fn="isPyCharm"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="contextOpen"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceModified="1768721469"
summary="Are we within the JetBrains PyCharm terminal?"
usage="isPyCharm [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misPyCharm[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Are we within the JetBrains PyCharm terminal?

Return Code: 0 - within the PyCharm terminal
Return Code: 1 - not within the PyCharm terminal AFAIK

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isPyCharm [ --help ]

    --help  Flag. Optional. Display this help.

Are we within the JetBrains PyCharm terminal?

Return Code: 0 - within the PyCharm terminal
Return Code: 1 - not within the PyCharm terminal AFAIK

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
