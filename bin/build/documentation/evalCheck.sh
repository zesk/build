#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="none"
base="security.sh"
description="Check files to ensure \`eval\`s in code have been checked"$'\n'""
file="bin/build/tools/security.sh"
fn="evalCheck"
foundNames=()
rawComment="Check files to ensure \`eval\`s in code have been checked"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/security.sh"
sourceHash="b474798424b5621a9b9a6c37271a50ffba450b77"
summary="Check files to ensure \`eval\`s in code have been checked"
summaryComputed="true"
usage="evalCheck"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mevalCheck'$'\e''[0m'$'\n'''$'\n''Check files to ensure '$'\e''[[(code)]meval'$'\e''[[(reset)]ms in code have been checked'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: evalCheck'$'\n'''$'\n''Check files to ensure evals in code have been checked'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
