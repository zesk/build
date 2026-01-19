#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="cacheDirectory - Directory. Optional. The directory where cache files can be stored exclusively for this function. Supports a blank value to disable caching, otherwise, it must be a valid directory."$'\n'"filename - File. Optional. File determine the sha value for."$'\n'""
base="text.sh"
depends="sha1sum shaPipe"$'\n'""
description="Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff"$'\n'""$'\n'"You can use this as a pipe or pass in arguments which are files to be hashed."$'\n'""$'\n'"Speeds up shaPipe using modification dates of the files instead."$'\n'""$'\n'"The \`cacheDirectory\`"$'\n'""$'\n'""
example="    cachedShaPipe \"\$cacheDirectory\" < \"\$fileName\""$'\n'"    cachedShaPipe \"\$cacheDirectory\" \"\$fileName0\" \"\$fileName1\""$'\n'""
file="bin/build/tools/text.sh"
fn="cachedShaPipe"
foundNames=([0]="argument" [1]="depends" [2]="summary" [3]="example" [4]="output" [5]="stdin" [6]="stdout")
output="cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768776345"
stdin="any file"$'\n'""
stdout="\`String\`. A hexadecimal string which uniquely represents the data in \`stdin\`."$'\n'""
summary="SHA1 checksum of standard input"$'\n'""
usage="cachedShaPipe [ cacheDirectory ] [ filename ]"
