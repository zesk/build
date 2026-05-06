#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="count - The number of times to run the binary"$'\n'"binary - The binary to run"$'\n'"args ... - Any arguments to pass to the binary each run"$'\n'""
base="platform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run a binary count times"
descriptionLineCount=""
file="bin/build/tools/platform.sh"
fn="executeCount"
fnMarker="executecount"
foundNames=([0]="argument" [1]="return_code" [2]="summary")
line="59"
rawComment="Argument: count - The number of times to run the binary"$'\n'"Argument: binary - The binary to run"$'\n'"Argument: args ... - Any arguments to pass to the binary each run"$'\n'"Return Code: 0 - success"$'\n'"Return Code: 2 - \`count\` is not an unsigned number"$'\n'"Return Code: Any - If \`binary\` fails, the exit code is returned"$'\n'"Summary: Run a binary count times"$'\n'""$'\n'""
return_code="0 - success"$'\n'"2 - \`count\` is not an unsigned number"$'\n'"Any - If \`binary\` fails, the exit code is returned"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="097e41ee15602cdab3bc28d8a420362c8b93b425"
sourceLine="59"
summary="Run a binary count times"
summaryComputed=""
usage="executeCount [ count ] [ binary ] [ args ... ]"
