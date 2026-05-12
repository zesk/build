#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument="none"
base="text.sh"
depends=$'sha1sum, /dev/random\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Outputs 40 random hexadecimal characters, stringLowercase.\n\n'
descriptionLineCount="2"
example=$'    testPassword="$(stringRandom)"\n'
file="bin/build/tools/text.sh"
fn="stringRandom"
fnMarker="stringrandom"
foundNames=([0]="depends" [1]="example" [2]="output" [3]="stdout")
line="1052"
output=$'cf7861b50054e8c680a9552917b43ec2b9edae2b\n'
rawComment=$'Depends: sha1sum, /dev/random\nDescription: Outputs 40 random hexadecimal characters, stringLowercase.\nExample:     testPassword="$(stringRandom)"\nOutput: cf7861b50054e8c680a9552917b43ec2b9edae2b\nstdout: `String`. A random hexadecimal string.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="1052"
stdout=$'`String`. A random hexadecimal string.\n'
summary="Outputs 40 random hexadecimal characters, stringLowercase."
summaryComputed="true"
testPassword=""
usage="stringRandom"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringRandom'$'\e''[0m'$'\n'''$'\n''Outputs 40 random hexadecimal characters, stringLowercase.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n'''$'\e''[[(code)]mString'$'\e''[[(reset)]m. A random hexadecimal string.'$'\n'''$'\n''Example:'$'\n''    testPassword="$(stringRandom)"'
# shellcheck disable=SC2016
helpPlain='Usage: stringRandom'$'\n'''$'\n''Outputs 40 random hexadecimal characters, stringLowercase.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''String. A random hexadecimal string.'$'\n'''$'\n''Example:'$'\n''    testPassword="$(stringRandom)"'
documentationPath="documentation/source/tools/text.md"
