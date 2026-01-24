#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/markdown.sh"
argument="none"
base="markdown.sh"
description="Simple function to make list-like things more list-like in Markdown"$'\n'"1. Remove all trailing spaces from all lines"$'\n'"2. remove leading \"dash space\" if it exists (\`- \`)"$'\n'"3. Semantically, if the phrase matches \`[word]+[space][dash][space]\`. backtick quote the \`[word]\`, otherwise skip"$'\n'"4. Prefix each line with a \"dash space\" (\`- \`)"$'\n'""
exitCode="0"
file="bin/build/tools/markdown.sh"
foundNames=([0]="stdin" [1]="stdout")
rawComment="Simple function to make list-like things more list-like in Markdown"$'\n'"1. Remove all trailing spaces from all lines"$'\n'"2. remove leading \"dash space\" if it exists (\`- \`)"$'\n'"3. Semantically, if the phrase matches \`[word]+[space][dash][space]\`. backtick quote the \`[word]\`, otherwise skip"$'\n'"4. Prefix each line with a \"dash space\" (\`- \`)"$'\n'"stdin: reads input from stdin"$'\n'"stdout: formatted markdown list"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769190358"
stdin="reads input from stdin"$'\n'""
stdout="formatted markdown list"$'\n'""
summary="Simple function to make list-like things more list-like in Markdown"
usage="markdownFormatList"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mmarkdownFormatList'$'\e''[0m'$'\n'''$'\n''Simple function to make list-like things more list-like in Markdown'$'\n''1. Remove all trailing spaces from all lines'$'\n''2. remove leading "dash space" if it exists ('$'\e''[[code]m- '$'\e''[[reset]m)'$'\n''3. Semantically, if the phrase matches '$'\e''[[code]m[word]+[space][dash][space]'$'\e''[[reset]m. backtick quote the '$'\e''[[code]m[word]'$'\e''[[reset]m, otherwise skip'$'\n''4. Prefix each line with a "dash space" ('$'\e''[[code]m- '$'\e''[[reset]m)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[code]mstdin'$'\e''[[reset]m:'$'\n''reads input from stdin'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''formatted markdown list'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: markdownFormatList'$'\n'''$'\n''Simple function to make list-like things more list-like in Markdown'$'\n''1. Remove all trailing spaces from all lines'$'\n''2. remove leading "dash space" if it exists (- )'$'\n''3. Semantically, if the phrase matches [word]+[space][dash][space]. backtick quote the [word], otherwise skip'$'\n''4. Prefix each line with a "dash space" (- )'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''reads input from stdin'$'\n'''$'\n''Writes to stdout:'$'\n''formatted markdown list'$'\n'''
