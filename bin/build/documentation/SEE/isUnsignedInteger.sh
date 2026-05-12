#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'value - EmptyString. Value to test if it is an unsigned integer.\n'
base="example.sh"
credits=$'F. Hauri - Give Up GitHub (isnum_Case)\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Test if a value is a 0 or greater integer. Leading "+" is ok.\n\n'
descriptionLineCount="2"
file="bin/build/tools/example.sh"
fn="isUnsignedInteger"
fnMarker="isunsignedinteger"
foundNames=([0]="summary" [1]="source" [2]="credits" [3]="original" [4]="argument" [5]="return_code" [6]="requires")
line="170"
original=$'is_uint\n'
rawComment=$'Summary: Is value an unsigned integer?\nTest if a value is a 0 or greater integer. Leading "+" is ok.\nSource: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash\nCredits: F. Hauri - Give Up GitHub (isnum_Case)\nOriginal: is_uint\nArgument: value - EmptyString. Value to test if it is an unsigned integer.\nReturn Code: 0 - if it is an unsigned integer\nReturn Code: 1 - if it is not an unsigned integer\nRequires: returnMessage\n\n'
requires=$'returnMessage\n'
return_code=$'0 - if it is an unsigned integer\n1 - if it is not an unsigned integer\n'
source=$'https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash\n'
sourceFile="bin/build/tools/example.sh"
sourceHash="b022132ab9f0f4be979507ecfffaf181905e4034"
sourceLine="170"
summary="Is value an unsigned integer?"
summaryComputed=""
usage="isUnsignedInteger [ value ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misUnsignedInteger'$'\e''[0m '$'\e''[[(blue)]m[ value ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mvalue  '$'\e''[[(value)]mEmptyString. Value to test if it is an unsigned integer.'$'\e''[[(reset)]m'$'\n'''$'\n''Test if a value is a 0 or greater integer. Leading "+" is ok.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if it is an unsigned integer'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if it is not an unsigned integer'
# shellcheck disable=SC2016
helpPlain='Usage: isUnsignedInteger [ value ]'$'\n'''$'\n''    value  EmptyString. Value to test if it is an unsigned integer.'$'\n'''$'\n''Test if a value is a 0 or greater integer. Leading "+" is ok.'$'\n'''$'\n''Return codes:'$'\n''- 0 - if it is an unsigned integer'$'\n''- 1 - if it is not an unsigned integer'
documentationPath="documentation/source/tools/type.md"
