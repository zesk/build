#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="filename ... - File. One or more filenames to generate a checksum for"$'\n'""
base="text.sh"
build_debug="shaPipe - Outputs all requested shaPipe calls to log called \`shaPipe.log\`."$'\n'""
depends="sha1sum"$'\n'""
description="Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff"$'\n'""$'\n'"You can use this as a pipe or pass in arguments which are files to be hashed."$'\n'""$'\n'""
example="    shaPipe < \"\$fileName\""$'\n'"    shaPipe \"\$fileName0\" \"\$fileName1\""$'\n'""
file="bin/build/tools/text.sh"
fn="shaPipe"
foundNames=([0]="argument" [1]="depends" [2]="summary" [3]="example" [4]="output" [5]="build_debug" [6]="stdin" [7]="stdout")
output="cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768776345"
stdin="any file"$'\n'""
stdout="\`String\`. A hexadecimal string which uniquely represents the data in \`stdin\`."$'\n'""
summary="SHA1 checksum of standard input"$'\n'""
usage="shaPipe [ filename ... ]"
