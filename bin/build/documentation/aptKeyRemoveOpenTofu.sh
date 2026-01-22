#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/tofu.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="tofu.sh"
description="Remove keys to disable apt to download tofu from opentofu.org"$'\n'"Return Code: 1 - Environment problems"$'\n'"Return Code: 0 - All good to install tofu"$'\n'""
file="bin/build/tools/tofu.sh"
fn="aptKeyRemoveOpenTofu"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="aptKeyAddOpenTofu"$'\n'""
sourceFile="bin/build/tools/tofu.sh"
sourceModified="1768721469"
summary="Remove keys to disable apt to download tofu from opentofu.org"
usage="aptKeyRemoveOpenTofu [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255maptKeyRemoveOpenTofu[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Remove keys to disable apt to download tofu from opentofu.org
Return Code: 1 - Environment problems
Return Code: 0 - All good to install tofu

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: aptKeyRemoveOpenTofu [ --help ]

    --help  Flag. Optional. Display this help.

Remove keys to disable apt to download tofu from opentofu.org
Return Code: 1 - Environment problems
Return Code: 0 - All good to install tofu

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
