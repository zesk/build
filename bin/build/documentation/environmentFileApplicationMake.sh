#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"requiredVariable ... - EnvironmentVariable. Optional. One or more environment variables which should be non-blank and included in the \`.env\` file."$'\n'"-- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment. Should appear once and only once."$'\n'"optionalVariable ... - EnvironmentVariable. Optional. One or more environment variables which are included if blank or not"$'\n'""
base="environment.sh"
BASH_LINENO=([0]="129" [1]="963" [2]="226" [3]="237" [4]="82" [5]="65" [6]="75" [7]="22" [8]="54" [9]="129" [10]="115" [11]="65" [12]="75" [13]="16" [14]="37" [15]="727" [16]="51" [17]="129" [18]="37" [19]="226" [20]="237" [21]="358" [22]="173" [23]="123" [24]="150" [25]="154" [26]="0")
description="Create environment file \`.env\` for build."$'\n'""$'\n'"Note that this does NOT change or modify the current environment."$'\n'""$'\n'""
environment="APPLICATION_VERSION - reserved and set to \`hookRun version-current\` if not set already"$'\n'"APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL."$'\n'"APPLICATION_TAG - reserved and set to \`hookRun application-id\`"$'\n'"APPLICATION_ID - reserved and set to \`hookRun application-tag\`"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentFileApplicationMake"
foundNames=([0]="argument" [1]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768759812"
summary="Create environment file \`.env\` for build."
usage="environmentFileApplicationMake [ --help ] [ requiredVariable ... ] [ -- ] [ optionalVariable ... ]"
