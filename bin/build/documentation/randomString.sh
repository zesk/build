#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="none"
base="text.sh"
depends="sha1sum, /dev/random"$'\n'""
description="Outputs 40 random hexadecimal characters, lowercase."$'\n'""
example="    testPassword=\"\$(randomString)\""$'\n'""
file="bin/build/tools/text.sh"
fn="randomString"
foundNames=""
output="cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdout="\`String\`. A random hexadecimal string."$'\n'""
summary="Outputs 40 random hexadecimal characters, lowercase."
testPassword=""
usage="randomString"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mrandomString[0m

Outputs 40 random hexadecimal characters, lowercase.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
[38;2;0;255;0;48;2;0;0;0mString[0m. A random hexadecimal string.

Example:
    testPassword="$(randomString)"
'
# shellcheck disable=SC2016
helpPlain='Usage: randomString

Outputs 40 random hexadecimal characters, lowercase.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
String. A random hexadecimal string.

Example:
    testPassword="$(randomString)"
'
