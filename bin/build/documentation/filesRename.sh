#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'oldSuffix - String. Required. Old suffix to look rename from.\nnewSuffix - String. Required. New suffix to rename to.\nactionVerb - String. Required. Description to output for found files.\nfile ... - String. Required. One or more files to rename, if found, renaming occurs.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Renames "$file0$oldSuffix" to "$file0$newSuffix" if file exists and outputs a message using the actionVerb\n\nIf files do not exist, does nothing\n\nUsed to move files, temporarily, sometimes and then move back easily.\n\nRenames files which have `oldSuffix` to then have `newSuffix` and output a message using `actionVerb`:\n\n'
descriptionLineCount="8"
example=$'    filesRename "" ".$$.backup" hiding etc/app.json etc/config.json\n    ...\n    filesRename ".$$.backup" "" restoring etc/app.json etc/config.json\n'
file="bin/build/tools/file.sh"
fn="filesRename"
fnMarker="filesrename"
foundNames=([0]="summary" [1]="argument" [2]="example")
line="30"
rawComment=$'Renames "$file0$oldSuffix" to "$file0$newSuffix" if file exists and outputs a message using the actionVerb\nIf files do not exist, does nothing\nUsed to move files, temporarily, sometimes and then move back easily.\nRenames files which have `oldSuffix` to then have `newSuffix` and output a message using `actionVerb`:\nSummary: Rename a list of files usually to back them up temporarily\nArgument: oldSuffix - String. Required. Old suffix to look rename from.\nArgument: newSuffix - String. Required. New suffix to rename to.\nArgument: actionVerb - String. Required. Description to output for found files.\nArgument: file ... - String. Required. One or more files to rename, if found, renaming occurs.\nExample:     {fn} "" ".$$.backup" hiding etc/app.json etc/config.json\nExample:     ...\nExample:     {fn} ".$$.backup" "" restoring etc/app.json etc/config.json\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="30"
summary="Rename a list of files usually to back them up temporarily"
summaryComputed=""
usage="filesRename oldSuffix newSuffix actionVerb file ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfilesRename'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]moldSuffix'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mnewSuffix'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mactionVerb'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]moldSuffix   '$'\e''[[(value)]mString. Required. Old suffix to look rename from.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mnewSuffix   '$'\e''[[(value)]mString. Required. New suffix to rename to.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mactionVerb  '$'\e''[[(value)]mString. Required. Description to output for found files.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfile ...    '$'\e''[[(value)]mString. Required. One or more files to rename, if found, renaming occurs.'$'\e''[[(reset)]m'$'\n'''$'\n''Renames "$file0$oldSuffix" to "$file0$newSuffix" if file exists and outputs a message using the actionVerb'$'\n'''$'\n''If files do not exist, does nothing'$'\n'''$'\n''Used to move files, temporarily, sometimes and then move back easily.'$'\n'''$'\n''Renames files which have '$'\e''[[(code)]moldSuffix'$'\e''[[(reset)]m to then have '$'\e''[[(code)]mnewSuffix'$'\e''[[(reset)]m and output a message using '$'\e''[[(code)]mactionVerb'$'\e''[[(reset)]m:'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    filesRename "" ".$$.backup" hiding etc/app.json etc/config.json'$'\n''    ...'$'\n''    filesRename ".$$.backup" "" restoring etc/app.json etc/config.json'
# shellcheck disable=SC2016
helpPlain='Usage: filesRename oldSuffix newSuffix actionVerb file ...'$'\n'''$'\n''    oldSuffix   String. Required. Old suffix to look rename from.'$'\n''    newSuffix   String. Required. New suffix to rename to.'$'\n''    actionVerb  String. Required. Description to output for found files.'$'\n''    file ...    String. Required. One or more files to rename, if found, renaming occurs.'$'\n'''$'\n''Renames "$file0$oldSuffix" to "$file0$newSuffix" if file exists and outputs a message using the actionVerb'$'\n'''$'\n''If files do not exist, does nothing'$'\n'''$'\n''Used to move files, temporarily, sometimes and then move back easily.'$'\n'''$'\n''Renames files which have oldSuffix to then have newSuffix and output a message using actionVerb:'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    filesRename "" ".$$.backup" hiding etc/app.json etc/config.json'$'\n''    ...'$'\n''    filesRename ".$$.backup" "" restoring etc/app.json etc/config.json'
documentationPath="documentation/source/tools/file.md"
