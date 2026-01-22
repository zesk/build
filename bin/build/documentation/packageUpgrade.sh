#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--verbose - Flag. Optional. Display progress to the terminal."$'\n'"--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"--force - Flag. Optional. Force even if it was updated recently."$'\n'""
base="package.sh"
description="Upgrade packages lists and sources"$'\n'""
file="bin/build/tools/package.sh"
fn="packageUpgrade"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Upgrade packages lists and sources"
usage="packageUpgrade [ --help ] [ --verbose ] [ --manager packageManager ] [ --force ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageUpgrade[0m [94m[ --help ][0m [94m[ --verbose ][0m [94m[ --manager packageManager ][0m [94m[ --force ][0m

    [94m--help                    [1;97mFlag. Optional. Display this help.[0m
    [94m--verbose                 [1;97mFlag. Optional. Display progress to the terminal.[0m
    [94m--manager packageManager  [1;97mString. Optional. Package manager to use. (apk, apt, brew)[0m
    [94m--force                   [1;97mFlag. Optional. Force even if it was updated recently.[0m

Upgrade packages lists and sources

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: packageUpgrade [ --help ] [ --verbose ] [ --manager packageManager ] [ --force ]

    --help                    Flag. Optional. Display this help.
    --verbose                 Flag. Optional. Display progress to the terminal.
    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)
    --force                   Flag. Optional. Force even if it was updated recently.

Upgrade packages lists and sources

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
