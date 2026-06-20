#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--show-file - Boolean. Optional. Show the file name in the output (suffix with `: `)\n--file name - String. Optional. The file name to display - can be any text.\nfile - File. Optional. A file to read and output URLs found.\n'
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output URLs which appear in a stream.\nTakes a text file and outputs any `https://` or `http://` URLs found within.\nURLs are explicitly trimmed at quote, whitespace and escape boundaries.\n\n'
descriptionLineCount="4"
file="bin/build/tools/url.sh"
fn="urlFilter"
fnMarker="urlfilter"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="stdout")
line="380"
original="urlFilter"
rawComment=$'Summary: Extract URLs from arbitrary text content\nOutput URLs which appear in a stream.\nArgument: --show-file - Boolean. Optional. Show the file name in the output (suffix with `: `)\nArgument: --file name - String. Optional. The file name to display - can be any text.\nArgument: file - File. Optional. A file to read and output URLs found.\nstdin: text\nstdout: line:URL\nTakes a text file and outputs any `https://` or `http://` URLs found within.\nURLs are explicitly trimmed at quote, whitespace and escape boundaries.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/url.sh"
sourceHash="f32b7cbe9339aa8f7842cb180b43f028a41f69e6"
sourceLine="380"
stdin=$'text\n'
stdout=$'line:URL\n'
summary="Extract URLs from arbitrary text content"
summaryComputed=""
usage="urlFilter [ --show-file ] [ --file name ] [ file ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlFilter'$'\e''[0m '$'\e''[[(blue)]m[ --show-file ]'$'\e''[0m '$'\e''[[(blue)]m[ --file name ]'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--show-file  '$'\e''[[(value)]mBoolean. Optional. Show the file name in the output (suffix with '$'\e''[[(code)]m: '$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--file name  '$'\e''[[(value)]mString. Optional. The file name to display - can be any text.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfile         '$'\e''[[(value)]mFile. Optional. A file to read and output URLs found.'$'\e''[[(reset)]m'$'\n'''$'\n''Output URLs which appear in a stream.'$'\n''Takes a text file and outputs any '$'\e''[[(code)]mhttps://'$'\e''[[(reset)]m or '$'\e''[[(code)]mhttp://'$'\e''[[(reset)]m URLs found within.'$'\n''URLs are explicitly trimmed at quote, whitespace and escape boundaries.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''text'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''line:URL'
# shellcheck disable=SC2016
helpPlain='Usage: urlFilter [ --show-file ] [ --file name ] [ file ]'$'\n'''$'\n''    --show-file  Boolean. Optional. Show the file name in the output (suffix with : )'$'\n''    --file name  String. Optional. The file name to display - can be any text.'$'\n''    file         File. Optional. A file to read and output URLs found.'$'\n'''$'\n''Output URLs which appear in a stream.'$'\n''Takes a text file and outputs any https:// or http:// URLs found within.'$'\n''URLs are explicitly trimmed at quote, whitespace and escape boundaries.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text'$'\n'''$'\n''Writes to stdout:'$'\n''line:URL'
documentationPath="documentation/source/tools/url.md"
