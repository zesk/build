#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="string - EmptyString. Required. Path to binary to test if it is executable."$'\n'""
base="type.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Test if all arguments are callable as a command"$'\n'"If no arguments are passed, returns exit code 1."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/type.sh"
fn="isCallable"
fnMarker="iscallable"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="199"
rawComment="Test if all arguments are callable as a command"$'\n'"Argument: string - EmptyString. Required. Path to binary to test if it is executable."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - All arguments are callable as a command"$'\n'"Return Code: 1 - One or or more arguments are callable as a command"$'\n'"Requires: throwArgument helpArgument isExecutable isFunction"$'\n'""$'\n'""
requires="throwArgument helpArgument isExecutable isFunction"$'\n'""
return_code="0 - All arguments are callable as a command"$'\n'"1 - One or or more arguments are callable as a command"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="3df0d84917e775e2aba0d9280d56eb8d73b4a8c3"
sourceLine="199"
summary="Test if all arguments are callable as a command"
summaryComputed="true"
usage="isCallable string"
