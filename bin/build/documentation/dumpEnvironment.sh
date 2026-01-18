#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="--maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable."$'\n'"--skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly)."$'\n'"--show-skipped - Flag. Show skipped environment variables."$'\n'"--secure-match matchString - String. Optional. If an environment variable matches any case-insensitive part of this string, then hide it. If nothing specified, uses a \`secret\` \`key\` and \`password\`. If one value is specified the list is reset to zero. To show all variables pass a blank or \`-\` value here."$'\n'"--secure-suffix secureSuffix  - EmptyString. Optional. Suffix to display after hidden arguments."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="dump.sh"
description="Output the environment but try to hide secure value"$'\n'""$'\n'""
file="bin/build/tools/dump.sh"
fn="dumpEnvironment"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/dump.sh"
sourceModified="1768695708"
summary="Output the environment but try to hide secure value"
usage="dumpEnvironment [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --secure-match matchString ] [ --secure-suffix secureSuffix  ] [ --help ]"
