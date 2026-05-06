#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="startingDirectory - Required. EmptyString|RealDirectory. Uses the current directory if blank."$'\n'"--pattern filePattern - RelativePath. Required. The file or directory to find the home for."$'\n'"--test testExpression - String. Optional. Zero or more. The \`test\` argument to test the targeted \`filePattern\`. By default uses \`-d\`."$'\n'""
base="directory.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Finds a file above \`startingDirectory\`, uses \`testExpression\` to test (defaults to \`-d\`)"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/directory.sh"
fn="directoryParent"
fnMarker="directoryparent"
foundNames=([0]="argument")
line="314"
rawComment="Finds a file above \`startingDirectory\`, uses \`testExpression\` to test (defaults to \`-d\`)"$'\n'"Argument: startingDirectory - Required. EmptyString|RealDirectory. Uses the current directory if blank."$'\n'"Argument: --pattern filePattern - RelativePath. Required. The file or directory to find the home for."$'\n'"Argument: --test testExpression - String. Optional. Zero or more. The \`test\` argument to test the targeted \`filePattern\`. By default uses \`-d\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="da838a55948477df4605f58aff4c29b4f13319f7"
sourceLine="314"
summary="Finds a file above \`startingDirectory\`, uses \`testExpression\` to test (defaults"
summaryComputed="true"
usage="directoryParent startingDirectory --pattern filePattern [ --test testExpression ]"
