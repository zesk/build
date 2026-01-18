#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="oldSuffix - String. Required. Old suffix to look rename from."$'\n'"newSuffix - String. Required. New suffix to rename to."$'\n'"actionVerb - String. Required. Description to output for found files."$'\n'"file ... - String. Required. One or more files to rename, if found, renaming occurs."$'\n'""
base="file.sh"
description="Renames \"\$file0\$oldSuffix\" to \"\$file0\$newSuffix\" if file exists and outputs a message using the actionVerb"$'\n'""$'\n'"If files do not exist, does nothing"$'\n'""$'\n'"Used to move files, temporarily, sometimes and then move back easily."$'\n'""$'\n'"Renames files which have \`oldSuffix\` to then have \`newSuffix\` and output a message using \`actionVerb\`:"$'\n'""$'\n'""$'\n'""
example="    filesRename \"\" \".\$\$.backup\" hiding etc/app.json etc/config.json"$'\n'"    ..."$'\n'"    filesRename \".\$\$.backup\" \"\" restoring etc/app.json etc/config.json"$'\n'""
file="bin/build/tools/file.sh"
fn="filesRename"
foundNames=([0]="summary" [1]="argument" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768721469"
summary="Rename a list of files usually to back them up temporarily"$'\n'""
usage="filesRename oldSuffix newSuffix actionVerb file ..."
