#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="exitCode - Integer. Required. Exit code to return."$'\n'"item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr."$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Delete files or directories and return the same exit code passed in."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="returnClean"
fnMarker="returnclean"
foundNames=([0]="argument" [1]="requires" [2]="group")
group="Sugar"$'\n'""
line="102"
rawComment="Delete files or directories and return the same exit code passed in."$'\n'"Argument: exitCode - Integer. Required. Exit code to return."$'\n'"Argument: item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr."$'\n'"Requires: isUnsignedInteger returnArgument throwEnvironment bashDocumentation throwArgument helpArgument"$'\n'"Group: Sugar"$'\n'""$'\n'""
requires="isUnsignedInteger returnArgument throwEnvironment bashDocumentation throwArgument helpArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="f483140af62e442b07342b869da4ea17b676a4e1"
sourceLine="102"
summary="Delete files or directories and return the same exit code"
summaryComputed="true"
usage="returnClean exitCode [ item ]"
