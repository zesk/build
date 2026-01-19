#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/type.sh"
argument="string - Required. String to test if it is a bash function. Builtins are supported. \`.\` is explicitly not supported to disambiguate it from the current directory \`.\`."$'\n'""
base="type.sh"
description="Test if argument are bash functions"$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - argument is bash function"$'\n'"Return Code: 1 - argument is not a bash function"$'\n'""
file="bin/build/tools/type.sh"
fn="isFunction"
foundNames=([0]="argument" [1]="requires")
requires="catchArgument isUnsignedInteger usageDocument type"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/type.sh"
summary="Test if argument are bash functions"
usage="isFunction string"
