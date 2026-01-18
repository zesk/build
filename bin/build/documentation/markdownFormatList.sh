#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/markdown.sh"
argument="none"
base="markdown.sh"
description="Simple function to make list-like things more list-like in Markdown"$'\n'""$'\n'"1. remove leading \"dash space\" if it exists (\`- \`)"$'\n'"2. Semantically, if the phrase matches \`[word]+[space][dash][space]\`. backtick quote the \`[word]\`, otherwise skip"$'\n'"3. Prefix each line with a \"dash space\" (\`- \`)"$'\n'""
file="bin/build/tools/markdown.sh"
fn="markdownFormatList"
foundNames=([0]="stdin" [1]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/markdown.sh"
sourceModified="1768721469"
stdin="reads input from stdin"$'\n'""
stdout="formatted markdown list"$'\n'""
summary="Simple function to make list-like things more list-like in Markdown"
usage="markdownFormatList"
