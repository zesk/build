#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)\nfile ... - File. Required. A file to search for identical tokens.\n'
base="identical.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'No documentation for `identicalFindTokens`.\n'
descriptionLineCount=""
file="bin/build/tools/identical.sh"
fn="identicalFindTokens"
fnMarker="identicalfindtokens"
foundNames=([0]="argument" [1]="stdout")
line="134"
rawComment=$'Argument: --prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)\nArgument: file ... - File. Required. A file to search for identical tokens.\nstdout: tokens, one per line\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/identical.sh"
sourceHash="ea8e2888c723217827eadc0bd4d2eac27d87f45e"
sourceLine="134"
stdout=$'tokens, one per line\n'
summary="undocumented"
summaryComputed=""
usage="identicalFindTokens --prefix prefix file ..."
