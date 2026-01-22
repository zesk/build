#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/test.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"binary - Callable. Optional. Run this program after loading test tools."$'\n'"... - Optional. Arguments. Arguments for binary."$'\n'""
base="test.sh"
description="Load test tools and make \`testSuite\` function available"$'\n'""$'\n'""$'\n'""
file="bin/build/tools/test.sh"
fn="testTools"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceModified="1768759127"
summary="Load test tools and make \`testSuite\` function available"
usage="testTools [ --help ] [ binary ] [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtestTools[0m [94m[ --help ][0m [94m[ binary ][0m [94m[ ... ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94mbinary  [1;97mCallable. Optional. Run this program after loading test tools.[0m
    [94m...     [1;97mOptional. Arguments. Arguments for binary.[0m

Load test tools and make [38;2;0;255;0;48;2;0;0;0mtestSuite[0m function available

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: testTools [ --help ] [ binary ] [ ... ]

    --help  Flag. Optional. Display this help.
    binary  Callable. Optional. Run this program after loading test tools.
    ...     Optional. Arguments. Arguments for binary.

Load test tools and make testSuite function available

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
