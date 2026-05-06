#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="handler - Function. Required. Error handler."$'\n'"message ... - String. Optional. Error message"$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run \`handler\` with an environment error"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="throwEnvironment"
fnMarker="throwenvironment"
foundNames=([0]="argument" [1]="requires")
line="226"
rawComment="Run \`handler\` with an environment error"$'\n'"Argument: handler - Function. Required. Error handler."$'\n'"Argument: message ... - String. Optional. Error message"$'\n'"Requires: isFunction returnArgument decorate debuggingStack"$'\n'""$'\n'""
requires="isFunction returnArgument decorate debuggingStack"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="a07159f0d529eb650133ee48b457cb1ccff3f0d5"
sourceLine="226"
summary="Run \`handler\` with an environment error"
summaryComputed="true"
usage="throwEnvironment handler [ message ... ]"
