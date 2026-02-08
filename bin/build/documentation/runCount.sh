#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-08
# shellcheck disable=SC2034
argument="count - The number of times to run the binary"$'\n'"binary - The binary to run"$'\n'"args ... - Any arguments to pass to the binary each run"$'\n'""
base="platform.sh"
description="Run a binary count times"$'\n'""
file="bin/build/tools/platform.sh"
foundNames=([0]="argument" [1]="return_code" [2]="summary")
rawComment="Argument: count - The number of times to run the binary"$'\n'"Argument: binary - The binary to run"$'\n'"Argument: args ... - Any arguments to pass to the binary each run"$'\n'"Return Code: 0 - success"$'\n'"Return Code: 2 - \`count\` is not an unsigned number"$'\n'"Return Code: Any - If \`binary\` fails, the exit code is returned"$'\n'"Summary: Run a binary count times"$'\n'""$'\n'""
return_code="0 - success"$'\n'"2 - \`count\` is not an unsigned number"$'\n'"Any - If \`binary\` fails, the exit code is returned"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="2669082839d4462d80f9e37b8fb982dadfecaea2"
summary="Run a binary count times"$'\n'""
usage="runCount [ count ] [ binary ] [ args ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mrunCount'$'\e''[0m '$'\e''[[(blue)]m[ count ]'$'\e''[0m '$'\e''[[(blue)]m[ binary ]'$'\e''[0m '$'\e''[[(blue)]m[ args ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcount     '$'\e''[[(value)]mThe number of times to run the binary'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mbinary    '$'\e''[[(value)]mThe binary to run'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]margs ...  '$'\e''[[(value)]mAny arguments to pass to the binary each run'$'\e''[[(reset)]m'$'\n'''$'\n''Run a binary count times'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - success'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - '$'\e''[[(code)]mcount'$'\e''[[(reset)]m is not an unsigned number'$'\n''- '$'\e''[[(code)]mAny'$'\e''[[(reset)]m - If '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m fails, the exit code is returned'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: runCount [ count ] [ binary ] [ args ... ]'$'\n'''$'\n''    count     The number of times to run the binary'$'\n''    binary    The binary to run'$'\n''    args ...  Any arguments to pass to the binary each run'$'\n'''$'\n''Run a binary count times'$'\n'''$'\n''Return codes:'$'\n''- 0 - success'$'\n''- 2 - count is not an unsigned number'$'\n''- Any - If binary fails, the exit code is returned'$'\n'''
