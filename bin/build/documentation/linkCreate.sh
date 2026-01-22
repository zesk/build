#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="target - Exists. File. Source file name or path."$'\n'"linkName - String. Required. Link short name, created next to \`target\`."$'\n'""
base="file.sh"
description="Create a link"$'\n'""$'\n'""
file="bin/build/tools/file.sh"
fn="linkCreate"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1769063211"
summary="Create a link"
usage="linkCreate [ target ] linkName"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mlinkCreate[0m [94m[ target ][0m [38;2;255;255;0m[35;48;2;0;0;0mlinkName[0m[0m

    [94mtarget    [1;97mExists. File. Source file name or path.[0m
    [31mlinkName  [1;97mString. Required. Link short name, created next to [38;2;0;255;0;48;2;0;0;0mtarget[0m.[0m

Create a link

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: linkCreate [ target ] linkName

    target    Exists. File. Source file name or path.
    linkName  String. Required. Link short name, created next to target.

Create a link

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
