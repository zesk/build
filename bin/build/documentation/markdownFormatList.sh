#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/markdown.sh"
argument="none"
base="markdown.sh"
description="Simple function to make list-like things more list-like in Markdown"$'\n'""$'\n'"1. remove leading \"dash space\" if it exists (\`- \`)"$'\n'"2. Semantically, if the phrase matches \`[word]+[space][dash][space]\`. backtick quote the \`[word]\`, otherwise skip"$'\n'"3. Prefix each line with a \"dash space\" (\`- \`)"$'\n'""
file="bin/build/tools/markdown.sh"
fn="markdownFormatList"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/markdown.sh"
sourceModified="1769063211"
stdin="reads input from stdin"$'\n'""
stdout="formatted markdown list"$'\n'""
summary="Simple function to make list-like things more list-like in Markdown"
usage="markdownFormatList"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmarkdownFormatList[0m

Simple function to make list-like things more list-like in Markdown

1. remove leading "dash space" if it exists ([38;2;0;255;0;48;2;0;0;0m- [0m)
2. Semantically, if the phrase matches [38;2;0;255;0;48;2;0;0;0m[word]+[space][dash][space][0m. backtick quote the [38;2;0;255;0;48;2;0;0;0m[word][0m, otherwise skip
3. Prefix each line with a "dash space" ([38;2;0;255;0;48;2;0;0;0m- [0m)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
reads input from stdin

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
formatted markdown list
'
# shellcheck disable=SC2016
helpPlain='Usage: markdownFormatList

Simple function to make list-like things more list-like in Markdown

1. remove leading "dash space" if it exists (- )
2. Semantically, if the phrase matches [word]+[space][dash][space]. backtick quote the [word], otherwise skip
3. Prefix each line with a "dash space" (- )

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
reads input from stdin

Writes to stdout:
formatted markdown list
'
