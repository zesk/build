#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="mkdocs.sh"
description="Build documentation using mkdocs and a template"$'\n'"Argument: --path documentationPath - Directory. Optional. Directory where documentation root exists."$'\n'"Argument: --template yamlTemplate - File. Optional. Name of mkdocs.yml template file to generate final file. Default is \`mkdocs.template.yml\`."$'\n'""
file="bin/build/tools/mkdocs.sh"
foundNames=()
rawComment="Build documentation using mkdocs and a template"$'\n'"Argument: --path documentationPath - Directory. Optional. Directory where documentation root exists."$'\n'"Argument: --template yamlTemplate - File. Optional. Name of mkdocs.yml template file to generate final file. Default is \`mkdocs.template.yml\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mkdocs.sh"
sourceHash="53300ab9f97270a337014b2a06c3024a4ad0b3f5"
summary="Build documentation using mkdocs and a template"
usage="documentationMkdocs"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationMkdocs'$'\e''[0m'$'\n'''$'\n''Build documentation using mkdocs and a template'$'\n''Argument: --path documentationPath - Directory. Optional. Directory where documentation root exists.'$'\n''Argument: --template yamlTemplate - File. Optional. Name of mkdocs.yml template file to generate final file. Default is '$'\e''[[(code)]mmkdocs.template.yml'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: documentationMkdocs'$'\n'''$'\n''Build documentation using mkdocs and a template'$'\n''Argument: --path documentationPath - Directory. Optional. Directory where documentation root exists.'$'\n''Argument: --template yamlTemplate - File. Optional. Name of mkdocs.yml template file to generate final file. Default is mkdocs.template.yml.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.46
