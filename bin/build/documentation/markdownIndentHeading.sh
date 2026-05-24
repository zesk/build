#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument="none"
base="markdown.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Add an indent to all markdown headings\n\n'
descriptionLineCount="2"
file="bin/build/tools/markdown.sh"
fn="markdownIndentHeading"
fnMarker="markdownindentheading"
foundNames=()
line="15"
rawComment=$'Add an indent to all markdown headings\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/markdown.sh"
sourceHash="b0c6db65fd4dec5df3f8a36220ec0140b58ea621"
sourceLine="15"
summary="Add an indent to all markdown headings"
summaryComputed="true"
usage="markdownIndentHeading"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmarkdownIndentHeading'$'\e''[0m'$'\n'''$'\n''Add an indent to all markdown headings'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: markdownIndentHeading'$'\n'''$'\n''Add an indent to all markdown headings'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/markdown.md"
