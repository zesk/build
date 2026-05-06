#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"code - UnsignedInteger. Required. Exit code to return."$'\n'"undoFunction - Callable. Optional. Command to run to undo something. Return status is ignored."$'\n'"-- - Flag. Optional. Used to delimit multiple commands."$'\n'""
base="sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run a function and preserve exit code"$'\n'"Returns \`code\`"$'\n'"As a caveat, your command to \`undo\` can NOT take the argument \`--\` as a parameter."$'\n'""$'\n'""
descriptionLineCount="4"
example="    local undo thing"$'\n'"    thing=\$(catchEnvironment \"\$handler\" createLargeResource) || return \$?"$'\n'"    undo+=(-- deleteLargeResource \"\$thing\")"$'\n'"    thing=\$(catchEnvironment \"\$handler\" createMassiveResource) || returnUndo \$? \"\${undo[@]}\" || return \$?"$'\n'"    undo+=(-- deleteMassiveResource \"\$thing\")"$'\n'""
file="bin/build/tools/sugar.sh"
fn="returnUndo"
fnMarker="returnundo"
foundNames=([0]="argument" [1]="example" [2]="requires")
line="131"
rawComment="Run a function and preserve exit code"$'\n'"Returns \`code\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: code - UnsignedInteger. Required. Exit code to return."$'\n'"Argument: undoFunction - Callable. Optional. Command to run to undo something. Return status is ignored."$'\n'"Argument: -- - Flag. Optional. Used to delimit multiple commands."$'\n'"As a caveat, your command to \`undo\` can NOT take the argument \`--\` as a parameter."$'\n'"Example:     local undo thing"$'\n'"Example:     thing=\$(catchEnvironment \"\$handler\" createLargeResource) || return \$?"$'\n'"Example:     undo+=(-- deleteLargeResource \"\$thing\")"$'\n'"Example:     thing=\$(catchEnvironment \"\$handler\" createMassiveResource) || returnUndo \$? \"\${undo[@]}\" || return \$?"$'\n'"Example:     undo+=(-- deleteMassiveResource \"\$thing\")"$'\n'"Requires: isUnsignedInteger throwArgument decorate execute"$'\n'"Requires: bashDocumentation"$'\n'""$'\n'""
requires="isUnsignedInteger throwArgument decorate execute"$'\n'"bashDocumentation"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="e8338cd30cac46f1f4725c84ca79d511b7921f72"
sourceLine="131"
summary="Run a function and preserve exit code"
summaryComputed="true"
thing=""
usage="returnUndo [ --help ] code [ undoFunction ] [ -- ]"
