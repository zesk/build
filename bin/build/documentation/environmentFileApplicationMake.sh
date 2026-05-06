#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"requiredVariable ... - EnvironmentVariable. Optional. One or more environment variables which should be non-blank and included in the \`.env\` file."$'\n'"-- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment. Should appear once and only once."$'\n'"optionalVariable ... - EnvironmentVariable. Optional. One or more environment variables which are included if blank or not"$'\n'""
base="application.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Create environment file \`.env\` for build."$'\n'""$'\n'"Note that this does NOT change or modify the current environment."$'\n'""$'\n'""
descriptionLineCount="4"
environment="APPLICATION_VERSION - reserved and set to \`hookRun version-current\` if not set already"$'\n'"APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL."$'\n'"APPLICATION_TAG - reserved and set to \`hookRun application-id\`"$'\n'"APPLICATION_ID - reserved and set to \`hookRun application-tag\`"$'\n'""
file="bin/build/tools/environment/application.sh"
fn="environmentFileApplicationMake"
fnMarker="environmentfileapplicationmake"
foundNames=([0]="argument" [1]="environment")
line="82"
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: requiredVariable ... - EnvironmentVariable. Optional. One or more environment variables which should be non-blank and included in the \`.env\` file."$'\n'"Argument: -- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment. Should appear once and only once."$'\n'"Argument: optionalVariable ... - EnvironmentVariable. Optional. One or more environment variables which are included if blank or not"$'\n'"Create environment file \`.env\` for build."$'\n'"Note that this does NOT change or modify the current environment."$'\n'"Environment: APPLICATION_VERSION - reserved and set to \`hookRun version-current\` if not set already"$'\n'"Environment: APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL."$'\n'"Environment: APPLICATION_TAG - reserved and set to \`hookRun application-id\`"$'\n'"Environment: APPLICATION_ID - reserved and set to \`hookRun application-tag\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/application.sh"
sourceHash="f877edc58732d2fd005da84e8d7e7ad755c6ef72"
sourceLine="82"
summary="Create environment file \`.env\` for build."
summaryComputed="true"
usage="environmentFileApplicationMake [ --help ] [ requiredVariable ... ] [ -- ] [ optionalVariable ... ]"
