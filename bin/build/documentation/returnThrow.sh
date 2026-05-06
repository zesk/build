#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="returnCode - Integer. Required. Return code."$'\n'"handler - Function. Required. Error handler."$'\n'"message ... - String. Optional. Error message"$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run \`handler\` with a passed return code"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="returnThrow"
fnMarker="returnthrow"
foundNames=([0]="argument" [1]="requires")
line="274"
rawComment="Run \`handler\` with a passed return code"$'\n'"Argument: returnCode - Integer. Required. Return code."$'\n'"Argument: handler - Function. Required. Error handler."$'\n'"Argument: message ... - String. Optional. Error message"$'\n'"Requires: returnArgument"$'\n'""$'\n'""
requires="returnArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="a07159f0d529eb650133ee48b457cb1ccff3f0d5"
sourceLine="274"
summary="Run \`handler\` with a passed return code"
summaryComputed="true"
usage="returnThrow returnCode handler [ message ... ]"
