#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="testValue - Boolean. Required. Test value"$'\n'"trueChoice - EmptyString. Optional. Value to output when testValue is \`true\`"$'\n'"falseChoice - EmptyString. Optional. Value to output when testValue is \`false\`"$'\n'""
base="_sugar.sh"
description="Boolean selector"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="booleanChoose"
foundNames=""
requires="isBoolean returnArgument printf"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1769063211"
summary="Boolean selector"
usage="booleanChoose testValue [ trueChoice ] [ falseChoice ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbooleanChoose[0m [38;2;255;255;0m[35;48;2;0;0;0mtestValue[0m[0m [94m[ trueChoice ][0m [94m[ falseChoice ][0m

    [31mtestValue    [1;97mBoolean. Required. Test value[0m
    [94mtrueChoice   [1;97mEmptyString. Optional. Value to output when testValue is [38;2;0;255;0;48;2;0;0;0mtrue[0m[0m
    [94mfalseChoice  [1;97mEmptyString. Optional. Value to output when testValue is [38;2;0;255;0;48;2;0;0;0mfalse[0m[0m

Boolean selector

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: booleanChoose testValue [ trueChoice ] [ falseChoice ]

    testValue    Boolean. Required. Test value
    trueChoice   EmptyString. Optional. Value to output when testValue is true
    falseChoice  EmptyString. Optional. Value to output when testValue is false

Boolean selector

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
