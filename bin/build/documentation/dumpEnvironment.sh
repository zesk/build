#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="--maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable."$'\n'"--skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly)."$'\n'"--show-skipped - Flag. Show skipped environment variables."$'\n'"--secure-match matchString - String. Optional. If an environment variable matches any case-insensitive part of this string, then hide it. If nothing specified, uses a \`secret\` \`key\` and \`password\`. If one value is specified the list is reset to zero. To show all variables pass a blank or \`-\` value here."$'\n'"--secure-suffix secureSuffix  - EmptyString. Optional. Suffix to display after hidden arguments."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="dump.sh"
description="Output the environment but try to hide secure value"$'\n'""$'\n'""
file="bin/build/tools/dump.sh"
fn="dumpEnvironment"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceModified="1768721469"
summary="Output the environment but try to hide secure value"
usage="dumpEnvironment [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --secure-match matchString ] [ --secure-suffix secureSuffix  ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdumpEnvironment[0m [94m[ --maximum-length maximumLength ][0m [94m[ --skip-env environmentVariable ][0m [94m[ --show-skipped ][0m [94m[ --secure-match matchString ][0m [94m[ --secure-suffix secureSuffix  ][0m [94m[ --help ][0m

    [94m--maximum-length maximumLength  [1;97mPositiveInteger. Optional. The maximum number of characters to output for each environment variable.[0m
    [94m--skip-env environmentVariable  [1;97mEnvironmentVariable. Optional. Skip this environment variable (must match exactly).[0m
    [94m--show-skipped                  [1;97mFlag. Show skipped environment variables.[0m
    [94m--secure-match matchString      [1;97mString. Optional. If an environment variable matches any case-insensitive part of this string, then hide it. If nothing specified, uses a [38;2;0;255;0;48;2;0;0;0msecret[0m [38;2;0;255;0;48;2;0;0;0mkey[0m and [38;2;0;255;0;48;2;0;0;0mpassword[0m. If one value is specified the list is reset to zero. To show all variables pass a blank or [38;2;0;255;0;48;2;0;0;0m-[0m value here.[0m
    [94m--secure-suffix secureSuffix    [1;97mEmptyString. Optional. Suffix to display after hidden arguments.[0m
    [94m--help                          [1;97mFlag. Optional. Display this help.[0m

Output the environment but try to hide secure value

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dumpEnvironment [ --maximum-length maximumLength ] [ --skip-env environmentVariable ] [ --show-skipped ] [ --secure-match matchString ] [ --secure-suffix secureSuffix  ] [ --help ]

    --maximum-length maximumLength  PositiveInteger. Optional. The maximum number of characters to output for each environment variable.
    --skip-env environmentVariable  EnvironmentVariable. Optional. Skip this environment variable (must match exactly).
    --show-skipped                  Flag. Show skipped environment variables.
    --secure-match matchString      String. Optional. If an environment variable matches any case-insensitive part of this string, then hide it. If nothing specified, uses a secret key and password. If one value is specified the list is reset to zero. To show all variables pass a blank or - value here.
    --secure-suffix secureSuffix    EmptyString. Optional. Suffix to display after hidden arguments.
    --help                          Flag. Optional. Display this help.

Output the environment but try to hide secure value

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
