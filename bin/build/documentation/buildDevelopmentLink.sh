#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization."$'\n'"--reset - Flag. Optional. Revert the link and reinstall using the original binary."$'\n'""
base="developer.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Add a development link to the local version of Zesk Build for testing in local projects."$'\n'""$'\n'"Copies or updates \`\$BUILD_HOME/bin/build\` in current project."$'\n'""$'\n'"Useful when you want to test a fix on a current project."$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/developer.sh"
fn="buildDevelopmentLink"
fnMarker="builddevelopmentlink"
foundNames=([0]="argument")
line="181"
rawComment="Add a development link to the local version of Zesk Build for testing in local projects."$'\n'"Copies or updates \`\$BUILD_HOME/bin/build\` in current project."$'\n'"Useful when you want to test a fix on a current project."$'\n'"Argument: --copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization."$'\n'"Argument: --reset - Flag. Optional. Revert the link and reinstall using the original binary."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/developer.sh"
sourceHash="78a593214724db23edf7c0ae664f15c226343bbd"
sourceLine="181"
summary="Add a development link to the local version of Zesk"
summaryComputed="true"
usage="buildDevelopmentLink [ --copy ] [ --reset ]"
