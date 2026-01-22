#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="cacheDirectory - Required. Cache directory where the index will be created."$'\n'"documentationSource ... - OneOrMore. Documentation source path to find tokens and their definitions."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
description="Generate the documentation index (e.g. functions defined in the documentation)"$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Issue with file generation"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationIndexDocumentation"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceModified="1769065497"
summary="Generate the documentation index (e.g. functions defined in the documentation)"
usage="documentationIndexDocumentation cacheDirectory [ documentationSource ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdocumentationIndexDocumentation[0m [38;2;255;255;0m[35;48;2;0;0;0mcacheDirectory[0m[0m [94m[ documentationSource ... ][0m [94m[ --help ][0m

    [31mcacheDirectory           [1;97mRequired. Cache directory where the index will be created.[0m
    [94mdocumentationSource ...  [1;97mOneOrMore. Documentation source path to find tokens and their definitions.[0m
    [94m--help                   [1;97mFlag. Optional. Display this help.[0m

Generate the documentation index (e.g. functions defined in the documentation)
Return Code: 0 - If success
Return Code: 1 - Issue with file generation
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: documentationIndexDocumentation cacheDirectory [ documentationSource ... ] [ --help ]

    cacheDirectory           Required. Cache directory where the index will be created.
    documentationSource ...  OneOrMore. Documentation source path to find tokens and their definitions.
    --help                   Flag. Optional. Display this help.

Generate the documentation index (e.g. functions defined in the documentation)
Return Code: 0 - If success
Return Code: 1 - Issue with file generation
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
