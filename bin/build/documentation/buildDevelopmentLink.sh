#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/developer.sh"
argument="--copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization."$'\n'"--reset - Flag. Optional. Revert the link and reinstall using the original binary."$'\n'""
base="developer.sh"
description="Add a development link to the local version of Zesk Build for testing in local projects."$'\n'""$'\n'"Copies or updates \`\$BUILD_HOME/bin/build\` in current project."$'\n'""$'\n'"Useful when you want to test a fix on a current project."$'\n'""
file="bin/build/tools/developer.sh"
fn="buildDevelopmentLink"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""$'\n'""$'\n'""
source="bin/build/tools/developer.sh"
sourceModified="1768588589"
summary="Add a development link to the local version of Zesk"
usage="buildDevelopmentLink [ --copy ] [ --reset ]"
