#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="returnCode - Integer. Required. Return code."$'\n'"handler - Function. Required. Error handler."$'\n'"message ... - String. Optional. Error message"$'\n'""
base="_sugar.sh"
description="Run \`handler\` with a passed return code"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="returnThrow"
foundNames=""
requires="returnArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1768721470"
summary="Run \`handler\` with a passed return code"
usage="returnThrow returnCode handler [ message ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mreturnThrow[0m [38;2;255;255;0m[35;48;2;0;0;0mreturnCode[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mhandler[0m[0m [94m[ message ... ][0m

    [31mreturnCode   [1;97mInteger. Required. Return code.[0m
    [31mhandler      [1;97mFunction. Required. Error handler.[0m
    [94mmessage ...  [1;97mString. Optional. Error message[0m

Run [38;2;0;255;0;48;2;0;0;0mhandler[0m with a passed return code

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: returnThrow returnCode handler [ message ... ]

    returnCode   Integer. Required. Return code.
    handler      Function. Required. Error handler.
    message ...  String. Optional. Error message

Run handler with a passed return code

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
