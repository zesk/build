#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'handler - Function. Required. Error handler.\nmessage ... - String. Optional. Error message\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run `handler` with an environment error\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="throwEnvironment"
fnMarker="throwenvironment"
foundNames=([0]="argument" [1]="requires")
line="226"
rawComment=$'Run `handler` with an environment error\nArgument: handler - Function. Required. Error handler.\nArgument: message ... - String. Optional. Error message\nRequires: isFunction returnArgument decorate debuggingStack\n\n'
requires=$'isFunction returnArgument decorate debuggingStack\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="8d5ac9aefc03ec2923c4a48ed0d33aed85646581"
sourceLine="226"
summary="Run \`handler\` with an environment error"
summaryComputed="true"
usage="throwEnvironment handler [ message ... ]"
