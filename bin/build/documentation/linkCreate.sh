#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'target - Exists. File. Source file name or path.\nlinkName - String. Required. Link short name, created next to `target`.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Create a link\n\n'
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="linkCreate"
fnMarker="linkcreate"
foundNames=([0]="argument")
line="730"
rawComment=$'Create a link\nArgument: target - Exists. File. Source file name or path.\nArgument: linkName - String. Required. Link short name, created next to `target`.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="730"
summary="Create a link"
summaryComputed="true"
usage="linkCreate [ target ] linkName"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlinkCreate'$'\e''[0m '$'\e''[[(blue)]m[ target ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlinkName'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtarget    '$'\e''[[(value)]mExists. File. Source file name or path.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mlinkName  '$'\e''[[(value)]mString. Required. Link short name, created next to '$'\e''[[(code)]mtarget'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Create a link'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: linkCreate [ target ] linkName'$'\n'''$'\n''    target    Exists. File. Source file name or path.'$'\n''    linkName  String. Required. Link short name, created next to target.'$'\n'''$'\n''Create a link'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/file.md"
