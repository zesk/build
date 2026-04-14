#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-14
# shellcheck disable=SC2034
argument="suffix - String. Optional. Directory suffix - created if does not exist."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
description="Get the cache directory for the documentation"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationBuildCache"
foundNames=([0]="argument")
line="160"
lowerFn="documentationbuildcache"
rawComment="Get the cache directory for the documentation"$'\n'"Argument: suffix - String. Optional. Directory suffix - created if does not exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="053022e849a1557d427212d89dc2881e59289681"
sourceLine="160"
summary="Get the cache directory for the documentation"
summaryComputed="true"
usage="documentationBuildCache [ suffix ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationBuildCache'$'\e''[0m '$'\e''[[(blue)]m[ suffix ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]msuffix  '$'\e''[[(value)]mString. Optional. Directory suffix - created if does not exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the cache directory for the documentation'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: documentationBuildCache [ suffix ] [ --help ]'$'\n'''$'\n''    suffix  String. Optional. Directory suffix - created if does not exist.'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Get the cache directory for the documentation'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/documentation.md"
