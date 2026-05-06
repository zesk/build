#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"executor ... -- Required. The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial \`--\`."$'\n'"-- - Alone after the executor forces \`stdin\` to be ignored. The \`--\` flag is also removed from the arguments passed to the executor."$'\n'"... - Any additional arguments are passed directly to the executor"$'\n'""
base="sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Support arguments and stdin as arguments to an executor"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/sugar.sh"
fn="executeInputSupport"
fnMarker="executeinputsupport"
foundNames=([0]="argument" [1]="requires")
line="167"
rawComment="Support arguments and stdin as arguments to an executor"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: executor ... -- Required. The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial \`--\`."$'\n'"Argument: -- - Alone after the executor forces \`stdin\` to be ignored. The \`--\` flag is also removed from the arguments passed to the executor."$'\n'"Argument: ... - Any additional arguments are passed directly to the executor"$'\n'"Requires: catchReturn bashDocumentation"$'\n'""$'\n'""
requires="catchReturn bashDocumentation"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="e8338cd30cac46f1f4725c84ca79d511b7921f72"
sourceLine="167"
summary="Support arguments and stdin as arguments to an executor"
summaryComputed="true"
usage="executeInputSupport [ --help ] [ executor ... -- Required. The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial \`--\`. ] [ -- ] [ ... ]"
