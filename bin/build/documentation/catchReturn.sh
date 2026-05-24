#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'handler - Function. Required. Error handler.\nbinary ... - Executable. Required. Any arguments are passed to `binary`.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run binary and catch errors with handler\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="catchReturn"
fnMarker="catchreturn"
foundNames=([0]="argument" [1]="requires")
line="284"
rawComment=$'Run binary and catch errors with handler\nArgument: handler - Function. Required. Error handler.\nArgument: binary ... - Executable. Required. Any arguments are passed to `binary`.\nRequires: returnArgument\n\n'
requires=$'returnArgument\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="8d5ac9aefc03ec2923c4a48ed0d33aed85646581"
sourceLine="284"
summary="Run binary and catch errors with handler"
summaryComputed="true"
usage="catchReturn handler binary ..."
