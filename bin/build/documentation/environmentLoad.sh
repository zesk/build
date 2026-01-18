#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--verbose - Flag. Optional. Output errors with variables."$'\n'"--debug - Flag. Optional. Debugging mode, for developers probably."$'\n'"--prefix - String. Optional. Prefix each environment variable defined with this string. e.g. \`NAME\` -> \`DSN_NAME\` for \`--prefix DSN_\`"$'\n'"--context - String. Optional. Name of the context for debugging or error messages. (e.g. what is this doing for whom and why)"$'\n'"--ignore environmentName - String. Optional. Environment value to ignore on load."$'\n'"--secure environmentName - String. Optional. If found, entire load fails."$'\n'"--secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the \`--ignore\` list."$'\n'"--execute arguments ... - Callable. Optional. All additional arguments are passed to callable after loading environment."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Safely load an environment from stdin (no code execution)"$'\n'"Return Code: 2 - if file does not exist; outputs an error"$'\n'"Return Code: 0 - if files are loaded successfully"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentLoad"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768759812"
summary="Safely load an environment from stdin (no code execution)"
usage="environmentLoad [ --verbose ] [ --debug ] [ --prefix ] [ --context ] [ --ignore environmentName ] [ --secure environmentName ] [ --secure-defaults ] [ --execute arguments ... ] [ --help ]"
