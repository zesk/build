#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="oldSuffix - String. Required. Old suffix to look rename from."$'\n'"newSuffix - String. Required. New suffix to rename to."$'\n'"actionVerb - String. Required. Description to output for found files."$'\n'"file ... - String. Required. One or more files to rename, if found, renaming occurs."$'\n'""
base="file.sh"
description="Renames \"\$file0\$oldSuffix\" to \"\$file0\$newSuffix\" if file exists and outputs a message using the actionVerb"$'\n'""$'\n'"If files do not exist, does nothing"$'\n'""$'\n'"Used to move files, temporarily, sometimes and then move back easily."$'\n'""$'\n'"Renames files which have \`oldSuffix\` to then have \`newSuffix\` and output a message using \`actionVerb\`:"$'\n'""$'\n'""$'\n'""
example="    filesRename \"\" \".\$\$.backup\" hiding etc/app.json etc/config.json"$'\n'"    ..."$'\n'"    filesRename \".\$\$.backup\" \"\" restoring etc/app.json etc/config.json"$'\n'""
file="bin/build/tools/file.sh"
fn="filesRename"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1768775696"
summary="Rename a list of files usually to back them up temporarily"$'\n'""
usage="filesRename oldSuffix newSuffix actionVerb file ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfilesRename[0m [38;2;255;255;0m[35;48;2;0;0;0moldSuffix[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mnewSuffix[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mactionVerb[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfile ...[0m[0m

    [31moldSuffix   [1;97mString. Required. Old suffix to look rename from.[0m
    [31mnewSuffix   [1;97mString. Required. New suffix to rename to.[0m
    [31mactionVerb  [1;97mString. Required. Description to output for found files.[0m
    [31mfile ...    [1;97mString. Required. One or more files to rename, if found, renaming occurs.[0m

Renames "$file0$oldSuffix" to "$file0$newSuffix" if file exists and outputs a message using the actionVerb

If files do not exist, does nothing

Used to move files, temporarily, sometimes and then move back easily.

Renames files which have [38;2;0;255;0;48;2;0;0;0moldSuffix[0m to then have [38;2;0;255;0;48;2;0;0;0mnewSuffix[0m and output a message using [38;2;0;255;0;48;2;0;0;0mactionVerb[0m:

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    filesRename "" ".$$.backup" hiding etc/app.json etc/config.json
    ...
    filesRename ".$$.backup" "" restoring etc/app.json etc/config.json
'
# shellcheck disable=SC2016
helpPlain='Usage: filesRename oldSuffix newSuffix actionVerb file ...

    oldSuffix   String. Required. Old suffix to look rename from.
    newSuffix   String. Required. New suffix to rename to.
    actionVerb  String. Required. Description to output for found files.
    file ...    String. Required. One or more files to rename, if found, renaming occurs.

Renames "$file0$oldSuffix" to "$file0$newSuffix" if file exists and outputs a message using the actionVerb

If files do not exist, does nothing

Used to move files, temporarily, sometimes and then move back easily.

Renames files which have oldSuffix to then have newSuffix and output a message using actionVerb:

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    filesRename "" ".$$.backup" hiding etc/app.json etc/config.json
    ...
    filesRename ".$$.backup" "" restoring etc/app.json etc/config.json
'
