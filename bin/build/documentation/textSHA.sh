#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="filename ... - File. One or more filenames to generate a checksum for"$'\n'"--cache cacheDirectory - Directory. Cache file cache values here for speed optimization."$'\n'""
base="text.sh"
build_debug="textSHA - Outputs all requested textSHA calls to log called \`textSHA.log\`."$'\n'""
depends="sha1sum"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff"$'\n'""$'\n'"You can use this as a pipe or pass in arguments which are files to be hashed."$'\n'""$'\n'""
descriptionLineCount="4"
example="    textSHA < \"\$fileName\""$'\n'"    textSHA \"\$fileName0\" \"\$fileName1\""$'\n'""
file="bin/build/tools/text.sh"
fn="textSHA"
fnMarker="textsha"
foundNames=([0]="argument" [1]="depends" [2]="summary" [3]="example" [4]="output" [5]="build_debug" [6]="stdin" [7]="stdout")
line="1034"
output="cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'""
rawComment="Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff"$'\n'"You can use this as a pipe or pass in arguments which are files to be hashed."$'\n'"Argument: filename ... - File. One or more filenames to generate a checksum for"$'\n'"Argument: --cache cacheDirectory - Directory. Cache file cache values here for speed optimization."$'\n'"Depends: sha1sum"$'\n'"Summary: SHA1 checksum of standard input"$'\n'"Example:     textSHA < \"\$fileName\""$'\n'"Example:     textSHA \"\$fileName0\" \"\$fileName1\""$'\n'"Output: cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'"BUILD_DEBUG: textSHA - Outputs all requested textSHA calls to log called \`textSHA.log\`."$'\n'"stdin: any file"$'\n'"stdout: \`String\`. A hexadecimal string which uniquely represents the data in \`stdin\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="1034"
stdin="any file"$'\n'""
stdout="\`String\`. A hexadecimal string which uniquely represents the data in \`stdin\`."$'\n'""
summary="SHA1 checksum of standard input"
summaryComputed=""
usage="textSHA [ filename ... ] [ --cache cacheDirectory ]"
