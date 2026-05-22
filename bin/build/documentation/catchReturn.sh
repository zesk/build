#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-22
# shellcheck disable=SC2034
argument="handler - Function. Required. Error handler."$'\n'"binary ... - Executable. Required. Any arguments are passed to \`binary\`."$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run binary and catch errors with handler"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="catchReturn"
fnMarker="catchreturn"
foundNames=([0]="argument" [1]="requires")
line="284"
rawComment="Run binary and catch errors with handler"$'\n'"Argument: handler - Function. Required. Error handler."$'\n'"Argument: binary ... - Executable. Required. Any arguments are passed to \`binary\`."$'\n'"Requires: returnArgument"$'\n'""$'\n'""
requires="returnArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="859744e8330da27fd03e1da6874909739d06ce70"
sourceLine="284"
summary="Run binary and catch errors with handler"
summaryComputed="true"
usage="catchReturn handler binary ..."
