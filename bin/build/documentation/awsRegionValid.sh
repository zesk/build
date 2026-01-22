#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="region ... - String. Required. The AWS Region to validate."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
checked="2024-09-02"$'\n'""
description="Checks an AWS region identifier for validity as of September 2024."$'\n'"Note that passing no parameters returns success."$'\n'"Return Code: 0 - All regions are valid AWS region"$'\n'"Return Code: 1 - One or more regions are NOT a valid AWS region"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsRegionValid"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1768758981"
summary="Check an AWS region code for validity"$'\n'""
usage="awsRegionValid region ... [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mawsRegionValid[0m [38;2;255;255;0m[35;48;2;0;0;0mregion ...[0m[0m [94m[ --help ][0m

    [31mregion ...  [1;97mString. Required. The AWS Region to validate.[0m
    [94m--help      [1;97mFlag. Optional. Display this help.[0m

Checks an AWS region identifier for validity as of September 2024.
Note that passing no parameters returns success.
Return Code: 0 - All regions are valid AWS region
Return Code: 1 - One or more regions are NOT a valid AWS region

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: awsRegionValid region ... [ --help ]

    region ...  String. Required. The AWS Region to validate.
    --help      Flag. Optional. Display this help.

Checks an AWS region identifier for validity as of September 2024.
Note that passing no parameters returns success.
Return Code: 0 - All regions are valid AWS region
Return Code: 1 - One or more regions are NOT a valid AWS region

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
