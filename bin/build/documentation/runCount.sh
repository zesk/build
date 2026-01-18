#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="count - The number of times to run the binary"$'\n'"binary - The binary to run"$'\n'"args ... - Any arguments to pass to the binary each run"$'\n'""
base="platform.sh"
description="Return Code: 0 - success"$'\n'"Return Code: 2 - \`count\` is not an unsigned number"$'\n'"Return Code: Any - If \`binary\` fails, the exit code is returned"$'\n'""
file="bin/build/tools/platform.sh"
fn="runCount"
foundNames=([0]="argument" [1]="summary")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/platform.sh"
sourceModified="1768695708"
summary="Run a binary count times"$'\n'""
usage="runCount [ count ] [ binary ] [ args ... ]"
