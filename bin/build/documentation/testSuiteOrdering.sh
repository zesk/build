#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--cache cacheDirectory - Directory. Optional. Cache directory to use for ordering work."$'\n'"finderFile - File. Required. File to reorder."$'\n'""
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="No documentation for \`testSuiteOrdering\`."$'\n'""
descriptionLineCount=""
file="bin/build/tools/test.sh"
fn="testSuiteOrdering"
fnMarker="testsuiteordering"
foundNames=([0]="argument" [1]="stdout")
line="495"
rawComment="Argument: --cache cacheDirectory - Directory. Optional. Cache directory to use for ordering work."$'\n'"Argument: finderFile - File. Required. File to reorder."$'\n'"stdout: Reordered file."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="78c7da5cbc1777fd8206d96854e19720ad1957a9"
sourceLine="495"
stdout="Reordered file."$'\n'""
summary="undocumented"
summaryComputed=""
usage="testSuiteOrdering [ --cache cacheDirectory ] finderFile"
