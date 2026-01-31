#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="documentation.sh"
description="Generate the documentation index (e.g. functions defined in the documentation)"$'\n'"Argument: cacheDirectory - Required. Cache directory where the index will be created."$'\n'"Argument: documentationSource ... - OneOrMore. Documentation source path to find tokens and their definitions."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Issue with file generation"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/documentation.sh"
foundNames=()
rawComment="Generate the documentation index (e.g. functions defined in the documentation)"$'\n'"Argument: cacheDirectory - Required. Cache directory where the index will be created."$'\n'"Argument: documentationSource ... - OneOrMore. Documentation source path to find tokens and their definitions."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Issue with file generation"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="46ab638aa51f9a58ed6d53b666c068deff5385ca"
summary="Generate the documentation index (e.g. functions defined in the documentation)"
usage="documentationIndexDocumentation"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationIndexDocumentation'$'\e''[0m'$'\n'''$'\n''Generate the documentation index (e.g. functions defined in the documentation)'$'\n''Argument: cacheDirectory - Required. Cache directory where the index will be created.'$'\n''Argument: documentationSource ... - OneOrMore. Documentation source path to find tokens and their definitions.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - If success'$'\n''Return Code: 1 - Issue with file generation'$'\n''Return Code: 2 - Argument error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: documentationIndexDocumentation'$'\n'''$'\n''Generate the documentation index (e.g. functions defined in the documentation)'$'\n''Argument: cacheDirectory - Required. Cache directory where the index will be created.'$'\n''Argument: documentationSource ... - OneOrMore. Documentation source path to find tokens and their definitions.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - If success'$'\n''Return Code: 1 - Issue with file generation'$'\n''Return Code: 2 - Argument error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.474
