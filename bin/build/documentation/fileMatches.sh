#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"pattern ... - String. Required.\`grep -e\` Pattern to find in files. No quoting is added so ensure these are compatible with \`grep -e\`."$'\n'"-- - Delimiter. Required. exception."$'\n'"exception ... - String. Optional. \`grep -e\` File pattern which should be ignored."$'\n'"-- - Delimiter. Required. file."$'\n'"file ... - File. Required. File to search. Special file \`-\` indicates files should be read from \`stdin\`."$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Find one or more patterns in a list of files, with a list of file name pattern exceptions."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="fileMatches"
fnMarker="filematches"
foundNames=([0]="argument")
line="557"
rawComment="Find one or more patterns in a list of files, with a list of file name pattern exceptions."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: pattern ... - String. Required.\`grep -e\` Pattern to find in files. No quoting is added so ensure these are compatible with \`grep -e\`."$'\n'"Argument: -- - Delimiter. Required. exception."$'\n'"Argument: exception ... - String. Optional. \`grep -e\` File pattern which should be ignored."$'\n'"Argument: -- - Delimiter. Required. file."$'\n'"Argument: file ... - File. Required. File to search. Special file \`-\` indicates files should be read from \`stdin\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="557"
summary="Find one or more patterns in a list of files,"
summaryComputed="true"
usage="fileMatches [ --help ] pattern ... -- [ exception ... ] -- file ..."
