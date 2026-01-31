#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="platform.sh"
description="Argument: count - The number of times to run the binary"$'\n'"Argument: binary - The binary to run"$'\n'"Argument: args ... - Any arguments to pass to the binary each run"$'\n'"Return Code: 0 - success"$'\n'"Return Code: 2 - \`count\` is not an unsigned number"$'\n'"Return Code: Any - If \`binary\` fails, the exit code is returned"$'\n'"Summary: Run a binary count times"$'\n'""
file="bin/build/tools/platform.sh"
foundNames=()
rawComment="Argument: count - The number of times to run the binary"$'\n'"Argument: binary - The binary to run"$'\n'"Argument: args ... - Any arguments to pass to the binary each run"$'\n'"Return Code: 0 - success"$'\n'"Return Code: 2 - \`count\` is not an unsigned number"$'\n'"Return Code: Any - If \`binary\` fails, the exit code is returned"$'\n'"Summary: Run a binary count times"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="a1e5b60c969c8edace1146de6c1a3e07b2d6a084"
summary="Argument: count - The number of times to run the"
usage="runCount"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mrunCount'$'\e''[0m'$'\n'''$'\n''Argument: count - The number of times to run the binary'$'\n''Argument: binary - The binary to run'$'\n''Argument: args ... - Any arguments to pass to the binary each run'$'\n''Return Code: 0 - success'$'\n''Return Code: 2 - '$'\e''[[(code)]mcount'$'\e''[[(reset)]m is not an unsigned number'$'\n''Return Code: Any - If '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m fails, the exit code is returned'$'\n''Summary: Run a binary count times'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: runCount'$'\n'''$'\n''Argument: count - The number of times to run the binary'$'\n''Argument: binary - The binary to run'$'\n''Argument: args ... - Any arguments to pass to the binary each run'$'\n''Return Code: 0 - success'$'\n''Return Code: 2 - count is not an unsigned number'$'\n''Return Code: Any - If binary fails, the exit code is returned'$'\n''Summary: Run a binary count times'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.466
