#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decorate-extensions.sh"
argument="style - String. Required. The style to fetch or replace."$'\n'"newFormat - String. Optional. The new style formatting options as a string in the form \`lp dp label\`"$'\n'""
base="decorate-extensions.sh"
description="Fetch"$'\n'""
file="bin/build/tools/decorate-extensions.sh"
fn="decorateStyle"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate-extensions.sh"
sourceModified="1768759278"
summary="Fetch"
usage="decorateStyle style [ newFormat ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdecorateStyle[0m [38;2;255;255;0m[35;48;2;0;0;0mstyle[0m[0m [94m[ newFormat ][0m

    [31mstyle      [1;97mString. Required. The style to fetch or replace.[0m
    [94mnewFormat  [1;97mString. Optional. The new style formatting options as a string in the form [38;2;0;255;0;48;2;0;0;0mlp dp label[0m[0m

Fetch

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: decorateStyle style [ newFormat ]

    style      String. Required. The style to fetch or replace.
    newFormat  String. Optional. The new style formatting options as a string in the form lp dp label

Fetch

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
