#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n... - Arguments. Required. Arguments to `identicalCheck` for your watch.\n'
base="identical.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution.\nStill a known bug which trims the last end bracket from files\n\n'
descriptionLineCount="3"
file="bin/build/tools/identical.sh"
fn="identicalWatch"
fnMarker="identicalwatch"
foundNames=([0]="argument")
line="150"
rawComment=$'Argument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: ... - Arguments. Required. Arguments to `identicalCheck` for your watch.\nWatch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution.\nStill a known bug which trims the last end bracket from files\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/identical.sh"
sourceHash="ea8e2888c723217827eadc0bd4d2eac27d87f45e"
sourceLine="150"
summary="Watch a project for changes and propagate them immediately upon"
summaryComputed="true"
usage="identicalWatch [ --help ] [ --handler handler ] ..."
