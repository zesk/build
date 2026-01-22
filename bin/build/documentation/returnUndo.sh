#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sugar.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"code - UnsignedInteger. Required. Exit code to return."$'\n'"undoFunction - Callable. Optional. Command to run to undo something. Return status is ignored."$'\n'"-- - Flag. Optional. Used to delimit multiple commands."$'\n'""
base="sugar.sh"
description="Run a function and preserve exit code"$'\n'"Returns \`code\`"$'\n'"As a caveat, your command to \`undo\` can NOT take the argument \`--\` as a parameter."$'\n'""
example="    local undo thing"$'\n'"    thing=\$(catchEnvironment \"\$handler\" createLargeResource) || return \$?"$'\n'"    undo+=(-- deleteLargeResource \"\$thing\")"$'\n'"    thing=\$(catchEnvironment \"\$handler\" createMassiveResource) || returnUndo \$? \"\${undo[@]}\" || return \$?"$'\n'"    undo+=(-- deleteMassiveResource \"\$thing\")"$'\n'""
file="bin/build/tools/sugar.sh"
fn="returnUndo"
foundNames=""
requires="isUnsignedInteger throwArgument decorate execute"$'\n'"usageDocument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceModified="1768769473"
summary="Run a function and preserve exit code"
thing=""
usage="returnUndo [ --help ] code [ undoFunction ] [ -- ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mreturnUndo[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0mcode[0m[0m [94m[ undoFunction ][0m [94m[ -- ][0m

    [94m--help        [1;97mFlag. Optional. Display this help.[0m
    [31mcode          [1;97mUnsignedInteger. Required. Exit code to return.[0m
    [94mundoFunction  [1;97mCallable. Optional. Command to run to undo something. Return status is ignored.[0m
    [94m--            [1;97mFlag. Optional. Used to delimit multiple commands.[0m

Run a function and preserve exit code
Returns [38;2;0;255;0;48;2;0;0;0mcode[0m
As a caveat, your command to [38;2;0;255;0;48;2;0;0;0mundo[0m can NOT take the argument [38;2;0;255;0;48;2;0;0;0m--[0m as a parameter.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    local undo thing
    thing=$(catchEnvironment "$handler" createLargeResource) || return $?
    undo+=(-- deleteLargeResource "$thing")
    thing=$(catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?
    undo+=(-- deleteMassiveResource "$thing")
'
# shellcheck disable=SC2016
helpPlain='Usage: returnUndo [ --help ] code [ undoFunction ] [ -- ]

    --help        Flag. Optional. Display this help.
    code          UnsignedInteger. Required. Exit code to return.
    undoFunction  Callable. Optional. Command to run to undo something. Return status is ignored.
    --            Flag. Optional. Used to delimit multiple commands.

Run a function and preserve exit code
Returns code
As a caveat, your command to undo can NOT take the argument -- as a parameter.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    local undo thing
    thing=$(catchEnvironment "$handler" createLargeResource) || return $?
    undo+=(-- deleteLargeResource "$thing")
    thing=$(catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?
    undo+=(-- deleteMassiveResource "$thing")
'
