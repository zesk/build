#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--path documentationPath - Directory. Optional. Directory where documentation root exists."$'\n'"--template yamlTemplate - File. Optional. Name of mkdocs.yml template file to generate final file. Default is \`mkdocs.template.yml\`."$'\n'""
base="mkdocs.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Build documentation using mkdocs and a template"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/mkdocs.sh"
fn="documentationMkdocs"
fnMarker="documentationmkdocs"
foundNames=([0]="argument")
line="10"
rawComment="Build documentation using mkdocs and a template"$'\n'"Argument: --path documentationPath - Directory. Optional. Directory where documentation root exists."$'\n'"Argument: --template yamlTemplate - File. Optional. Name of mkdocs.yml template file to generate final file. Default is \`mkdocs.template.yml\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mkdocs.sh"
sourceHash="dab4282db2049eaef2d2c687e331cfc96d0ce29c"
sourceLine="10"
summary="Build documentation using mkdocs and a template"
summaryComputed="true"
usage="documentationMkdocs [ --path documentationPath ] [ --template yamlTemplate ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationMkdocs'$'\e''[0m '$'\e''[[(blue)]m[ --path documentationPath ]'$'\e''[0m '$'\e''[[(blue)]m[ --template yamlTemplate ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--path documentationPath  '$'\e''[[(value)]mDirectory. Optional. Directory where documentation root exists.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--template yamlTemplate   '$'\e''[[(value)]mFile. Optional. Name of mkdocs.yml template file to generate final file. Default is '$'\e''[[(code)]mmkdocs.template.yml'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Build documentation using mkdocs and a template'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationMkdocs [ --path documentationPath ] [ --template yamlTemplate ]'$'\n'''$'\n''    --path documentationPath  Directory. Optional. Directory where documentation root exists.'$'\n''    --template yamlTemplate   File. Optional. Name of mkdocs.yml template file to generate final file. Default is mkdocs.template.yml.'$'\n'''$'\n''Build documentation using mkdocs and a template'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
