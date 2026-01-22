#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"scheme ... - String. Required. Scheme to look up the default port used for that scheme."$'\n'""
base="url.sh"
description="Output the port for the given scheme"$'\n'""
file="bin/build/tools/url.sh"
fn="urlSchemeDefaultPort"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceModified="1769063211"
summary="Output the port for the given scheme"
usage="urlSchemeDefaultPort [ --help ] [ --handler handler ] scheme ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255murlSchemeDefaultPort[0m [94m[ --help ][0m [94m[ --handler handler ][0m [38;2;255;255;0m[35;48;2;0;0;0mscheme ...[0m[0m

    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [31mscheme ...         [1;97mString. Required. Scheme to look up the default port used for that scheme.[0m

Output the port for the given scheme

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: urlSchemeDefaultPort [ --help ] [ --handler handler ] scheme ...

    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    scheme ...         String. Required. Scheme to look up the default port used for that scheme.

Output the port for the given scheme

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
