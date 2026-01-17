#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/tar.sh"
argument="pattern - The file pattern to extract"$'\n'""
base="tar.sh"
description="Platform agnostic tar extract with wildcards"$'\n'""$'\n'"e.g. \`tar -xf '*/file.json'\` or \`tar -xf --wildcards '*/file.json'\` depending on OS"$'\n'""$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments."$'\n'""$'\n'"Short description: Platform agnostic tar extract"$'\n'""
file="bin/build/tools/tar.sh"
fn="tarExtractPattern"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""$'\n'""$'\n'""
source="bin/build/tools/tar.sh"
sourceModified="1768513812"
stdin="A gzipped-tar file"$'\n'""
stdout="The desired file"$'\n'""
summary="Platform agnostic tar extract with wildcards"
usage="tarExtractPattern [ pattern ]"
