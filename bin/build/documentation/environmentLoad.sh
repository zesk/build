#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--verbose - Flag. Optional. Output errors with variables."$'\n'"--debug - Flag. Optional. Debugging mode, for developers probably."$'\n'"--prefix - String. Optional. Prefix each environment variable defined with this string. e.g. \`NAME\` -> \`DSN_NAME\` for \`--prefix DSN_\`"$'\n'"--context - String. Optional. Name of the context for debugging or error messages. (e.g. what is this doing for whom and why)"$'\n'"--ignore environmentName - String. Optional. Environment value to ignore on load."$'\n'"--secure environmentName - String. Optional. If found, entire load fails."$'\n'"--secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the \`--ignore\` list."$'\n'"--execute arguments ... - Callable. Optional. All additional arguments are passed to callable after loading environment."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="io.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Safely load an environment from stdin (no code execution)"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/environment/io.sh"
fn="environmentLoad"
fnMarker="environmentload"
foundNames=([0]="argument" [1]="return_code")
line="202"
rawComment="Safely load an environment from stdin (no code execution)"$'\n'"Argument: --verbose - Flag. Optional. Output errors with variables."$'\n'"Argument: --debug - Flag. Optional. Debugging mode, for developers probably."$'\n'"Argument: --prefix - String. Optional. Prefix each environment variable defined with this string. e.g. \`NAME\` -> \`DSN_NAME\` for \`--prefix DSN_\`"$'\n'"Argument: --context - String. Optional. Name of the context for debugging or error messages. (e.g. what is this doing for whom and why)"$'\n'"Argument: --ignore environmentName - String. Optional. Environment value to ignore on load."$'\n'"Argument: --secure environmentName - String. Optional. If found, entire load fails."$'\n'"Argument: --secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the \`--ignore\` list."$'\n'"Argument: --execute arguments ... - Callable. Optional. All additional arguments are passed to callable after loading environment."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 2 - if file does not exist; outputs an error"$'\n'"Return Code: 0 - if files are loaded successfully"$'\n'""$'\n'""
return_code="2 - if file does not exist; outputs an error"$'\n'"0 - if files are loaded successfully"$'\n'""
sourceFile="bin/build/tools/environment/io.sh"
sourceHash="9d970c9247c918e4438d4046d4dcca32d13b665b"
sourceLine="202"
summary="Safely load an environment from stdin (no code execution)"
summaryComputed="true"
usage="environmentLoad [ --verbose ] [ --debug ] [ --prefix ] [ --context ] [ --ignore environmentName ] [ --secure environmentName ] [ --secure-defaults ] [ --execute arguments ... ] [ --help ]"
