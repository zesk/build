#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-08
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="List the extensions available"$'\n'""
file="bin/build/tools/git.sh"
fn="gitPreCommitExtensionList"
foundNames=([0]="argument" [1]="stdout")
rawComment="List the extensions available"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: String. One per line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="ef317634b04a01c8ac47c9c01567340a86b0e4b6"
stdout="String. One per line."$'\n'""
summary="List the extensions available"
summaryComputed="true"
usage="gitPreCommitExtensionList [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitPreCommitExtensionList'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''List the extensions available'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''String. One per line.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitPreCommitExtensionList [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''List the extensions available'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''String. One per line.'$'\n'''
