#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
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
foundNames=""
output="cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769063211"
stdin="any file"$'\n'""
stdout="\`String\`. A hexadecimal string which uniquely represents the data in \`stdin\`."$'\n'""
summary="SHA1 checksum of standard input"$'\n'""
usage="shaPipe [ filename ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mshaPipe[0m [94m[ filename ... ][0m

    [94mfilename ...  [1;97mFile. One or more filenames to generate a checksum for[0m

Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff

You can use this as a pipe or pass in arguments which are files to be hashed.

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
    shaPipe < "$fileName"
    shaPipe "$fileName0" "$fileName1"

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- shaPipe - Outputs all requested shaPipe calls to log called [38;2;0;255;0;48;2;0;0;0mshaPipe.log[0m.
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: shaPipe [ filename ... ]

    filename ...  File. One or more filenames to generate a checksum for

Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff

You can use this as a pipe or pass in arguments which are files to be hashed.

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
    shaPipe < "$fileName"
    shaPipe "$fileName0" "$fileName1"

BUILD_DEBUG settings:
- shaPipe - Outputs all requested shaPipe calls to log called shaPipe.log.
- 
'
