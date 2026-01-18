#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"requiredVariable ... - Optional. One or more environment variables which should be non-blank and included in the \`.env\` file."$'\n'"-- - Divider. Optional.Divides the requiredEnvironment values from the optionalEnvironment. Should appear once and only once."$'\n'"optionalVariable ... - Optional. One or more environment variables which are included if blank or not"$'\n'""
base="environment.sh"
description="Create environment file \`.env\` for build."$'\n'""$'\n'"Note that this does NOT change or modify the current environment."$'\n'""$'\n'""
environment="APPLICATION_VERSION - reserved and set to \`hookRun version-current\` if not set already"$'\n'"APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL."$'\n'"APPLICATION_TAG - reserved and set to \`hookRun application-id\`"$'\n'"APPLICATION_ID - reserved and set to \`hookRun application-tag\`"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentFileApplicationMake"
foundNames=([0]="argument" [1]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768695708"
summary="Create environment file \`.env\` for build."
usage="environmentFileApplicationMake [ --help ] [ requiredVariable ... ] [ -- ] [ optionalVariable ... ]"
