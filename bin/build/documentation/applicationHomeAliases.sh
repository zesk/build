#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'goAlias - String. Alias for `applicationHome --go`. Default is `g`.\nsetAlias - String. Alias for `applicationHome`. Default is `G`.\n'
base="application.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Set aliases `G` and `g` (defaults) to aliases of `applicationHome`\nLocalize as you wish for your own shell\n\n'
descriptionLineCount="3"
file="bin/build/tools/application.sh"
fn="applicationHomeAliases"
fnMarker="applicationhomealiases"
foundNames=([0]="summary" [1]="argument")
line="100"
original="applicationHomeAliases"
rawComment=$'Summary: `applicationHome` bash aliases setup\nSet aliases `G` and `g` (defaults) to aliases of `applicationHome`\nLocalize as you wish for your own shell\nArgument: goAlias - String. Alias for `applicationHome --go`. Default is `g`.\nArgument: setAlias - String. Alias for `applicationHome`. Default is `G`.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/application.sh"
sourceHash="b17015a1dababfad8b603f4af30089a720ec9300"
sourceLine="100"
summary="\`applicationHome\` bash aliases setup"
summaryComputed=""
usage="applicationHomeAliases [ goAlias ] [ setAlias ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mapplicationHomeAliases'$'\e''[0m '$'\e''[[(blue)]m[ goAlias ]'$'\e''[0m '$'\e''[[(blue)]m[ setAlias ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mgoAlias   '$'\e''[[(value)]mString. Alias for '$'\e''[[(code)]mapplicationHome --go'$'\e''[[(reset)]m. Default is '$'\e''[[(code)]mg'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]msetAlias  '$'\e''[[(value)]mString. Alias for '$'\e''[[(code)]mapplicationHome'$'\e''[[(reset)]m. Default is '$'\e''[[(code)]mG'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Set aliases '$'\e''[[(code)]mG'$'\e''[[(reset)]m and '$'\e''[[(code)]mg'$'\e''[[(reset)]m (defaults) to aliases of '$'\e''[[(code)]mapplicationHome'$'\e''[[(reset)]m'$'\n''Localize as you wish for your own shell'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: applicationHomeAliases [ goAlias ] [ setAlias ]'$'\n'''$'\n''    goAlias   String. Alias for applicationHome --go. Default is g.'$'\n''    setAlias  String. Alias for applicationHome. Default is G.'$'\n'''$'\n''Set aliases G and g (defaults) to aliases of applicationHome'$'\n''Localize as you wish for your own shell'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/application.md"
