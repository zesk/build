#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="--show-file - Boolean. Optional. Show the file name in the output (suffix with \`: \`)"$'\n'"--file name - String. Optional. The file name to display - can be any text."$'\n'"file - File. Optional. A file to read and output URLs found."$'\n'""
base="url.sh"
description="Open URLs which appear in a stream"$'\n'"Takes a text file and outputs any \`https://\` or \`http://\` URLs found within."$'\n'"URLs are explicitly trimmed at quote, whitespace and escape boundaries."$'\n'""
file="bin/build/tools/url.sh"
fn="urlFilter"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/url.sh"
stdin="text"$'\n'""
stdout="line:URL"$'\n'""
summary="Open URLs which appear in a stream"
usage="urlFilter [ --show-file ] [ --file name ] [ file ]"
