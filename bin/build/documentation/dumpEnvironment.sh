#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable."$'\n'"--skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly)."$'\n'"--show-skipped - Flag. Show skipped environment variables."$'\n'"--secure-match matchString - String. Optional. If an environment variable matches any case-insensitive part of this string, then hide it. If nothing specified, uses a \`secret\` \`key\` and \`password\`. If one value is specified the list is reset to zero. To show all variables pass a blank or \`-\` value here."$'\n'"--secure-suffix secureSuffix  - EmptyString. Optional. Suffix to display after hidden arguments."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="dump.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output the environment but try to hide secure value"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/dump.sh"
fn="dumpEnvironment"
fnMarker="dumpenvironment"
foundNames=([0]="argument")
line="330"
rawComment="Output the environment but try to hide secure value"$'\n'"Argument: --maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable."$'\n'"Argument: --skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly)."$'\n'"Argument: --show-skipped - Flag. Show skipped environment variables."$'\n'"Argument: --secure-match matchString - String. Optional. If an environment variable matches any case-insensitive part of this string, then hide it. If nothing specified, uses a \`secret\` \`key\` and \`password\`. If one value is specified the list is reset to zero. To show all variables pass a blank or \`-\` value here."$'\n'"Argument: --secure-suffix secureSuffix  - EmptyString. Optional. Suffix to display after hidden arguments."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceHash="63d0b744477aa020f81137dccf35c889f1754a76"
sourceLine="330"
summary="Output the environment but try to hide secure value"
summaryComputed="true"
usage="dumpEnvironment [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --secure-match matchString ] [ --secure-suffix secureSuffix  ] [ --help ]"
