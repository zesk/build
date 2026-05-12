#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'filename ... - File. One or more filenames to generate a checksum for\n--cache cacheDirectory - Directory. Cache file cache values here for speed optimization.\n'
base="text.sh"
build_debug=$'textSHA - Outputs all requested textSHA calls to log called `textSHA.log`.\n'
depends=$'sha1sum\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff\n\nYou can use this as a pipe or pass in arguments which are files to be hashed.\n\n'
descriptionLineCount="4"
example=$'    textSHA < "$fileName"\n    textSHA "$fileName0" "$fileName1"\n'
file="bin/build/tools/text.sh"
fn="textSHA"
fnMarker="textsha"
foundNames=([0]="argument" [1]="depends" [2]="summary" [3]="example" [4]="output" [5]="build_debug" [6]="stdin" [7]="stdout")
line="1038"
output=$'cf7861b50054e8c680a9552917b43ec2b9edae2b\n'
rawComment=$'Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff\nYou can use this as a pipe or pass in arguments which are files to be hashed.\nArgument: filename ... - File. One or more filenames to generate a checksum for\nArgument: --cache cacheDirectory - Directory. Cache file cache values here for speed optimization.\nDepends: sha1sum\nSummary: SHA1 checksum of standard input\nExample:     textSHA < "$fileName"\nExample:     textSHA "$fileName0" "$fileName1"\nOutput: cf7861b50054e8c680a9552917b43ec2b9edae2b\nBUILD_DEBUG: textSHA - Outputs all requested textSHA calls to log called `textSHA.log`.\nstdin: any file\nstdout: `String`. A hexadecimal string which uniquely represents the data in `stdin`.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="1038"
stdin=$'any file\n'
stdout=$'`String`. A hexadecimal string which uniquely represents the data in `stdin`.\n'
summary="SHA1 checksum of standard input"
summaryComputed=""
usage="textSHA [ filename ... ] [ --cache cacheDirectory ]"
