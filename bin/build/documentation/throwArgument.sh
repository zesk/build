#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'handler - Function. Required. Failure command\nmessage ... - String. Optional. Error message to display.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run `handler` with an argument error\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="throwArgument"
fnMarker="throwargument"
foundNames=([0]="argument" [1]="requires")
line="214"
rawComment=$'Run `handler` with an argument error\nArgument: handler - Function. Required. Failure command\nArgument: message ... - String. Optional. Error message to display.\nRequires: isFunction returnArgument decorate debuggingStack\n\n'
requires=$'isFunction returnArgument decorate debuggingStack\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="214"
summary="Run \`handler\` with an argument error"
summaryComputed="true"
usage="throwArgument handler [ message ... ]"
