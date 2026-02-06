#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-06
# shellcheck disable=SC2034
argument="message - Why test was skipped."$'\n'""
base="junit.sh"
description="Output test skipped XML"$'\n'""
file="bin/build/tools/junit.sh"
foundNames=([0]="summary" [1]="argument")
rawComment="Summary: Output test skipped XML"$'\n'"Argument: message - Why test was skipped."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/junit.sh"
sourceHash="f92f864478de7e8478b8b8c16722ea1f4d009ea0"
summary="Output test skipped XML"$'\n'""
usage="junitTestCaseSkipped [ message ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjunitTestCaseSkipped'$'\e''[0m '$'\e''[[(blue)]m[ message ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mmessage  '$'\e''[[(value)]mWhy test was skipped.'$'\e''[[(reset)]m'$'\n'''$'\n''Output test skipped XML'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]mjunitTestCaseSkipped [ message ]'$'\n'''$'\n''    message  Why test was skipped.'$'\n'''$'\n''Output test skipped XML'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
