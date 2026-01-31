#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"type - String. Optional. Type to validate as \`validate\` type."$'\n'""
base="validate.sh"
description="Are all arguments passed a valid validate type?"$'\n'""
example="    isValidateType string || returnMessage 1 \"string is not a type.\""$'\n'""
file="bin/build/tools/validate.sh"
foundNames=([0]="argument" [1]="example")
rawComment="Are all arguments passed a valid validate type?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: type - String. Optional. Type to validate as \`validate\` type."$'\n'"Example:     isValidateType string || returnMessage 1 \"string is not a type.\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/validate.sh"
sourceHash="c3d001ea5b6fdcfe124d5a9efce82769df3667a2"
summary="Are all arguments passed a valid validate type?"
summaryComputed="true"
usage="isValidateType [ --help ] [ type ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misValidateType'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ type ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtype    '$'\e''[[(value)]mString. Optional. Type to validate as '$'\e''[[(code)]mvalidate'$'\e''[[(reset)]m type.'$'\e''[[(reset)]m'$'\n'''$'\n''Are all arguments passed a valid validate type?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    isValidateType string || returnMessage 1 "string is not a type."'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]misValidateType [[(blue)]m[ --help ] [[(blue)]m[ type ]'$'\n'''$'\n''    [[(blue)]m--help  [[(value)]mFlag. Optional. Display this help.'$'\n''    [[(blue)]mtype    [[(value)]mString. Optional. Type to validate as [[(code)]mvalidate type.'$'\n'''$'\n''Are all arguments passed a valid validate type?'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''$'\n''Example:'$'\n''    isValidateType string || returnMessage 1 "string is not a type."'$'\n'''
# elapsed 4.015
