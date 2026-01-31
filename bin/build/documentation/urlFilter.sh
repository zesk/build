#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="url.sh"
description="Open URLs which appear in a stream"$'\n'"Argument: --show-file - Boolean. Optional. Show the file name in the output (suffix with \`: \`)"$'\n'"Argument: --file name - String. Optional. The file name to display - can be any text."$'\n'"Argument: file - File. Optional. A file to read and output URLs found."$'\n'"stdin: text"$'\n'"stdout: line:URL"$'\n'"Takes a text file and outputs any \`https://\` or \`http://\` URLs found within."$'\n'"URLs are explicitly trimmed at quote, whitespace and escape boundaries."$'\n'""
file="bin/build/tools/url.sh"
foundNames=()
rawComment="Open URLs which appear in a stream"$'\n'"Argument: --show-file - Boolean. Optional. Show the file name in the output (suffix with \`: \`)"$'\n'"Argument: --file name - String. Optional. The file name to display - can be any text."$'\n'"Argument: file - File. Optional. A file to read and output URLs found."$'\n'"stdin: text"$'\n'"stdout: line:URL"$'\n'"Takes a text file and outputs any \`https://\` or \`http://\` URLs found within."$'\n'"URLs are explicitly trimmed at quote, whitespace and escape boundaries."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="7a4bdc5b163f1c16b416ea3bac111f15d9a5f6b1"
summary="Open URLs which appear in a stream"
usage="urlFilter"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlFilter'$'\e''[0m'$'\n'''$'\n''Open URLs which appear in a stream'$'\n''Argument: --show-file - Boolean. Optional. Show the file name in the output (suffix with '$'\e''[[(code)]m: '$'\e''[[(reset)]m)'$'\n''Argument: --file name - String. Optional. The file name to display - can be any text.'$'\n''Argument: file - File. Optional. A file to read and output URLs found.'$'\n''stdin: text'$'\n''stdout: line:URL'$'\n''Takes a text file and outputs any '$'\e''[[(code)]mhttps://'$'\e''[[(reset)]m or '$'\e''[[(code)]mhttp://'$'\e''[[(reset)]m URLs found within.'$'\n''URLs are explicitly trimmed at quote, whitespace and escape boundaries.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: urlFilter'$'\n'''$'\n''Open URLs which appear in a stream'$'\n''Argument: --show-file - Boolean. Optional. Show the file name in the output (suffix with : )'$'\n''Argument: --file name - String. Optional. The file name to display - can be any text.'$'\n''Argument: file - File. Optional. A file to read and output URLs found.'$'\n''stdin: text'$'\n''stdout: line:URL'$'\n''Takes a text file and outputs any https:// or http:// URLs found within.'$'\n''URLs are explicitly trimmed at quote, whitespace and escape boundaries.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.544
