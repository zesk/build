#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--underscore - Flag. Optional. Include environment variables which begin with underscore `_`.\n--skip-prefix prefixString - String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive).\n--secure - Flag. Optional. Include environment variables which are in `environmentSecureVariables`\nvariable ... - String. Optional. Output these variables explicitly.\n'
base="environment.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output all exported environment variables, hiding secure ones and ones prefixed with underscore.\nAny values which contain a newline are also skipped.\n\n'
descriptionLineCount="3"
file="bin/build/tools/environment.sh"
fn="environmentOutput"
fnMarker="environmentoutput"
foundNames=([0]="see" [1]="requires" [2]="argument")
line="199"
rawComment=$'Output all exported environment variables, hiding secure ones and ones prefixed with underscore.\nAny values which contain a newline are also skipped.\nSee: environmentSecureVariables\nRequires: throwArgument decorate environmentSecureVariables grepSafe env textRemoveFields\nArgument: --underscore - Flag. Optional. Include environment variables which begin with underscore `_`.\nArgument: --skip-prefix prefixString - String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive).\nArgument: --secure - Flag. Optional. Include environment variables which are in `environmentSecureVariables`\nArgument: variable ... - String. Optional. Output these variables explicitly.\n\n'
requires=$'throwArgument decorate environmentSecureVariables grepSafe env textRemoveFields\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'environmentSecureVariables\n'
sourceFile="bin/build/tools/environment.sh"
sourceHash="fd4da5f1d9a2c52100a1a281185a474bae9aba02"
sourceLine="199"
summary="Output all exported environment variables, hiding secure ones and ones"
summaryComputed="true"
usage="environmentOutput [ --underscore ] [ --skip-prefix prefixString ] [ --secure ] [ variable ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentOutput'$'\e''[0m '$'\e''[[(blue)]m[ --underscore ]'$'\e''[0m '$'\e''[[(blue)]m[ --skip-prefix prefixString ]'$'\e''[0m '$'\e''[[(blue)]m[ --secure ]'$'\e''[0m '$'\e''[[(blue)]m[ variable ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--underscore                '$'\e''[[(value)]mFlag. Optional. Include environment variables which begin with underscore '$'\e''[[(code)]m_'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--skip-prefix prefixString  '$'\e''[[(value)]mString. Optional. Skip environment variables which begin with this exact prefix (case-sensitive).'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--secure                    '$'\e''[[(value)]mFlag. Optional. Include environment variables which are in '$'\e''[[(code)]menvironmentSecureVariables'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mvariable ...                '$'\e''[[(value)]mString. Optional. Output these variables explicitly.'$'\e''[[(reset)]m'$'\n'''$'\n''Output all exported environment variables, hiding secure ones and ones prefixed with underscore.'$'\n''Any values which contain a newline are also skipped.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: environmentOutput [ --underscore ] [ --skip-prefix prefixString ] [ --secure ] [ variable ... ]'$'\n'''$'\n''    --underscore                Flag. Optional. Include environment variables which begin with underscore _.'$'\n''    --skip-prefix prefixString  String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive).'$'\n''    --secure                    Flag. Optional. Include environment variables which are in environmentSecureVariables'$'\n''    variable ...                String. Optional. Output these variables explicitly.'$'\n'''$'\n''Output all exported environment variables, hiding secure ones and ones prefixed with underscore.'$'\n''Any values which contain a newline are also skipped.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/environment.md"
