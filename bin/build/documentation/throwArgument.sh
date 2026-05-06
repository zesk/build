#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="handler - Function. Required. Failure command"$'\n'"message ... - String. Optional. Error message to display."$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run \`handler\` with an argument error"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="throwArgument"
fnMarker="throwargument"
foundNames=([0]="argument" [1]="requires")
line="215"
rawComment="Run \`handler\` with an argument error"$'\n'"Argument: handler - Function. Required. Failure command"$'\n'"Argument: message ... - String. Optional. Error message to display."$'\n'"Requires: isFunction returnArgument decorate debuggingStack"$'\n'""$'\n'""
requires="isFunction returnArgument decorate debuggingStack"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="a07159f0d529eb650133ee48b457cb1ccff3f0d5"
sourceLine="215"
summary="Run \`handler\` with an argument error"
summaryComputed="true"
usage="throwArgument handler [ message ... ]"
