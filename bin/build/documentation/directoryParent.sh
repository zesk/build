#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="startingDirectory - Required. EmptyString|RealDirectory. Uses the current directory if blank."$'\n'"--pattern filePattern -  RelativePath. Required. The file or directory to find the home for."$'\n'"--test testExpression - String. Optional. Zero or more. The \`test\` argument to test the targeted \`filePattern\`. By default uses \`-d\`."$'\n'""
base="directory.sh"
description="Finds a file above \`startingDirectory\`, uses \`testExpression\` to test (defaults to \`-d\`)"$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryParent"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/directory.sh"
sourceModified="1768683853"
summary="Finds a file above \`startingDirectory\`, uses \`testExpression\` to test (defaults"
usage="directoryParent startingDirectory --pattern filePattern [ --test testExpression ]"
