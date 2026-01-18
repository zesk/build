#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="file ... - File. Required. One or more files to \`realpath\`."$'\n'""
base="file.sh"
description="Find the full, actual path of a file avoiding symlinks or redirection."$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/file.sh"
fn="realPath"
foundNames=([0]="see" [1]="argument" [2]="requires")
requires="whichExists realpath __help usageDocument returnArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="readlink realpath"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768695708"
summary="Find the full, actual path of a file avoiding symlinks"
usage="realPath file ..."
