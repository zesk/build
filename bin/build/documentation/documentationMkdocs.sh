#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--path documentationPath - Directory. Optional. Directory where documentation root exists.\n--template yamlTemplate - File. Optional. Name of `mkdocs.yml` template file to generate final file. Default is `mkdocs.template.yml`.\n--package packageName - String. Optional. Install this python package when setting up `mkdocs`.\n--version version - String. Optional. Use this for current version of documentation; defaults to `hookVersionCurrent`\n--clean - Flag. Optional. Clean the python virtual environment first.\n--help - Flag. Optional. Display this help.\n'
base="mkdocs.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Build documentation using `mkdocs` and a template.\n\n'
descriptionLineCount="2"
file="bin/build/tools/mkdocs.sh"
fn="documentationMkdocs"
fnMarker="documentationmkdocs"
foundNames=([0]="summary" [1]="argument" [2]="see")
line="16"
rawComment=$'Summary: mkdocs Utility\nBuild documentation using `mkdocs` and a template.\nArgument: --path documentationPath - Directory. Optional. Directory where documentation root exists.\nArgument: --template yamlTemplate - File. Optional. Name of `mkdocs.yml` template file to generate final file. Default is `mkdocs.template.yml`.\nArgument: --package packageName - String. Optional. Install this python package when setting up `mkdocs`.\nArgument: --version version - String. Optional. Use this for current version of documentation; defaults to `hookVersionCurrent`\nArgument: --clean - Flag. Optional. Clean the python virtual environment first.\nSee: hookVersionCurrent\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'hookVersionCurrent\n'
sourceFile="bin/build/tools/mkdocs.sh"
sourceHash="69525663d8a11bc15c9e12845846dc41e611f3c7"
sourceLine="16"
summary="mkdocs Utility"
summaryComputed=""
usage="documentationMkdocs [ --path documentationPath ] [ --template yamlTemplate ] [ --package packageName ] [ --version version ] [ --clean ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationMkdocs'$'\e''[0m '$'\e''[[(blue)]m[ --path documentationPath ]'$'\e''[0m '$'\e''[[(blue)]m[ --template yamlTemplate ]'$'\e''[0m '$'\e''[[(blue)]m[ --package packageName ]'$'\e''[0m '$'\e''[[(blue)]m[ --version version ]'$'\e''[0m '$'\e''[[(blue)]m[ --clean ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--path documentationPath  '$'\e''[[(value)]mDirectory. Optional. Directory where documentation root exists.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--template yamlTemplate   '$'\e''[[(value)]mFile. Optional. Name of '$'\e''[[(code)]mmkdocs.yml'$'\e''[[(reset)]m template file to generate final file. Default is '$'\e''[[(code)]mmkdocs.template.yml'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--package packageName     '$'\e''[[(value)]mString. Optional. Install this python package when setting up '$'\e''[[(code)]mmkdocs'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--version version         '$'\e''[[(value)]mString. Optional. Use this for current version of documentation; defaults to '$'\e''[[(code)]mhookVersionCurrent'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--clean                   '$'\e''[[(value)]mFlag. Optional. Clean the python virtual environment first.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Build documentation using '$'\e''[[(code)]mmkdocs'$'\e''[[(reset)]m and a template.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationMkdocs [ --path documentationPath ] [ --template yamlTemplate ] [ --package packageName ] [ --version version ] [ --clean ] [ --help ]'$'\n'''$'\n''    --path documentationPath  Directory. Optional. Directory where documentation root exists.'$'\n''    --template yamlTemplate   File. Optional. Name of mkdocs.yml template file to generate final file. Default is mkdocs.template.yml.'$'\n''    --package packageName     String. Optional. Install this python package when setting up mkdocs.'$'\n''    --version version         String. Optional. Use this for current version of documentation; defaults to hookVersionCurrent'$'\n''    --clean                   Flag. Optional. Clean the python virtual environment first.'$'\n''    --help                    Flag. Optional. Display this help.'$'\n'''$'\n''Build documentation using mkdocs and a template.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
