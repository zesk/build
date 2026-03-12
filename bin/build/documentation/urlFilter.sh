#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--show-file - Boolean. Optional. Show the file name in the output (suffix with \`: \`)"$'\n'"--file name - String. Optional. The file name to display - can be any text."$'\n'"file - File. Optional. A file to read and output URLs found."$'\n'""
base="url.sh"
description="Open URLs which appear in a stream"$'\n'"Takes a text file and outputs any \`https://\` or \`http://\` URLs found within."$'\n'"URLs are explicitly trimmed at quote, whitespace and escape boundaries."$'\n'""
file="bin/build/tools/url.sh"
fn="urlFilter"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Open URLs which appear in a stream"$'\n'"Argument: --show-file - Boolean. Optional. Show the file name in the output (suffix with \`: \`)"$'\n'"Argument: --file name - String. Optional. The file name to display - can be any text."$'\n'"Argument: file - File. Optional. A file to read and output URLs found."$'\n'"stdin: text"$'\n'"stdout: line:URL"$'\n'"Takes a text file and outputs any \`https://\` or \`http://\` URLs found within."$'\n'"URLs are explicitly trimmed at quote, whitespace and escape boundaries."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="5c17cd3be5908f799dcf52a229b158e5866260c8"
stdin="text"$'\n'""
stdout="line:URL"$'\n'""
summary="Open URLs which appear in a stream"
summaryComputed="true"
usage="urlFilter [ --show-file ] [ --file name ] [ file ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlFilter'$'\e''[0m '$'\e''[[(blue)]m[ --show-file ]'$'\e''[0m '$'\e''[[(blue)]m[ --file name ]'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--show-file  '$'\e''[[(value)]mBoolean. Optional. Show the file name in the output (suffix with '$'\e''[[(code)]m: '$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--file name  '$'\e''[[(value)]mString. Optional. The file name to display - can be any text.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfile         '$'\e''[[(value)]mFile. Optional. A file to read and output URLs found.'$'\e''[[(reset)]m'$'\n'''$'\n''Open URLs which appear in a stream'$'\n''Takes a text file and outputs any '$'\e''[[(code)]mhttps://'$'\e''[[(reset)]m or '$'\e''[[(code)]mhttp://'$'\e''[[(reset)]m URLs found within.'$'\n''URLs are explicitly trimmed at quote, whitespace and escape boundaries.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''text'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''line:URL'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: urlFilter [ --show-file ] [ --file name ] [ file ]'$'\n'''$'\n''    --show-file  Boolean. Optional. Show the file name in the output (suffix with : )'$'\n''    --file name  String. Optional. The file name to display - can be any text.'$'\n''    file         File. Optional. A file to read and output URLs found.'$'\n'''$'\n''Open URLs which appear in a stream'$'\n''Takes a text file and outputs any https:// or http:// URLs found within.'$'\n''URLs are explicitly trimmed at quote, whitespace and escape boundaries.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text'$'\n'''$'\n''Writes to stdout:'$'\n''line:URL'$'\n'''
