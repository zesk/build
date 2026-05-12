#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'message ... - String. Optional. Message to output.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Return `environment` error code. Outputs `message ...` to `stderr`.\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="returnEnvironment"
fnMarker="returnenvironment"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="264"
rawComment=$'Return `environment` error code. Outputs `message ...` to `stderr`.\nArgument: message ... - String. Optional. Message to output.\nReturn Code: 1\nRequires: returnMessage\n\n'
requires=$'returnMessage\n'
return_code=$'1\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="264"
summary="Return \`environment\` error code. Outputs \`message ...\` to \`stderr\`."
summaryComputed="true"
usage="returnEnvironment [ message ... ]"
