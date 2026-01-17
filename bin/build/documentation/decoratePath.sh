#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"--path pathName=icon -  Flag. Optional.Add an additional path mapping to icon."$'\n'"--no-app -  Flag. Optional.Do not map \`BUILD_HOME\`."$'\n'"--skip-app -  Flag. Optional.Synonym for \`--no-app\`."$'\n'"path - String. Path to display and replace matching paths with icons."$'\n'""
base="decoration.sh"
description="Replace an absolute path prefix with an icon if it matches \`HOME\`, \`BUILD_HOME\` or \`TMPDIR\`"$'\n'"Icons used:"$'\n'"- 💣 - \`TMPDIR\`"$'\n'"- 🍎 - \`BUILD_HOME\`"$'\n'"- 🏠 - \`HOME\`"$'\n'""
environment="TMPDIR"$'\n'"BUILD_HOME"$'\n'"HOME"$'\n'""
file="bin/build/tools/decoration.sh"
fn="decoratePath"
foundNames=([0]="summary" [1]="argument" [2]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/decoration.sh"
sourceModified="1768683999"
summary="Display file paths and replace prefixes with icons"$'\n'""
usage="decoratePath [ --help ] [ --path pathName=icon ] [ --no-app ] [ --skip-app ] [ path ]"
