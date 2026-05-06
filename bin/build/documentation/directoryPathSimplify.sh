#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="path ... - File. Required. One or more paths to simplify"$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Normalizes segments of \`/./\` and \`/../\` in a path without using \`fileRealPath\`"$'\n'"Removes dot and dot-dot paths from a path correctly"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/file.sh"
fn="directoryPathSimplify"
fnMarker="directorypathsimplify"
foundNames=([0]="argument")
line="327"
rawComment="Argument: path ... - File. Required. One or more paths to simplify"$'\n'"Normalizes segments of \`/./\` and \`/../\` in a path without using \`fileRealPath\`"$'\n'"Removes dot and dot-dot paths from a path correctly"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="327"
summary="Normalizes segments of \`/./\` and \`/../\` in a path without"
summaryComputed="true"
usage="directoryPathSimplify path ..."
