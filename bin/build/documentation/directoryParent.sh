#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="startingDirectory - Required. EmptyString|RealDirectory. Uses the current directory if blank."$'\n'"--pattern filePattern - RelativePath. Required. The file or directory to find the home for."$'\n'"--test testExpression - String. Optional. Zero or more. The \`test\` argument to test the targeted \`filePattern\`. By default uses \`-d\`."$'\n'""
base="directory.sh"
BASH_LINENO=([0]="129" [1]="963" [2]="226" [3]="237" [4]="82" [5]="65" [6]="75" [7]="22" [8]="54" [9]="129" [10]="115" [11]="65" [12]="75" [13]="16" [14]="37" [15]="315" [16]="51" [17]="129" [18]="37" [19]="357" [20]="142" [21]="115" [22]="150" [23]="154" [24]="0")
description="Finds a file above \`startingDirectory\`, uses \`testExpression\` to test (defaults to \`-d\`)"$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryParent"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/directory.sh"
sourceModified="1768756695"
summary="Finds a file above \`startingDirectory\`, uses \`testExpression\` to test (defaults"
usage="directoryParent startingDirectory --pattern filePattern [ --test testExpression ]"
