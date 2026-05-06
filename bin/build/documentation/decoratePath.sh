#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--path pathName=icon - Flag. Optional. Add an additional path mapping to icon."$'\n'"--no-app - Flag. Optional. Do not map \`BUILD_HOME\`."$'\n'"--skip-app - Flag. Optional. Synonym for \`--no-app\`."$'\n'"path - String. Path to display and replace matching paths with icons."$'\n'""
base="path.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Replace an absolute path prefix with an icon if it matches \`HOME\`, \`BUILD_HOME\` or \`TMPDIR\`"$'\n'"Icons used:"$'\n'"- 💣 - \`TMPDIR\`"$'\n'"- 🍎 - \`BUILD_HOME\`"$'\n'"- 🏠 - \`HOME\`"$'\n'""$'\n'""
descriptionLineCount="6"
environment="TMPDIR"$'\n'"BUILD_HOME"$'\n'"HOME"$'\n'""
file="bin/build/tools/decorate/path.sh"
fn="decoratePath"
fnMarker="decoratepath"
foundNames=([0]="summary" [1]="argument" [2]="environment")
line="21"
rawComment="Summary: Display file paths and replace prefixes with icons"$'\n'"Replace an absolute path prefix with an icon if it matches \`HOME\`, \`BUILD_HOME\` or \`TMPDIR\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --path pathName=icon - Flag. Optional. Add an additional path mapping to icon."$'\n'"Argument: --no-app - Flag. Optional. Do not map \`BUILD_HOME\`."$'\n'"Argument: --skip-app - Flag. Optional. Synonym for \`--no-app\`."$'\n'"Argument: path - String. Path to display and replace matching paths with icons."$'\n'"Icons used:"$'\n'"- 💣 - \`TMPDIR\`"$'\n'"- 🍎 - \`BUILD_HOME\`"$'\n'"- 🏠 - \`HOME\`"$'\n'"Environment: TMPDIR"$'\n'"Environment: BUILD_HOME"$'\n'"Environment: HOME"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/path.sh"
sourceHash="1f959f28b75bd7359b6cfa5f9964fd1324809cdd"
sourceLine="21"
summary="Display file paths and replace prefixes with icons"
summaryComputed=""
usage="decoratePath [ --help ] [ --path pathName=icon ] [ --no-app ] [ --skip-app ] [ path ]"
