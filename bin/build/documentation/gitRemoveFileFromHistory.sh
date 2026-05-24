#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument="none"
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Has a lot of caveats\n\ngitRemoveFileFromHistory path/to/file\n\nusually have to `git push --force`\n\n'
descriptionLineCount="6"
file="bin/build/tools/git.sh"
fn="gitRemoveFileFromHistory"
fnMarker="gitremovefilefromhistory"
foundNames=()
line="210"
rawComment=$'Has a lot of caveats\ngitRemoveFileFromHistory path/to/file\nusually have to `git push --force`\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="210"
summary="Has a lot of caveats"
summaryComputed="true"
usage="gitRemoveFileFromHistory"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitRemoveFileFromHistory'$'\e''[0m'$'\n'''$'\n''Has a lot of caveats'$'\n'''$'\n''gitRemoveFileFromHistory path/to/file'$'\n'''$'\n''usually have to '$'\e''[[(code)]mgit push --force'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: gitRemoveFileFromHistory'$'\n'''$'\n''Has a lot of caveats'$'\n'''$'\n''gitRemoveFileFromHistory path/to/file'$'\n'''$'\n''usually have to git push --force'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/git.md"
