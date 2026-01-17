#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="cacheDirectory - Required. Cache directory where the index will be created."$'\n'"documentationSource ... - OneOrMore. Documentation source path to find tokens and their definitions."$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="documentation.sh"
description="Generate the documentation index (e.g. functions defined in the documentation)"$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Issue with file generation"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationIndexDocumentation"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/documentation.sh"
sourceModified="1768683999"
summary="Generate the documentation index (e.g. functions defined in the documentation)"
usage="documentationIndexDocumentation cacheDirectory [ documentationSource ... ] [ --help ]"
