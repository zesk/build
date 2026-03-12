#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="number - Float. Optional. Floating point number to convert to integer."$'\n'""
base="float.sh"
description="Convert float to nearest integer (up or down)"$'\n'""
file="bin/build/tools/float.sh"
fn="floatRound"
foundNames=([0]="argument")
rawComment="Argument: number - Float. Optional. Floating point number to convert to integer."$'\n'"Convert float to nearest integer (up or down)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/float.sh"
sourceHash="25bac776a3510ed38395c9aba0e29f9c2fcc90a4"
summary="Convert float to nearest integer (up or down)"
summaryComputed="true"
usage="floatRound [ number ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfloatRound'$'\e''[0m '$'\e''[[(blue)]m[ number ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mnumber  '$'\e''[[(value)]mFloat. Optional. Floating point number to convert to integer.'$'\e''[[(reset)]m'$'\n'''$'\n''Convert float to nearest integer (up or down)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: floatRound [ number ]'$'\n'''$'\n''    number  Float. Optional. Floating point number to convert to integer.'$'\n'''$'\n''Convert float to nearest integer (up or down)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
