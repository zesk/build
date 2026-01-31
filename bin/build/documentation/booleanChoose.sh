#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="_sugar.sh"
description="Boolean selector"$'\n'"Requires: isBoolean returnArgument printf"$'\n'"Argument: testValue - Boolean. Required. Test value"$'\n'"Argument: trueChoice - EmptyString. Optional. Value to output when testValue is \`true\`"$'\n'"Argument: falseChoice - EmptyString. Optional. Value to output when testValue is \`false\`"$'\n'""
file="bin/build/tools/_sugar.sh"
foundNames=()
rawComment="Boolean selector"$'\n'"Requires: isBoolean returnArgument printf"$'\n'"Argument: testValue - Boolean. Required. Test value"$'\n'"Argument: trueChoice - EmptyString. Optional. Value to output when testValue is \`true\`"$'\n'"Argument: falseChoice - EmptyString. Optional. Value to output when testValue is \`false\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="4bce6d8a22071b1c44a64aadb33672fc47a840f1"
summary="Boolean selector"
usage="booleanChoose"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbooleanChoose'$'\e''[0m'$'\n'''$'\n''Boolean selector'$'\n''Requires: isBoolean returnArgument printf'$'\n''Argument: testValue - Boolean. Required. Test value'$'\n''Argument: trueChoice - EmptyString. Optional. Value to output when testValue is '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m'$'\n''Argument: falseChoice - EmptyString. Optional. Value to output when testValue is '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: booleanChoose'$'\n'''$'\n''Boolean selector'$'\n''Requires: isBoolean returnArgument printf'$'\n''Argument: testValue - Boolean. Required. Test value'$'\n''Argument: trueChoice - EmptyString. Optional. Value to output when testValue is true'$'\n''Argument: falseChoice - EmptyString. Optional. Value to output when testValue is false'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.432
