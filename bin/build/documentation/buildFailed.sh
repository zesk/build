#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/pipeline.sh"
argument="logFile - File. Required. The most recent log from the current script."$'\n'"message - String. Optional. Any additional message to output."$'\n'""
base="pipeline.sh"
description="Outputs debugging information after build fails:"$'\n'""$'\n'"- last 50 lines in build log"$'\n'"- Failed message"$'\n'"- last 3 lines in build log"$'\n'""$'\n'""$'\n'"Return Code: 1 - Always fails"$'\n'""
example="    quietLog=\"\$(buildQuietLog \"\$me\")\""$'\n'"    if ! ./bin/deploy.sh >>\"\$quietLog\"; then"$'\n'"        decorate error \"Deploy failed\""$'\n'"        buildFailed \"\$quietLog\""$'\n'"    fi"$'\n'""
file="bin/build/tools/pipeline.sh"
fn="buildFailed"
foundNames=""
output="stdout"$'\n'""
quietLog=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/pipeline.sh"
sourceModified="1769063211"
summary="Output debugging information when the build fails"$'\n'""
usage="buildFailed logFile [ message ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildFailed[0m [38;2;255;255;0m[35;48;2;0;0;0mlogFile[0m[0m [94m[ message ][0m

    [31mlogFile  [1;97mFile. Required. The most recent log from the current script.[0m
    [94mmessage  [1;97mString. Optional. Any additional message to output.[0m

Outputs debugging information after build fails:

- last 50 lines in build log
- Failed message
- last 3 lines in build log


Return Code: 1 - Always fails

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    quietLog="$(buildQuietLog "$me")"
    if ! ./bin/deploy.sh >>"$quietLog"; then
        decorate error "Deploy failed"
        buildFailed "$quietLog"
    fi
'
# shellcheck disable=SC2016
helpPlain='Usage: buildFailed logFile [ message ]

    logFile  File. Required. The most recent log from the current script.
    message  String. Optional. Any additional message to output.

Outputs debugging information after build fails:

- last 50 lines in build log
- Failed message
- last 3 lines in build log


Return Code: 1 - Always fails

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    quietLog="$(buildQuietLog "$me")"
    if ! ./bin/deploy.sh >>"$quietLog"; then
        decorate error "Deploy failed"
        buildFailed "$quietLog"
    fi
'
