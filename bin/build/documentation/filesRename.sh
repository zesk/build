#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="oldSuffix - String. Required. Old suffix to look rename from."$'\n'"newSuffix - String. Required. New suffix to rename to."$'\n'"actionVerb - String. Required. Description to output for found files."$'\n'"file ... - String. Required. One or more files to rename, if found, renaming occurs."$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Renames \"\$file0\$oldSuffix\" to \"\$file0\$newSuffix\" if file exists and outputs a message using the actionVerb"$'\n'""$'\n'"If files do not exist, does nothing"$'\n'""$'\n'"Used to move files, temporarily, sometimes and then move back easily."$'\n'""$'\n'"Renames files which have \`oldSuffix\` to then have \`newSuffix\` and output a message using \`actionVerb\`:"$'\n'""$'\n'""
descriptionLineCount="8"
example="    filesRename \"\" \".\$\$.backup\" hiding etc/app.json etc/config.json"$'\n'"    ..."$'\n'"    filesRename \".\$\$.backup\" \"\" restoring etc/app.json etc/config.json"$'\n'""
file="bin/build/tools/file.sh"
fn="filesRename"
fnMarker="filesrename"
foundNames=([0]="summary" [1]="argument" [2]="example")
line="30"
rawComment="Renames \"\$file0\$oldSuffix\" to \"\$file0\$newSuffix\" if file exists and outputs a message using the actionVerb"$'\n'"If files do not exist, does nothing"$'\n'"Used to move files, temporarily, sometimes and then move back easily."$'\n'"Renames files which have \`oldSuffix\` to then have \`newSuffix\` and output a message using \`actionVerb\`:"$'\n'"Summary: Rename a list of files usually to back them up temporarily"$'\n'"Argument: oldSuffix - String. Required. Old suffix to look rename from."$'\n'"Argument: newSuffix - String. Required. New suffix to rename to."$'\n'"Argument: actionVerb - String. Required. Description to output for found files."$'\n'"Argument: file ... - String. Required. One or more files to rename, if found, renaming occurs."$'\n'"Example:     {fn} \"\" \".\$\$.backup\" hiding etc/app.json etc/config.json"$'\n'"Example:     ..."$'\n'"Example:     {fn} \".\$\$.backup\" \"\" restoring etc/app.json etc/config.json"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="30"
summary="Rename a list of files usually to back them up temporarily"
summaryComputed=""
usage="filesRename oldSuffix newSuffix actionVerb file ..."
