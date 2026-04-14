#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-13
# shellcheck disable=SC2034
argument="--underscore - Flag. Optional. Include environment variables which begin with underscore \`_\`."$'\n'"--skip-prefix prefixString - String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive)."$'\n'"--secure - Flag. Optional. Include environment variables which are in \`environmentSecureVariables\`"$'\n'"variable ... - String. Optional. Output these variables explicitly."$'\n'""
base="environment.sh"
description="Output all exported environment variables, hiding secure ones and ones prefixed with underscore."$'\n'"Any values which contain a newline are also skipped."$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentOutput"
foundNames=([0]="see" [1]="requires" [2]="argument")
line="204"
lowerFn="environmentoutput"
rawComment="Output all exported environment variables, hiding secure ones and ones prefixed with underscore."$'\n'"Any values which contain a newline are also skipped."$'\n'"See: environmentSecureVariables"$'\n'"Requires: throwArgument decorate environmentSecureVariables grepSafe env textRemoveFields"$'\n'"Argument: --underscore - Flag. Optional. Include environment variables which begin with underscore \`_\`."$'\n'"Argument: --skip-prefix prefixString - String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive)."$'\n'"Argument: --secure - Flag. Optional. Include environment variables which are in \`environmentSecureVariables\`"$'\n'"Argument: variable ... - String. Optional. Output these variables explicitly."$'\n'""$'\n'""
requires="throwArgument decorate environmentSecureVariables grepSafe env textRemoveFields"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="environmentSecureVariables"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceHash="f97e7b6e9384e8c9f494f115dacd41e614c5f8fb"
sourceLine="204"
summary="Output all exported environment variables, hiding secure ones and ones"
summaryComputed="true"
usage="environmentOutput [ --underscore ] [ --skip-prefix prefixString ] [ --secure ] [ variable ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentOutput'$'\e''[0m '$'\e''[[(blue)]m[ --underscore ]'$'\e''[0m '$'\e''[[(blue)]m[ --skip-prefix prefixString ]'$'\e''[0m '$'\e''[[(blue)]m[ --secure ]'$'\e''[0m '$'\e''[[(blue)]m[ variable ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--underscore                '$'\e''[[(value)]mFlag. Optional. Include environment variables which begin with underscore '$'\e''[[(code)]m_'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--skip-prefix prefixString  '$'\e''[[(value)]mString. Optional. Skip environment variables which begin with this exact prefix (case-sensitive).'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--secure                    '$'\e''[[(value)]mFlag. Optional. Include environment variables which are in '$'\e''[[(code)]menvironmentSecureVariables'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvariable ...                '$'\e''[[(value)]mString. Optional. Output these variables explicitly.'$'\e''[[(reset)]m'$'\n'''$'\n''Output all exported environment variables, hiding secure ones and ones prefixed with underscore.'$'\n''Any values which contain a newline are also skipped.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentOutput [ --underscore ] [ --skip-prefix prefixString ] [ --secure ] [ variable ... ]'$'\n'''$'\n''    --underscore                Flag. Optional. Include environment variables which begin with underscore _.'$'\n''    --skip-prefix prefixString  String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive).'$'\n''    --secure                    Flag. Optional. Include environment variables which are in environmentSecureVariables'$'\n''    variable ...                String. Optional. Output these variables explicitly.'$'\n'''$'\n''Output all exported environment variables, hiding secure ones and ones prefixed with underscore.'$'\n''Any values which contain a newline are also skipped.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/environment.md"
