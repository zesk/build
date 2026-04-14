#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-14
# shellcheck disable=SC2034
argument="cacheDirectory - Required. Cache directory where the index will be created."$'\n'"documentationSource ... - OneOrMore. Documentation source path to find tokens and their definitions."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
description="Generate the documentation index (e.g. functions defined in the documentation)"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationIndexDocumentation"
foundNames=([0]="argument" [1]="return_code")
line="366"
lowerFn="documentationindexdocumentation"
rawComment="Generate the documentation index (e.g. functions defined in the documentation)"$'\n'"Argument: cacheDirectory - Required. Cache directory where the index will be created."$'\n'"Argument: documentationSource ... - OneOrMore. Documentation source path to find tokens and their definitions."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Issue with file generation"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - If success"$'\n'"1 - Issue with file generation"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="053022e849a1557d427212d89dc2881e59289681"
sourceLine="366"
summary="Generate the documentation index (e.g. functions defined in the documentation)"
summaryComputed="true"
usage="documentationIndexDocumentation cacheDirectory [ documentationSource ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationIndexDocumentation'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcacheDirectory'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ documentationSource ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcacheDirectory           '$'\e''[[(value)]mRequired. Cache directory where the index will be created.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mdocumentationSource ...  '$'\e''[[(value)]mOneOrMore. Documentation source path to find tokens and their definitions.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate the documentation index (e.g. functions defined in the documentation)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Issue with file generation'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: documentationIndexDocumentation cacheDirectory [ documentationSource ... ] [ --help ]'$'\n'''$'\n''    cacheDirectory           Required. Cache directory where the index will be created.'$'\n''    documentationSource ...  OneOrMore. Documentation source path to find tokens and their definitions.'$'\n''    --help                   Flag. Optional. Display this help.'$'\n'''$'\n''Generate the documentation index (e.g. functions defined in the documentation)'$'\n'''$'\n''Return codes:'$'\n''- 0 - If success'$'\n''- 1 - Issue with file generation'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/documentation.md"
