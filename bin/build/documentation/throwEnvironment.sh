#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
line="225"
rawComment=$'Run `handler` with an environment error\nArgument: handler - Function. Required. Error handler.\nArgument: message ... - String. Optional. Error message\nRequires: isFunction returnArgument decorate debuggingStack\n\n'
requires=$'isFunction returnArgument decorate debuggingStack\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="225"
summary="Run \`handler\` with an environment error"
summaryComputed="true"
usage="throwEnvironment handler [ message ... ]"
