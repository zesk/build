#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'exitCode - Integer. Required. Exit code to return.\nitem - Exists. Optional. One or more files or folders to delete, failures are logged to stderr.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Delete files or directories and return the same exit code passed in.\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="returnClean"
fnMarker="returnclean"
foundNames=([0]="argument" [1]="requires" [2]="group")
group=$'Sugar\n'
line="101"
rawComment=$'Delete files or directories and return the same exit code passed in.\nArgument: exitCode - Integer. Required. Exit code to return.\nArgument: item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr.\nRequires: isUnsignedInteger returnArgument throwEnvironment bashDocumentation throwArgument helpArgument\nGroup: Sugar\n\n'
requires=$'isUnsignedInteger returnArgument throwEnvironment bashDocumentation throwArgument helpArgument\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="101"
summary="Delete files or directories and return the same exit code"
summaryComputed="true"
usage="returnClean exitCode [ item ]"
