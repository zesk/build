#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sugar.sh"
argument="executor ... -- - The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial \`--\`."$'\n'"-- - Alone after the executor forces \`stdin\` to be ignored. The \`--\` flag is also removed from the arguments passed to the executor."$'\n'"... - Any additional arguments are passed directly to the executor"$'\n'""
base="sugar.sh"
description="Support arguments and stdin as arguments to an executor"$'\n'""
file="bin/build/tools/sugar.sh"
fn="executeInputSupport"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/sugar.sh"
sourceModified="1768769473"
summary="Support arguments and stdin as arguments to an executor"
usage="executeInputSupport [ executor ... -- ] [ -- ] [ ... ]"
