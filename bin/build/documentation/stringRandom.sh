#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="none"
base="text.sh"
depends="sha1sum, /dev/random"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Outputs 40 random hexadecimal characters, stringLowercase."$'\n'""$'\n'""
descriptionLineCount="2"
example="    testPassword=\"\$(stringRandom)\""$'\n'""
file="bin/build/tools/text.sh"
fn="stringRandom"
fnMarker="stringrandom"
foundNames=([0]="depends" [1]="example" [2]="output" [3]="stdout")
line="1047"
output="cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'""
rawComment="Depends: sha1sum, /dev/random"$'\n'"Description: Outputs 40 random hexadecimal characters, stringLowercase."$'\n'"Example:     testPassword=\"\$(stringRandom)\""$'\n'"Output: cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'"stdout: \`String\`. A random hexadecimal string."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="1047"
stdout="\`String\`. A random hexadecimal string."$'\n'""
summary="Outputs 40 random hexadecimal characters, stringLowercase."
summaryComputed="true"
testPassword=""
usage="stringRandom"
