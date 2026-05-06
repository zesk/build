#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--show-file - Boolean. Optional. Show the file name in the output (suffix with \`: \`)"$'\n'"--file name - String. Optional. The file name to display - can be any text."$'\n'"file - File. Optional. A file to read and output URLs found."$'\n'""
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Open URLs which appear in a stream"$'\n'"Takes a text file and outputs any \`https://\` or \`http://\` URLs found within."$'\n'"URLs are explicitly trimmed at quote, whitespace and escape boundaries."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/url.sh"
fn="urlFilter"
fnMarker="urlfilter"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="355"
rawComment="Open URLs which appear in a stream"$'\n'"Argument: --show-file - Boolean. Optional. Show the file name in the output (suffix with \`: \`)"$'\n'"Argument: --file name - String. Optional. The file name to display - can be any text."$'\n'"Argument: file - File. Optional. A file to read and output URLs found."$'\n'"stdin: text"$'\n'"stdout: line:URL"$'\n'"Takes a text file and outputs any \`https://\` or \`http://\` URLs found within."$'\n'"URLs are explicitly trimmed at quote, whitespace and escape boundaries."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="8a95c52ce8bb5cc766609fdc6a03daab47743e41"
sourceLine="355"
stdin="text"$'\n'""
stdout="line:URL"$'\n'""
summary="Open URLs which appear in a stream"
summaryComputed="true"
usage="urlFilter [ --show-file ] [ --file name ] [ file ]"
