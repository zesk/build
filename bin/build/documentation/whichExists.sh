#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="--any - Flag. Optional. If any binary exists then return 0 (success). Otherwise, all binaries must exist."$'\n'"binary ... - String. Required. One or more Binaries to find in the system \`PATH\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
description="Return Code: 0 - If all values are found (without the \`--any\` flag), or if *any* binary is found with the \`--any\` flag"$'\n'"Return Code: 1 - If any value is not found (without the \`--any\` flag), or if *all* binaries are NOT found with the \`--any\` flag."$'\n'""
example="    whichExists cp date aws ls mv stat || throwEnvironment \"\$handler\" \"Need basic environment to work\" || return \$?"$'\n'"    whichExists --any terraform tofu || throwEnvironment \"\$handler\" \"No available infrastructure providers\" || return \$?"$'\n'"    whichExists --any curl wget || throwEnvironment \"\$handler\" \"No way to download URLs easily\" || return \$?"$'\n'""
file="bin/build/tools/platform.sh"
fn="whichExists"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires")
requires="throwArgument decorate __decorateExtensionEach command"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/platform.sh"
sourceModified="1768759698"
summary="Does a binary exist in the PATH?"$'\n'""
usage="whichExists [ --any ] binary ... [ --help ]"
