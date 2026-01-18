#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/markdown.sh"
argument="indexFile ... - File. Required. One or more index files to check."$'\n'"--help - Flag. Optional.Display this help."$'\n'"--handler handler - Function. Optional.Use this error handler instead of the default error handler."$'\n'""
base="markdown.sh"
description="Displays any markdown files next to the given index file which are not found within the index file as links."$'\n'""
file="bin/build/tools/markdown.sh"
fn="markdownCheckIndex"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/markdown.sh"
sourceModified="1768695708"
summary="Displays any markdown files next to the given index file"
usage="markdownCheckIndex indexFile ... [ --help ] [ --handler handler ]"
