#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/fingerprint.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--verbose - Flag. Optional. Be verbose. Default based on value of \`fingerprint\` in \`BUILD_DEBUG\`."$'\n'"--quiet - Flag. Optional. Be quiet (turns verbose off)."$'\n'"--check - Flag. Optional. Check if the fingerprint is up to date and output the current value."$'\n'"--key - String. Optional. Update this key in the JSON file."$'\n'""
base="fingerprint.sh"
build_debug="fingerprint - By default be verbose even if the flag is not specified. (Use \`--quiet\` to silence if needed)"$'\n'""
description="Update file from \`APPLICATION_JSON\` with application fingerprint."$'\n'""$'\n'""
environment="BUILD_DEBUG"$'\n'""
file="bin/build/tools/fingerprint.sh"
fn="fingerprint"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/fingerprint.sh"
sourceModified="1768721469"
summary="Update file from \`APPLICATION_JSON\` with application fingerprint."
usage="fingerprint [ --help ] [ --handler handler ] [ --verbose ] [ --quiet ] [ --check ] [ --key ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfingerprint[0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ --verbose ][0m [94m[ --quiet ][0m [94m[ --check ][0m [94m[ --key ][0m

    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94m--verbose          [1;97mFlag. Optional. Be verbose. Default based on value of [38;2;0;255;0;48;2;0;0;0mfingerprint[0m in [38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m.[0m
    [94m--quiet            [1;97mFlag. Optional. Be quiet (turns verbose off).[0m
    [94m--check            [1;97mFlag. Optional. Check if the fingerprint is up to date and output the current value.[0m
    [94m--key              [1;97mString. Optional. Update this key in the JSON file.[0m

Update file from [38;2;0;255;0;48;2;0;0;0mAPPLICATION_JSON[0m with application fingerprint.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG
- 

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- fingerprint - By default be verbose even if the flag is not specified. (Use [38;2;0;255;0;48;2;0;0;0m--quiet[0m to silence if needed)
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: fingerprint [ --help ] [ --handler handler ] [ --verbose ] [ --quiet ] [ --check ] [ --key ]

    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    --verbose          Flag. Optional. Be verbose. Default based on value of fingerprint in BUILD_DEBUG.
    --quiet            Flag. Optional. Be quiet (turns verbose off).
    --check            Flag. Optional. Check if the fingerprint is up to date and output the current value.
    --key              String. Optional. Update this key in the JSON file.

Update file from APPLICATION_JSON with application fingerprint.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG
- 

BUILD_DEBUG settings:
- fingerprint - By default be verbose even if the flag is not specified. (Use --quiet to silence if needed)
- 
'
