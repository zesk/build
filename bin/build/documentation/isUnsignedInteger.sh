#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'value - EmptyString. Value to test if it is an unsigned integer.\n'
base="example.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Test if a value is a 0 or greater integer. Leading "+" is ok.\n\n'
descriptionLineCount="2"
file="bin/build/tools/example.sh"
fn="isUnsignedInteger"
fnMarker="isunsignedinteger"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="return_code" [4]="requires")
line="162"
rawComment=$'Summary: Is value an unsigned integer?\nTest if a value is a 0 or greater integer. Leading "+" is ok.\nSee: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash\nArgument: value - EmptyString. Value to test if it is an unsigned integer.\nReturn Code: 0 - if it is an unsigned integer\nReturn Code: 1 - if it is not an unsigned integer\nRequires: returnMessage\n\n'
requires=$'returnMessage\n'
return_code=$'0 - if it is an unsigned integer\n1 - if it is not an unsigned integer\n'
see=$'https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash\n'
sourceFile="bin/build/tools/example.sh"
sourceHash="1a917739e0fd19593fd63f029e67917ba1361e82"
sourceLine="162"
summary="Is value an unsigned integer?"
summaryComputed=""
usage="isUnsignedInteger [ value ]"
