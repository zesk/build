#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="from - Link. Required. Link to rename."$'\n'"to - FileDirectory. Required. New link path."$'\n'""
base="file.sh"
description="Rename a link"$'\n'"Renames a link forcing replacement, and works on different versions of \`mv\` which differs between systems."$'\n'""
file="bin/build/tools/file.sh"
fn="linkRename"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="mv"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1768775696"
summary="Rename a link"
usage="linkRename from to"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mlinkRename[0m [38;2;255;255;0m[35;48;2;0;0;0mfrom[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mto[0m[0m

    [31mfrom  [1;97mLink. Required. Link to rename.[0m
    [31mto    [1;97mFileDirectory. Required. New link path.[0m

Rename a link
Renames a link forcing replacement, and works on different versions of [38;2;0;255;0;48;2;0;0;0mmv[0m which differs between systems.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: linkRename from to

    from  Link. Required. Link to rename.
    to    FileDirectory. Required. New link path.

Rename a link
Renames a link forcing replacement, and works on different versions of mv which differs between systems.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
