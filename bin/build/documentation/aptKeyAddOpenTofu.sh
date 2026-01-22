#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/tofu.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="tofu.sh"
description="Add keys to enable apt to download tofu directly from opentofu.org"$'\n'""$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - All good to install terraform"$'\n'""
file="bin/build/tools/tofu.sh"
fn="aptKeyAddOpenTofu"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="aptKeyRemoveOpenTofu"$'\n'""
sourceFile="bin/build/tools/tofu.sh"
sourceModified="1769063211"
summary="Add keys to enable apt to download tofu directly from"
usage="aptKeyAddOpenTofu [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255maptKeyAddOpenTofu[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Add keys to enable apt to download tofu directly from opentofu.org

Return Code: 1 - if environment is awry
Return Code: 0 - All good to install terraform

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: aptKeyAddOpenTofu [ --help ]

    --help  Flag. Optional. Display this help.

Add keys to enable apt to download tofu directly from opentofu.org

Return Code: 1 - if environment is awry
Return Code: 0 - All good to install terraform

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
