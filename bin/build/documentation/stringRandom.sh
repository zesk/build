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
