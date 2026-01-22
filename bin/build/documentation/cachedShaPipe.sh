#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="cacheDirectory - Directory. Optional. The directory where cache files can be stored exclusively for this function. Supports a blank value to disable caching, otherwise, it must be a valid directory."$'\n'"filename - File. Optional. File determine the sha value for."$'\n'""
base="text.sh"
depends="sha1sum shaPipe"$'\n'""
description="Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff"$'\n'""$'\n'"You can use this as a pipe or pass in arguments which are files to be hashed."$'\n'""$'\n'"Speeds up shaPipe using modification dates of the files instead."$'\n'""$'\n'"The \`cacheDirectory\`"$'\n'""$'\n'""
example="    cachedShaPipe \"\$cacheDirectory\" < \"\$fileName\""$'\n'"    cachedShaPipe \"\$cacheDirectory\" \"\$fileName0\" \"\$fileName1\""$'\n'""
file="bin/build/tools/text.sh"
fn="cachedShaPipe"
foundNames=""
output="cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769063211"
stdin="any file"$'\n'""
stdout="\`String\`. A hexadecimal string which uniquely represents the data in \`stdin\`."$'\n'""
summary="SHA1 checksum of standard input"$'\n'""
usage="cachedShaPipe [ cacheDirectory ] [ filename ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcachedShaPipe[0m [94m[ cacheDirectory ][0m [94m[ filename ][0m

    [94mcacheDirectory  [1;97mDirectory. Optional. The directory where cache files can be stored exclusively for this function. Supports a blank value to disable caching, otherwise, it must be a valid directory.[0m
    [94mfilename        [1;97mFile. Optional. File determine the sha value for.[0m

Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff

You can use this as a pipe or pass in arguments which are files to be hashed.

Speeds up shaPipe using modification dates of the files instead.

The [38;2;0;255;0;48;2;0;0;0mcacheDirectory[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
any file

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
[38;2;0;255;0;48;2;0;0;0mString[0m. A hexadecimal string which uniquely represents the data in [38;2;0;255;0;48;2;0;0;0mstdin[0m.

Example:
    cachedShaPipe "$cacheDirectory" < "$fileName"
    cachedShaPipe "$cacheDirectory" "$fileName0" "$fileName1"
'
# shellcheck disable=SC2016
helpPlain='Usage: cachedShaPipe [ cacheDirectory ] [ filename ]

    cacheDirectory  Directory. Optional. The directory where cache files can be stored exclusively for this function. Supports a blank value to disable caching, otherwise, it must be a valid directory.
    filename        File. Optional. File determine the sha value for.

Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff

You can use this as a pipe or pass in arguments which are files to be hashed.

Speeds up shaPipe using modification dates of the files instead.

The cacheDirectory

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
any file

Writes to stdout:
String. A hexadecimal string which uniquely represents the data in stdin.

Example:
    cachedShaPipe "$cacheDirectory" < "$fileName"
    cachedShaPipe "$cacheDirectory" "$fileName0" "$fileName1"
'
