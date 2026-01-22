#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/cursor.sh"
argument="x - UnsignedInteger. Required. Column to place the cursor."$'\n'"y - UnsignedInteger. Required. Row to place the cursor."$'\n'""
base="cursor.sh"
description="Move the cursor to x y"$'\n'""
file="bin/build/tools/cursor.sh"
fn="cursorSet"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/cursor.sh"
sourceModified="1768695708"
summary="Move the cursor to x y"
usage="cursorSet x y"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcursorSet[0m [38;2;255;255;0m[35;48;2;0;0;0mx[0m[0m [38;2;255;255;0m[35;48;2;0;0;0my[0m[0m

    [31mx  [1;97mUnsignedInteger. Required. Column to place the cursor.[0m
    [31my  [1;97mUnsignedInteger. Required. Row to place the cursor.[0m

Move the cursor to x y

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: cursorSet x y

    x  UnsignedInteger. Required. Column to place the cursor.
    y  UnsignedInteger. Required. Row to place the cursor.

Move the cursor to x y

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
