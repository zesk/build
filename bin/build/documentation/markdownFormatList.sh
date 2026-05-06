#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="markdown.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Simple function to make list-like things more list-like in Markdown"$'\n'""$'\n'"1. Remove all trailing spaces from all lines"$'\n'"2. remove leading \"dash space\" if it exists (\`- \`)"$'\n'"3. Semantically, if the phrase matches \`[word]+[space][dash][space]\`. backtick quote the \`[word]\`, otherwise skip"$'\n'"4. Prefix each line with a \"dash space\" (\`- \`)"$'\n'""$'\n'""
descriptionLineCount="7"
file="bin/build/tools/markdown.sh"
fn="markdownFormatList"
fnMarker="markdownformatlist"
foundNames=([0]="stdin" [1]="stdout")
line="119"
rawComment="Simple function to make list-like things more list-like in Markdown"$'\n'"1. Remove all trailing spaces from all lines"$'\n'"2. remove leading \"dash space\" if it exists (\`- \`)"$'\n'"3. Semantically, if the phrase matches \`[word]+[space][dash][space]\`. backtick quote the \`[word]\`, otherwise skip"$'\n'"4. Prefix each line with a \"dash space\" (\`- \`)"$'\n'"stdin: reads input from stdin"$'\n'"stdout: formatted markdown list"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/markdown.sh"
sourceHash="b0c6db65fd4dec5df3f8a36220ec0140b58ea621"
sourceLine="119"
stdin="reads input from stdin"$'\n'""
stdout="formatted markdown list"$'\n'""
summary="Simple function to make list-like things more list-like in Markdown"
summaryComputed="true"
usage="markdownFormatList"
