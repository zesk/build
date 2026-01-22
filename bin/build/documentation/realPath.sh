#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="file ... - File. Required. One or more files to \`realpath\`."$'\n'""
base="file.sh"
description="Find the full, actual path of a file avoiding symlinks or redirection."$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/file.sh"
fn="realPath"
foundNames=""
requires="whichExists realpath __help usageDocument returnArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="readlink realpath"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1768775696"
summary="Find the full, actual path of a file avoiding symlinks"
usage="realPath file ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mrealPath[0m [38;2;255;255;0m[35;48;2;0;0;0mfile ...[0m[0m

    [31mfile ...  [1;97mFile. Required. One or more files to [38;2;0;255;0;48;2;0;0;0mrealpath[0m.[0m

Find the full, actual path of a file avoiding symlinks or redirection.
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: realPath file ...

    file ...  File. Required. One or more files to realpath.

Find the full, actual path of a file avoiding symlinks or redirection.
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
