#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--verbose - Flag. Optional. Output errors with variables."$'\n'"--debug - Flag. Optional. Debugging mode, for developers probably."$'\n'"--prefix - String. Optional. Prefix each environment variable defined with this string. e.g. \`NAME\` -> \`DSN_NAME\` for \`--prefix DSN_\`"$'\n'"--context - String. Optional. Name of the context for debugging or error messages. (e.g. what is this doing for whom and why)"$'\n'"--ignore environmentName - String. Optional. Environment value to ignore on load."$'\n'"--secure environmentName - String. Optional. If found, entire load fails."$'\n'"--secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the \`--ignore\` list."$'\n'"--execute arguments ... - Callable. Optional. All additional arguments are passed to callable after loading environment."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Safely load an environment from stdin (no code execution)"$'\n'"Return Code: 2 - if file does not exist; outputs an error"$'\n'"Return Code: 0 - if files are loaded successfully"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentLoad"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769061401"
summary="Safely load an environment from stdin (no code execution)"
usage="environmentLoad [ --verbose ] [ --debug ] [ --prefix ] [ --context ] [ --ignore environmentName ] [ --secure environmentName ] [ --secure-defaults ] [ --execute arguments ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentLoad[0m [94m[ --verbose ][0m [94m[ --debug ][0m [94m[ --prefix ][0m [94m[ --context ][0m [94m[ --ignore environmentName ][0m [94m[ --secure environmentName ][0m [94m[ --secure-defaults ][0m [94m[ --execute arguments ... ][0m [94m[ --help ][0m

    [94m--verbose                 [1;97mFlag. Optional. Output errors with variables.[0m
    [94m--debug                   [1;97mFlag. Optional. Debugging mode, for developers probably.[0m
    [94m--prefix                  [1;97mString. Optional. Prefix each environment variable defined with this string. e.g. [38;2;0;255;0;48;2;0;0;0mNAME[0m -> [38;2;0;255;0;48;2;0;0;0mDSN_NAME[0m for [38;2;0;255;0;48;2;0;0;0m--prefix DSN_[0m[0m
    [94m--context                 [1;97mString. Optional. Name of the context for debugging or error messages. (e.g. what is this doing for whom and why)[0m
    [94m--ignore environmentName  [1;97mString. Optional. Environment value to ignore on load.[0m
    [94m--secure environmentName  [1;97mString. Optional. If found, entire load fails.[0m
    [94m--secure-defaults         [1;97mFlag. Optional. Add a list of environment variables considered security risks to the [38;2;0;255;0;48;2;0;0;0m--ignore[0m list.[0m
    [94m--execute arguments ...   [1;97mCallable. Optional. All additional arguments are passed to callable after loading environment.[0m
    [94m--help                    [1;97mFlag. Optional. Display this help.[0m

Safely load an environment from stdin (no code execution)
Return Code: 2 - if file does not exist; outputs an error
Return Code: 0 - if files are loaded successfully

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentLoad [ --verbose ] [ --debug ] [ --prefix ] [ --context ] [ --ignore environmentName ] [ --secure environmentName ] [ --secure-defaults ] [ --execute arguments ... ] [ --help ]

    --verbose                 Flag. Optional. Output errors with variables.
    --debug                   Flag. Optional. Debugging mode, for developers probably.
    --prefix                  String. Optional. Prefix each environment variable defined with this string. e.g. NAME -> DSN_NAME for --prefix DSN_
    --context                 String. Optional. Name of the context for debugging or error messages. (e.g. what is this doing for whom and why)
    --ignore environmentName  String. Optional. Environment value to ignore on load.
    --secure environmentName  String. Optional. If found, entire load fails.
    --secure-defaults         Flag. Optional. Add a list of environment variables considered security risks to the --ignore list.
    --execute arguments ...   Callable. Optional. All additional arguments are passed to callable after loading environment.
    --help                    Flag. Optional. Display this help.

Safely load an environment from stdin (no code execution)
Return Code: 2 - if file does not exist; outputs an error
Return Code: 0 - if files are loaded successfully

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
