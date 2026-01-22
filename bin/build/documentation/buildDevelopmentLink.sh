#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/developer.sh"
argument="--copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization."$'\n'"--reset - Flag. Optional. Revert the link and reinstall using the original binary."$'\n'""
base="developer.sh"
description="Add a development link to the local version of Zesk Build for testing in local projects."$'\n'""$'\n'"Copies or updates \`\$BUILD_HOME/bin/build\` in current project."$'\n'""$'\n'"Useful when you want to test a fix on a current project."$'\n'""
file="bin/build/tools/developer.sh"
fn="buildDevelopmentLink"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/developer.sh"
sourceModified="1768588589"
summary="Add a development link to the local version of Zesk"
usage="buildDevelopmentLink [ --copy ] [ --reset ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildDevelopmentLink[0m [94m[ --copy ][0m [94m[ --reset ][0m

    [94m--copy   [1;97mFlag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.[0m
    [94m--reset  [1;97mFlag. Optional. Revert the link and reinstall using the original binary.[0m

Add a development link to the local version of Zesk Build for testing in local projects.

Copies or updates [38;2;0;255;0;48;2;0;0;0m$BUILD_HOME/bin/build[0m in current project.

Useful when you want to test a fix on a current project.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: buildDevelopmentLink [ --copy ] [ --reset ]

    --copy   Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.
    --reset  Flag. Optional. Revert the link and reinstall using the original binary.

Add a development link to the local version of Zesk Build for testing in local projects.

Copies or updates $BUILD_HOME/bin/build in current project.

Useful when you want to test a fix on a current project.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
