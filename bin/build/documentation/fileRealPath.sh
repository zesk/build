#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="file ... - File. Required. One or more files to \`realpath\`."$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Find the full, actual path of a file avoiding symlinks or redirection."$'\n'"Without arguments, displays help."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/file.sh"
fn="fileRealPath"
fnMarker="filerealpath"
foundNames=([0]="see" [1]="argument" [2]="requires")
line="298"
rawComment="Find the full, actual path of a file avoiding symlinks or redirection."$'\n'"See: readlink realpath"$'\n'"Without arguments, displays help."$'\n'"Argument: file ... - File. Required. One or more files to \`realpath\`."$'\n'"Requires: executableExists realpath helpArgument bashDocumentation returnArgument"$'\n'""$'\n'""
requires="executableExists realpath helpArgument bashDocumentation returnArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="readlink realpath"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="298"
summary="Find the full, actual path of a file avoiding symlinks"
summaryComputed="true"
usage="fileRealPath file ..."
