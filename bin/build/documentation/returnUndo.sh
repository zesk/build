#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sugar.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"code -  UnsignedInteger. Required. Exit code to return."$'\n'"undoFunction - Optional. Command to run to undo something. Return status is ignored."$'\n'"-- - Flag. Optional. Used to delimit multiple commands."$'\n'""
base="sugar.sh"
description="Run a function and preserve exit code"$'\n'"Returns \`code\`"$'\n'"As a caveat, your command to \`undo\` can NOT take the argument \`--\` as a parameter."$'\n'""
example="    local undo thing"$'\n'"    thing=\$(catchEnvironment \"\$handler\" createLargeResource) || return \$?"$'\n'"    undo+=(-- deleteLargeResource \"\$thing\")"$'\n'"    thing=\$(catchEnvironment \"\$handler\" createMassiveResource) || returnUndo \$? \"\${undo[@]}\" || return \$?"$'\n'"    undo+=(-- deleteMassiveResource \"\$thing\")"$'\n'""
file="bin/build/tools/sugar.sh"
fn="returnUndo"
foundNames=([0]="argument" [1]="example" [2]="requires")
requires="isUnsignedInteger throwArgument decorate execute"$'\n'"usageDocument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/sugar.sh"
sourceModified="1768683999"
summary="Run a function and preserve exit code"
usage="returnUndo [ --help ] code [ undoFunction ] [ -- ]"
