#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="startingDirectory - Required. EmptyString|RealDirectory. Uses the current directory if blank."$'\n'"--pattern filePattern - RelativePath. Required. The file or directory to find the home for."$'\n'"--test testExpression - String. Optional. Zero or more. The \`test\` argument to test the targeted \`filePattern\`. By default uses \`-d\`."$'\n'""
base="directory.sh"
description="Finds a file above \`startingDirectory\`, uses \`testExpression\` to test (defaults to \`-d\`)"$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryParent"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceModified="1768756695"
summary="Finds a file above \`startingDirectory\`, uses \`testExpression\` to test (defaults"
usage="directoryParent startingDirectory --pattern filePattern [ --test testExpression ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdirectoryParent[0m [38;2;255;255;0m[35;48;2;0;0;0mstartingDirectory[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--pattern filePattern[0m[0m [94m[ --test testExpression ][0m

    [31mstartingDirectory      [1;97mRequired. EmptyString|RealDirectory. Uses the current directory if blank.[0m
    [31m--pattern filePattern  [1;97mRelativePath. Required. The file or directory to find the home for.[0m
    [94m--test testExpression  [1;97mString. Optional. Zero or more. The [38;2;0;255;0;48;2;0;0;0mtest[0m argument to test the targeted [38;2;0;255;0;48;2;0;0;0mfilePattern[0m. By default uses [38;2;0;255;0;48;2;0;0;0m-d[0m.[0m

Finds a file above [38;2;0;255;0;48;2;0;0;0mstartingDirectory[0m, uses [38;2;0;255;0;48;2;0;0;0mtestExpression[0m to test (defaults to [38;2;0;255;0;48;2;0;0;0m-d[0m)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: directoryParent startingDirectory --pattern filePattern [ --test testExpression ]

    startingDirectory      Required. EmptyString|RealDirectory. Uses the current directory if blank.
    --pattern filePattern  RelativePath. Required. The file or directory to find the home for.
    --test testExpression  String. Optional. Zero or more. The test argument to test the targeted filePattern. By default uses -d.

Finds a file above startingDirectory, uses testExpression to test (defaults to -d)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
