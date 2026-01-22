#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--prefix - EnvironmentVariable|Blank. Optional. All subsequent environment variables are prefixed with this prefix."$'\n'"--require - Flag. Optional. All subsequent environment files on the command line will be required."$'\n'"--optional - Flag. Optional. All subsequent environment files on the command line will be optional. (If they do not exist, no errors.)"$'\n'"--verbose - Flag. Optional. Output errors with variables in files."$'\n'"environmentFile - Required. Environment file to load. For \`--optional\` files the directory must exist."$'\n'"--ignore environmentName - String. Optional. Environment value to ignore on load."$'\n'"--secure environmentName - String. Optional. If found in a loaded file, entire file fails."$'\n'"--secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the \`--ignore\` list."$'\n'"--execute arguments ... - Callable. Optional. All additional arguments are passed to callable after loading environment files."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Safely load an environment file (no code execution)"$'\n'"Return Code: 2 - if file does not exist; outputs an error"$'\n'"Return Code: 0 - if files are loaded successfully"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentFileLoad"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769063211"
summary="Safely load an environment file (no code execution)"
usage="environmentFileLoad [ --prefix ] --require [ --optional ] [ --verbose ] environmentFile [ --ignore environmentName ] [ --secure environmentName ] [ --secure-defaults ] [ --execute arguments ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentFileLoad[0m [94m[ --prefix ][0m [38;2;255;255;0m[35;48;2;0;0;0m--require[0m[0m [94m[ --optional ][0m [94m[ --verbose ][0m [38;2;255;255;0m[35;48;2;0;0;0menvironmentFile[0m[0m [94m[ --ignore environmentName ][0m [94m[ --secure environmentName ][0m [94m[ --secure-defaults ][0m [94m[ --execute arguments ... ][0m [94m[ --help ][0m

    [94m--prefix                  [1;97mEnvironmentVariable|Blank. Optional. All subsequent environment variables are prefixed with this prefix.[0m
    [31m--require                 [1;97mFlag. Optional. All subsequent environment files on the command line will be required.[0m
    [94m--optional                [1;97mFlag. Optional. All subsequent environment files on the command line will be optional. (If they do not exist, no errors.)[0m
    [94m--verbose                 [1;97mFlag. Optional. Output errors with variables in files.[0m
    [31menvironmentFile           [1;97mRequired. Environment file to load. For [38;2;0;255;0;48;2;0;0;0m--optional[0m files the directory must exist.[0m
    [94m--ignore environmentName  [1;97mString. Optional. Environment value to ignore on load.[0m
    [94m--secure environmentName  [1;97mString. Optional. If found in a loaded file, entire file fails.[0m
    [94m--secure-defaults         [1;97mFlag. Optional. Add a list of environment variables considered security risks to the [38;2;0;255;0;48;2;0;0;0m--ignore[0m list.[0m
    [94m--execute arguments ...   [1;97mCallable. Optional. All additional arguments are passed to callable after loading environment files.[0m
    [94m--help                    [1;97mFlag. Optional. Display this help.[0m

Safely load an environment file (no code execution)
Return Code: 2 - if file does not exist; outputs an error
Return Code: 0 - if files are loaded successfully

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileLoad [ --prefix ] --require [ --optional ] [ --verbose ] environmentFile [ --ignore environmentName ] [ --secure environmentName ] [ --secure-defaults ] [ --execute arguments ... ] [ --help ]

    --prefix                  EnvironmentVariable|Blank. Optional. All subsequent environment variables are prefixed with this prefix.
    --require                 Flag. Optional. All subsequent environment files on the command line will be required.
    --optional                Flag. Optional. All subsequent environment files on the command line will be optional. (If they do not exist, no errors.)
    --verbose                 Flag. Optional. Output errors with variables in files.
    environmentFile           Required. Environment file to load. For --optional files the directory must exist.
    --ignore environmentName  String. Optional. Environment value to ignore on load.
    --secure environmentName  String. Optional. If found in a loaded file, entire file fails.
    --secure-defaults         Flag. Optional. Add a list of environment variables considered security risks to the --ignore list.
    --execute arguments ...   Callable. Optional. All additional arguments are passed to callable after loading environment files.
    --help                    Flag. Optional. Display this help.

Safely load an environment file (no code execution)
Return Code: 2 - if file does not exist; outputs an error
Return Code: 0 - if files are loaded successfully

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
