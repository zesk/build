#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/mkdocs.sh"
argument="--path documentationPath - Directory. Optional. Directory where documentation root exists."$'\n'"--template yamlTemplate - File. Optional. Name of mkdocs.yml template file to generate final file. Default is \`mkdocs.template.yml\`."$'\n'""
base="mkdocs.sh"
description="Build documentation using mkdocs and a template"$'\n'""$'\n'""
file="bin/build/tools/mkdocs.sh"
fn="documentationMkdocs"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/mkdocs.sh"
sourceModified="1768588589"
summary="Build documentation using mkdocs and a template"
usage="documentationMkdocs [ --path documentationPath ] [ --template yamlTemplate ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdocumentationMkdocs[0m [94m[ --path documentationPath ][0m [94m[ --template yamlTemplate ][0m

    [94m--path documentationPath  [1;97mDirectory. Optional. Directory where documentation root exists.[0m
    [94m--template yamlTemplate   [1;97mFile. Optional. Name of mkdocs.yml template file to generate final file. Default is [38;2;0;255;0;48;2;0;0;0mmkdocs.template.yml[0m.[0m

Build documentation using mkdocs and a template

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: documentationMkdocs [ --path documentationPath ] [ --template yamlTemplate ]

    --path documentationPath  Directory. Optional. Directory where documentation root exists.
    --template yamlTemplate   File. Optional. Name of mkdocs.yml template file to generate final file. Default is mkdocs.template.yml.

Build documentation using mkdocs and a template

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
