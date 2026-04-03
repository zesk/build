#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"scheme ... - String. Required. Scheme to look up the default port used for that scheme."$'\n'""
base="url.sh"
description="Output the port for the given scheme"$'\n'""
file="bin/build/tools/url.sh"
fn="urlSchemeDefaultPort"
foundNames=([0]="argument")
rawComment="Output the port for the given scheme"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: scheme ... - String. Required. Scheme to look up the default port used for that scheme."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="11f67cb37f84f19d4ec0cff2c23ee1b7f3185d1d"
summary="Output the port for the given scheme"
summaryComputed="true"
usage="urlSchemeDefaultPort [ --help ] [ --handler handler ] scheme ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlSchemeDefaultPort'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mscheme ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mscheme ...         '$'\e''[[(value)]mString. Required. Scheme to look up the default port used for that scheme.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the port for the given scheme'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: urlSchemeDefaultPort [ --help ] [ --handler handler ] scheme ...'$'\n'''$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    scheme ...         String. Required. Scheme to look up the default port used for that scheme.'$'\n'''$'\n''Output the port for the given scheme'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
