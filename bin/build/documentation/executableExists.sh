#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--any - Flag. Optional. If any binary exists then return 0 (success). Otherwise, all binaries must exist."$'\n'"binary ... - String. Required. One or more Binaries to find in the system \`PATH\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does a binary exist in the PATH?"
descriptionLineCount=""
example="    executableExists cp date aws ls mv stat || throwEnvironment \"\$handler\" \"Need basic environment to work\" || return \$?"$'\n'"    executableExists --any terraform tofu || throwEnvironment \"\$handler\" \"No available infrastructure providers\" || return \$?"$'\n'"    executableExists --any curl wget || throwEnvironment \"\$handler\" \"No way to download URLs easily\" || return \$?"$'\n'""
file="bin/build/tools/platform.sh"
fn="executableExists"
fnMarker="executableexists"
foundNames=([0]="summary" [1]="argument" [2]="return_code" [3]="example" [4]="requires")
line="174"
rawComment="Summary: Does a binary exist in the PATH?"$'\n'"Argument: --any - Flag. Optional. If any binary exists then return 0 (success). Otherwise, all binaries must exist."$'\n'"Argument: binary ... - String. Required. One or more Binaries to find in the system \`PATH\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - If all values are found (without the \`--any\` flag), or if *any* binary is found with the \`--any\` flag"$'\n'"Return Code: 1 - If any value is not found (without the \`--any\` flag), or if *all* binaries are NOT found with the \`--any\` flag."$'\n'"Example:     executableExists cp date aws ls mv stat || throwEnvironment \"\$handler\" \"Need basic environment to work\" || return \$?"$'\n'"Example:     executableExists --any terraform tofu || throwEnvironment \"\$handler\" \"No available infrastructure providers\" || return \$?"$'\n'"Example:     executableExists --any curl wget || throwEnvironment \"\$handler\" \"No way to download URLs easily\" || return \$?"$'\n'"Requires: throwArgument decorate __decorateExtensionEach command"$'\n'""$'\n'""
requires="throwArgument decorate __decorateExtensionEach command"$'\n'""
return_code="0 - If all values are found (without the \`--any\` flag), or if *any* binary is found with the \`--any\` flag"$'\n'"1 - If any value is not found (without the \`--any\` flag), or if *all* binaries are NOT found with the \`--any\` flag."$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="097e41ee15602cdab3bc28d8a420362c8b93b425"
sourceLine="174"
summary="Does a binary exist in the PATH?"
summaryComputed=""
usage="executableExists [ --any ] binary ... [ --help ]"
