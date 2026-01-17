#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"pattern ... - String. Required.\`grep -e\` Pattern to find in files."$'\n'"-- -  Delimiter. Required. exception."$'\n'"exception ... - String. Optional. \`grep -e\` File pattern which should be ignored."$'\n'"-- -  Delimiter. Required. file."$'\n'"file ... -  File. Required. File to search. Special file \`-\` indicates files should be read from \`stdin\`."$'\n'""
base="file.sh"
description="Find list of files which do NOT match a specific pattern or patterns and output them"$'\n'""$'\n'""
file="bin/build/tools/file.sh"
fn="fileNotMatches"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768687315"
summary="Find list of files which do NOT match a specific"
usage="fileNotMatches [ --help ] pattern ... -- [ exception ... ] -- file ..."
