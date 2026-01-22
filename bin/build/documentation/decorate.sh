#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decorate.sh"
argument="style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration"$'\n'"text ... - String. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for \`style\`."$'\n'""
base="decorate.sh"
description="Singular decoration function"$'\n'"You can extend this function by writing a your own extension \`__decorationExtensionCustom\` is called for \`decorate custom\`."$'\n'""
environment="__BUILD_DECORATE - String. Cached color lookup."$'\n'"BUILD_COLORS - Boolean. Colors enabled (\`true\` or \`false\`)."$'\n'""
file="bin/build/tools/decorate.sh"
fn="decorate"
requires="isFunction returnArgument awk catchEnvironment usageDocument executeInputSupport __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate.sh"
sourceModified="1768721469"
stdout="Decorated text"$'\n'""
summary="Singular decoration function"
usage="decorate style [ text ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdecorate[0m [38;2;255;255;0m[35;48;2;0;0;0mstyle[0m[0m [94m[ text ... ][0m

    [31mstyle     [1;97mString. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration[0m
    [94mtext ...  [1;97mString. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for [38;2;0;255;0;48;2;0;0;0mstyle[0m.[0m

Singular decoration function
You can extend this function by writing a your own extension [38;2;0;255;0;48;2;0;0;0m__decorationExtensionCustom[0m is called for [38;2;0;255;0;48;2;0;0;0mdecorate custom[0m.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- __BUILD_DECORATE - String. Cached color lookup.
- BUILD_COLORS - Boolean. Colors enabled ([38;2;0;255;0;48;2;0;0;0mtrue[0m or [38;2;0;255;0;48;2;0;0;0mfalse[0m).
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Decorated text
'
# shellcheck disable=SC2016
helpPlain='Usage: decorate style [ text ... ]

    style     String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration
    text ...  String. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for style.

Singular decoration function
You can extend this function by writing a your own extension __decorationExtensionCustom is called for decorate custom.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- __BUILD_DECORATE - String. Cached color lookup.
- BUILD_COLORS - Boolean. Colors enabled (true or false).
- 

Writes to stdout:
Decorated text
'
