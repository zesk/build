#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
argument="exitCode - Integer. Required. Exit code to return."$'\n'"item - Exists. Optional. One or more files or folders to delete, failures are logged to stderr."$'\n'""
base="_sugar.sh"
description="Delete files or directories and return the same exit code passed in."$'\n'""
fn="returnClean"
foundNames=([0]="argument" [1]="requires" [2]="group")
group="Sugar"$'\n'""
requires="isUnsignedInteger returnArgument throwEnvironment usageDocument throwArgument __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/_sugar.sh"
summary="Delete files or directories and return the same exit code"
usage="returnClean exitCode [ item ]"
