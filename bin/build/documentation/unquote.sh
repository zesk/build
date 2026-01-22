#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/quote.sh"
argument="quote - String. Required. Must match beginning and end of string."$'\n'"value - String. Required. Value to unquote."$'\n'""
base="quote.sh"
description="Unquote a string"$'\n'""
file="bin/build/tools/quote.sh"
fn="unquote"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceModified="1769059755"
summary="Unquote a string"
usage="unquote quote value"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255munquote[0m [38;2;255;255;0m[35;48;2;0;0;0mquote[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mvalue[0m[0m

    [31mquote  [1;97mString. Required. Must match beginning and end of string.[0m
    [31mvalue  [1;97mString. Required. Value to unquote.[0m

Unquote a string

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: unquote quote value

    quote  String. Required. Must match beginning and end of string.
    value  String. Required. Value to unquote.

Unquote a string

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
