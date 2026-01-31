#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="testValue - Boolean. Required. Test value"$'\n'"trueChoice - EmptyString. Optional. Value to output when testValue is \`true\`"$'\n'"falseChoice - EmptyString. Optional. Value to output when testValue is \`false\`"$'\n'""
base="_sugar.sh"
description="Boolean selector"$'\n'""
file="bin/build/tools/_sugar.sh"
foundNames=([0]="requires" [1]="argument")
rawComment="Boolean selector"$'\n'"Requires: isBoolean returnArgument printf"$'\n'"Argument: testValue - Boolean. Required. Test value"$'\n'"Argument: trueChoice - EmptyString. Optional. Value to output when testValue is \`true\`"$'\n'"Argument: falseChoice - EmptyString. Optional. Value to output when testValue is \`false\`"$'\n'""$'\n'""
requires="isBoolean returnArgument printf"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="4bce6d8a22071b1c44a64aadb33672fc47a840f1"
summary="Boolean selector"
summaryComputed="true"
usage="booleanChoose testValue [ trueChoice ] [ falseChoice ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbooleanChoose'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtestValue'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ trueChoice ]'$'\e''[0m '$'\e''[[(blue)]m[ falseChoice ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtestValue    '$'\e''[[(value)]mBoolean. Required. Test value'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtrueChoice   '$'\e''[[(value)]mEmptyString. Optional. Value to output when testValue is '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfalseChoice  '$'\e''[[(value)]mEmptyString. Optional. Value to output when testValue is '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Boolean selector'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mbooleanChoose [[(bold)]m[[(magenta)]mtestValue [[(blue)]m[ trueChoice ] [[(blue)]m[ falseChoice ]'$'\n'''$'\n''    [[(red)]mtestValue    [[(value)]mBoolean. Required. Test value[[(reset)]m'$'\n''    [[(blue)]mtrueChoice   [[(value)]mEmptyString. Optional. Value to output when testValue is [[(code)]mtrue[[(reset)]m[[(reset)]m'$'\n''    [[(blue)]mfalseChoice  [[(value)]mEmptyString. Optional. Value to output when testValue is [[(code)]mfalse[[(reset)]m[[(reset)]m'$'\n'''$'\n''Boolean selector'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m1[[(reset)]m - Environment error'$'\n''- [[(code)]m2[[(reset)]m - Argument error'$'\n'''
# elapsed 3.387
