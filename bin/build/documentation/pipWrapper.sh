#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--bin binary - Executable. Optional. Binary for \`pip\`."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--debug - Flag. Optional. Show outputs to \`which\` and \`command -v\` for \`pip\`"$'\n'"... - Arguments. Optional. Arguments passed to \`pip\`"$'\n'""
base="python.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run pip whether it is installed as a module or as a binary"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/python.sh"
fn="pipWrapper"
fnMarker="pipwrapper"
foundNames=([0]="argument")
line="206"
rawComment="Run pip whether it is installed as a module or as a binary"$'\n'"Argument: --bin binary - Executable. Optional. Binary for \`pip\`."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --debug - Flag. Optional. Show outputs to \`which\` and \`command -v\` for \`pip\`"$'\n'"Argument: ... - Arguments. Optional. Arguments passed to \`pip\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceHash="c5956e3d32ee75e52908b4d36d8cfde5928066e8"
sourceLine="206"
summary="Run pip whether it is installed as a module or"
summaryComputed="true"
usage="pipWrapper [ --bin binary ] [ --handler handler ] [ --help ] [ --debug ] [ ... ]"
