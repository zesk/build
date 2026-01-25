#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="filename ... - File. One or more filenames to generate a checksum for"$'\n'"--cache cacheDirectory - Directory. Cache file cache values here for speed optimization."$'\n'""
base="text.sh"
build_debug="shaPipe - Outputs all requested shaPipe calls to log called \`shaPipe.log\`."$'\n'""
depends="sha1sum"$'\n'""
description="Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff"$'\n'"You can use this as a pipe or pass in arguments which are files to be hashed."$'\n'""
example="    shaPipe < \"\$fileName\""$'\n'"    shaPipe \"\$fileName0\" \"\$fileName1\""$'\n'""
exitCode="0"
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="depends" [2]="summary" [3]="example" [4]="output" [5]="build_debug" [6]="stdin" [7]="stdout")
output="cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'""
rawComment="Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff"$'\n'"You can use this as a pipe or pass in arguments which are files to be hashed."$'\n'"Argument: filename ... - File. One or more filenames to generate a checksum for"$'\n'"Argument: --cache cacheDirectory - Directory. Cache file cache values here for speed optimization."$'\n'"Depends: sha1sum"$'\n'"Summary: SHA1 checksum of standard input"$'\n'"Example:     shaPipe < \"\$fileName\""$'\n'"Example:     shaPipe \"\$fileName0\" \"\$fileName1\""$'\n'"Output: cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'"BUILD_DEBUG: shaPipe - Outputs all requested shaPipe calls to log called \`shaPipe.log\`."$'\n'"stdin: any file"$'\n'"stdout: \`String\`. A hexadecimal string which uniquely represents the data in \`stdin\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769320918"
stdin="any file"$'\n'""
stdout="\`String\`. A hexadecimal string which uniquely represents the data in \`stdin\`."$'\n'""
summary="SHA1 checksum of standard input"$'\n'""
usage="shaPipe [ filename ... ] [ --cache cacheDirectory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mshaPipe'$'\e''[0m '$'\e''[[blue]m[ filename ... ]'$'\e''[0m '$'\e''[[blue]m[ --cache cacheDirectory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mfilename ...            '$'\e''[[value]mFile. One or more filenames to generate a checksum for'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--cache cacheDirectory  '$'\e''[[value]mDirectory. Cache file cache values here for speed optimization.'$'\e''[[reset]m'$'\n'''$'\n''Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff'$'\n''You can use this as a pipe or pass in arguments which are files to be hashed.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[code]mstdin'$'\e''[[reset]m:'$'\n''any file'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n'''$'\e''[[code]mString'$'\e''[[reset]m. A hexadecimal string which uniquely represents the data in '$'\e''[[code]mstdin'$'\e''[[reset]m.'$'\n'''$'\n''Example:'$'\n''    shaPipe < "$fileName"'$'\n''    shaPipe "$fileName0" "$fileName1"'$'\n'''$'\n'''$'\e''[[code]mBUILD_DEBUG'$'\e''[[reset]m settings:'$'\n''- '$'\e''[[code]mshaPipe'$'\e''[[reset]m - Outputs all requested shaPipe calls to log called '$'\e''[[code]mshaPipe.log'$'\e''[[reset]m.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: shaPipe [ filename ... ] [ --cache cacheDirectory ]'$'\n'''$'\n''    filename ...            File. One or more filenames to generate a checksum for'$'\n''    --cache cacheDirectory  Directory. Cache file cache values here for speed optimization.'$'\n'''$'\n''Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff'$'\n''You can use this as a pipe or pass in arguments which are files to be hashed.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''any file'$'\n'''$'\n''Writes to stdout:'$'\n''String. A hexadecimal string which uniquely represents the data in stdin.'$'\n'''$'\n''Example:'$'\n''    shaPipe < "$fileName"'$'\n''    shaPipe "$fileName0" "$fileName1"'$'\n'''$'\n''BUILD_DEBUG settings:'$'\n''- shaPipe - Outputs all requested shaPipe calls to log called shaPipe.log.'$'\n'''
