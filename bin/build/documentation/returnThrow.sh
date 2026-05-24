#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'returnCode - Integer. Required. Return code.\nhandler - Function. Required. Error handler.\nmessage ... - String. Optional. Error message\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run `handler` with a passed return code\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="returnThrow"
fnMarker="returnthrow"
foundNames=([0]="argument" [1]="requires")
line="274"
rawComment=$'Run `handler` with a passed return code\nArgument: returnCode - Integer. Required. Return code.\nArgument: handler - Function. Required. Error handler.\nArgument: message ... - String. Optional. Error message\nRequires: returnArgument\n\n'
requires=$'returnArgument\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="8d5ac9aefc03ec2923c4a48ed0d33aed85646581"
sourceLine="274"
summary="Run \`handler\` with a passed return code"
summaryComputed="true"
usage="returnThrow returnCode handler [ message ... ]"
