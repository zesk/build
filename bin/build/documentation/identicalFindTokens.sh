#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
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
original="identicalFindTokens"
rawComment=$'Argument: --prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)\nArgument: file ... - File. Required. A file to search for identical tokens.\nstdout: tokens, one per line\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/identical.sh"
sourceHash="ea8e2888c723217827eadc0bd4d2eac27d87f45e"
sourceLine="134"
stdout=$'tokens, one per line\n'
summary="undocumented"
summaryComputed=""
usage="identicalFindTokens --prefix prefix file ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]midenticalFindTokens'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m--prefix prefix'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]m--prefix prefix  '$'\e''[[(value)]mString. Required. A text prefix to search for to identify identical sections (e.g. '$'\e''[[(code)]m# IDENTICAL'$'\e''[[(reset)]m) (may specify more than one)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfile ...         '$'\e''[[(value)]mFile. Required. A file to search for identical tokens.'$'\e''[[(reset)]m'$'\n'''$'\n''No documentation for '$'\e''[[(code)]midenticalFindTokens'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''tokens, one per line'
# shellcheck disable=SC2016
helpPlain='Usage: identicalFindTokens --prefix prefix file ...'$'\n'''$'\n''    --prefix prefix  String. Required. A text prefix to search for to identify identical sections (e.g. # IDENTICAL) (may specify more than one)'$'\n''    file ...         File. Required. A file to search for identical tokens.'$'\n'''$'\n''No documentation for identicalFindTokens.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''tokens, one per line'
documentationPath="documentation/source/tools/identical.md"
