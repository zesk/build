#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'testValue - Boolean. Required. Test value\ntrueChoice - EmptyString. Optional. Value to output when testValue is `true`\nfalseChoice - EmptyString. Optional. Value to output when testValue is `false`\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Boolean selector\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="booleanChoose"
fnMarker="booleanchoose"
foundNames=([0]="requires" [1]="argument")
line="87"
rawComment=$'Boolean selector\nRequires: isBoolean returnArgument printf\nArgument: testValue - Boolean. Required. Test value\nArgument: trueChoice - EmptyString. Optional. Value to output when testValue is `true`\nArgument: falseChoice - EmptyString. Optional. Value to output when testValue is `false`\n\n'
requires=$'isBoolean returnArgument printf\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="87"
summary="Boolean selector"
summaryComputed="true"
usage="booleanChoose testValue [ trueChoice ] [ falseChoice ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbooleanChoose'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtestValue'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ trueChoice ]'$'\e''[0m '$'\e''[[(blue)]m[ falseChoice ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtestValue    '$'\e''[[(value)]mBoolean. Required. Test value'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtrueChoice   '$'\e''[[(value)]mEmptyString. Optional. Value to output when testValue is '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfalseChoice  '$'\e''[[(value)]mEmptyString. Optional. Value to output when testValue is '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Boolean selector'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: booleanChoose testValue [ trueChoice ] [ falseChoice ]'$'\n'''$'\n''    testValue    Boolean. Required. Test value'$'\n''    trueChoice   EmptyString. Optional. Value to output when testValue is true'$'\n''    falseChoice  EmptyString. Optional. Value to output when testValue is false'$'\n'''$'\n''Boolean selector'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/sugar-core.md"
