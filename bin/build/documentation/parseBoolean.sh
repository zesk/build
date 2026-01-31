#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Parses text and determines if it's true-ish"$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="return_code" [1]="requires")
rawComment="Parses text and determines if it's true-ish"$'\n'"Return Code: 0 - true"$'\n'"Return Code: 1 - false"$'\n'"Return Code: 2 - Neither"$'\n'"Requires: lowercase __help"$'\n'"Without arguments, displays help."$'\n'"Return code: - \`0\` - Text is plain"$'\n'"Return code: - \`1\` - Text contains non-plain characters"$'\n'""$'\n'""
requires="lowercase __help"$'\n'""
return_code="0 - true"$'\n'"1 - false"$'\n'"2 - Neither"$'\n'"- \`0\` - Text is plain"$'\n'"- \`1\` - Text contains non-plain characters"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Parses text and determines if it's true-ish"
summaryComputed="true"
usage="parseBoolean"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mparseBoolean'$'\e''[0m'$'\n'''$'\n''Parses text and determines if it'\''s true-ish'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - true'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - false'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Neither'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Text is plain'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Text contains non-plain characters'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mparseBoolean'$'\n'''$'\n''Parses text and determines if it'\''s true-ish'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - true'$'\n''- [[(code)]m1 - false'$'\n''- [[(code)]m2 - Neither'$'\n''- [[(code)]m0 - Text is plain'$'\n''- [[(code)]m1 - Text contains non-plain characters'$'\n'''
# elapsed 3.3
