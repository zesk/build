#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="none"
base="text.sh"
depends="sha1sum, /dev/random"$'\n'""
description="Outputs 40 random hexadecimal characters, stringLowercase."$'\n'""
example="    testPassword=\"\$(stringRandom)\""$'\n'""
file="bin/build/tools/text.sh"
fn="stringRandom"
foundNames=([0]="depends" [1]="example" [2]="output" [3]="stdout")
output="cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'""
rawComment="Depends: sha1sum, /dev/random"$'\n'"Description: Outputs 40 random hexadecimal characters, stringLowercase."$'\n'"Example:     testPassword=\"\$(stringRandom)\""$'\n'"Output: cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'"stdout: \`String\`. A random hexadecimal string."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="5f35ac6dcf31b9c284706fdda354d1d8408dde2c"
stdout="\`String\`. A random hexadecimal string."$'\n'""
summary="Outputs 40 random hexadecimal characters, stringLowercase."
summaryComputed="true"
testPassword=""
usage="stringRandom"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringRandom'$'\e''[0m'$'\n'''$'\n''Outputs 40 random hexadecimal characters, stringLowercase.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n'''$'\e''[[(code)]mString'$'\e''[[(reset)]m. A random hexadecimal string.'$'\n'''$'\n''Example:'$'\n''    testPassword="$(stringRandom)"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: stringRandom'$'\n'''$'\n''Outputs 40 random hexadecimal characters, stringLowercase.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''String. A random hexadecimal string.'$'\n'''$'\n''Example:'$'\n''    testPassword="$(stringRandom)"'$'\n'''
