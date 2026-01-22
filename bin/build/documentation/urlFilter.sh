#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="--show-file - Boolean. Optional. Show the file name in the output (suffix with \`: \`)"$'\n'"--file name - String. Optional. The file name to display - can be any text."$'\n'"file - File. Optional. A file to read and output URLs found."$'\n'""
base="url.sh"
description="Open URLs which appear in a stream"$'\n'"Takes a text file and outputs any \`https://\` or \`http://\` URLs found within."$'\n'"URLs are explicitly trimmed at quote, whitespace and escape boundaries."$'\n'""
file="bin/build/tools/url.sh"
fn="urlFilter"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceModified="1768721470"
stdin="text"$'\n'""
stdout="line:URL"$'\n'""
summary="Open URLs which appear in a stream"
usage="urlFilter [ --show-file ] [ --file name ] [ file ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255murlFilter[0m [94m[ --show-file ][0m [94m[ --file name ][0m [94m[ file ][0m

    [94m--show-file  [1;97mBoolean. Optional. Show the file name in the output (suffix with [38;2;0;255;0;48;2;0;0;0m: [0m)[0m
    [94m--file name  [1;97mString. Optional. The file name to display - can be any text.[0m
    [94mfile         [1;97mFile. Optional. A file to read and output URLs found.[0m

Open URLs which appear in a stream
Takes a text file and outputs any [38;2;0;255;0;48;2;0;0;0mhttps://[0m or [38;2;0;255;0;48;2;0;0;0mhttp://[0m URLs found within.
URLs are explicitly trimmed at quote, whitespace and escape boundaries.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
text

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
line:URL
'
# shellcheck disable=SC2016
helpPlain='Usage: urlFilter [ --show-file ] [ --file name ] [ file ]

    --show-file  Boolean. Optional. Show the file name in the output (suffix with : )
    --file name  String. Optional. The file name to display - can be any text.
    file         File. Optional. A file to read and output URLs found.

Open URLs which appear in a stream
Takes a text file and outputs any https:// or http:// URLs found within.
URLs are explicitly trimmed at quote, whitespace and escape boundaries.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
text

Writes to stdout:
line:URL
'
