#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. \`# IDENTICAL\`) (may specify more than one)"$'\n'"file ... - File. Required. A file to search for identical tokens."$'\n'""
base="identical.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="No documentation for \`identicalFindTokens\`."$'\n'""
descriptionLineCount=""
file="bin/build/tools/identical.sh"
fn="identicalFindTokens"
fnMarker="identicalfindtokens"
foundNames=([0]="argument" [1]="stdout")
line="127"
rawComment="Argument: --prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. \`# IDENTICAL\`) (may specify more than one)"$'\n'"Argument: file ... - File. Required. A file to search for identical tokens."$'\n'"stdout: tokens, one per line"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/identical.sh"
sourceHash="9b062c3d858b37e9d0bb2c6dc51ad89ca20e549b"
sourceLine="127"
stdout="tokens, one per line"$'\n'""
summary="undocumented"
summaryComputed=""
usage="identicalFindTokens --prefix prefix file ..."
