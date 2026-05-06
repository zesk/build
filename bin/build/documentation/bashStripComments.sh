#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Removes literally any line which begins with zero or more whitespace characters and then a \`#\`."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashStripComments"
fnMarker="bashstripcomments"
foundNames=([0]="summary" [1]="argument")
line="296"
rawComment="Summary: Pipe to strip comments from a bash file"$'\n'"Removes literally any line which begins with zero or more whitespace characters and then a \`#\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="9d7b158a0e679532b85d7d28ad6415566e66b29c"
sourceLine="296"
summary="Pipe to strip comments from a bash file"
summaryComputed=""
usage="bashStripComments [ --help ]"
