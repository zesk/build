#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\ncode - UnsignedInteger. Required. Exit code to return.\nundoFunction - Callable. Optional. Command to run to undo something. Return status is ignored.\n-- - Flag. Optional. Used to delimit multiple commands.\n'
base="sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run a function and preserve exit code\nReturns `code`\nAs a caveat, your command to `undo` can NOT take the argument `--` as a parameter.\n\n'
descriptionLineCount="4"
example=$'    local undo thing\n    thing=$(catchEnvironment "$handler" createLargeResource) || return $?\n    undo+=(-- deleteLargeResource "$thing")\n    thing=$(catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?\n    undo+=(-- deleteMassiveResource "$thing")\n'
file="bin/build/tools/sugar.sh"
fn="returnUndo"
fnMarker="returnundo"
foundNames=([0]="argument" [1]="example" [2]="requires")
line="131"
rawComment=$'Run a function and preserve exit code\nReturns `code`\nArgument: --help - Flag. Optional. Display this help.\nArgument: code - UnsignedInteger. Required. Exit code to return.\nArgument: undoFunction - Callable. Optional. Command to run to undo something. Return status is ignored.\nArgument: -- - Flag. Optional. Used to delimit multiple commands.\nAs a caveat, your command to `undo` can NOT take the argument `--` as a parameter.\nExample:     local undo thing\nExample:     thing=$(catchEnvironment "$handler" createLargeResource) || return $?\nExample:     undo+=(-- deleteLargeResource "$thing")\nExample:     thing=$(catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?\nExample:     undo+=(-- deleteMassiveResource "$thing")\nRequires: isUnsignedInteger throwArgument decorate execute\nRequires: bashDocumentation\n\n'
requires=$'isUnsignedInteger throwArgument decorate execute\nbashDocumentation\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/sugar.sh"
sourceHash="e8338cd30cac46f1f4725c84ca79d511b7921f72"
sourceLine="131"
summary="Run a function and preserve exit code"
summaryComputed="true"
thing=""
usage="returnUndo [ --help ] code [ undoFunction ] [ -- ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnUndo'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcode'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ undoFunction ]'$'\e''[0m '$'\e''[[(blue)]m[ -- ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcode          '$'\e''[[(value)]mUnsignedInteger. Required. Exit code to return.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mundoFunction  '$'\e''[[(value)]mCallable. Optional. Command to run to undo something. Return status is ignored.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--            '$'\e''[[(value)]mFlag. Optional. Used to delimit multiple commands.'$'\e''[[(reset)]m'$'\n'''$'\n''Run a function and preserve exit code'$'\n''Returns '$'\e''[[(code)]mcode'$'\e''[[(reset)]m'$'\n''As a caveat, your command to '$'\e''[[(code)]mundo'$'\e''[[(reset)]m can NOT take the argument '$'\e''[[(code)]m--'$'\e''[[(reset)]m as a parameter.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    local undo thing'$'\n''    thing=$(catchEnvironment "$handler" createLargeResource) || return $?'$'\n''    undo+=(-- deleteLargeResource "$thing")'$'\n''    thing=$(catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?'$'\n''    undo+=(-- deleteMassiveResource "$thing")'
# shellcheck disable=SC2016
helpPlain='Usage: returnUndo [ --help ] code [ undoFunction ] [ -- ]'$'\n'''$'\n''    --help        Flag. Optional. Display this help.'$'\n''    code          UnsignedInteger. Required. Exit code to return.'$'\n''    undoFunction  Callable. Optional. Command to run to undo something. Return status is ignored.'$'\n''    --            Flag. Optional. Used to delimit multiple commands.'$'\n'''$'\n''Run a function and preserve exit code'$'\n''Returns code'$'\n''As a caveat, your command to undo can NOT take the argument -- as a parameter.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    local undo thing'$'\n''    thing=$(catchEnvironment "$handler" createLargeResource) || return $?'$'\n''    undo+=(-- deleteLargeResource "$thing")'$'\n''    thing=$(catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?'$'\n''    undo+=(-- deleteMassiveResource "$thing")'
documentationPath="documentation/source/tools/sugar-core.md"
