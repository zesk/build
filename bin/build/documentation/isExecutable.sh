#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/type.sh"
argument="string ... - String. Required. Path to binary to test if it is executable."$'\n'""
base="type.sh"
description="Test if all arguments are executable binaries"$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - All arguments are executable binaries"$'\n'"Return Code: 1 - One or or more arguments are not executable binaries"$'\n'""
file="bin/build/tools/type.sh"
fn="isExecutable"
foundNames=([0]="argument" [1]="requires")
requires="throwArgument  __help catchEnvironment command"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/type.sh"
sourceModified="1768695708"
summary="Test if all arguments are executable binaries"
usage="isExecutable string ..."
