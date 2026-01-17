#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="None."$'\n'""
base="text.sh"
credits="commandlinefu tripleee"$'\n'""
depends="sed"$'\n'""
description="Strip ANSI console escape sequences from a file"$'\n'"Write Environment: None."$'\n'"Short description: Remove ANSI escape codes from streams"$'\n'""
environment="None."$'\n'""
file="bin/build/tools/text.sh"
fn="stripAnsi"
foundNames=([0]="argument" [1]="environment" [2]="credits" [3]="source" [4]="depends" [5]="stdin" [6]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768686587"
stdin="arbitrary text which may contain ANSI escape sequences for the terminal"$'\n'""
stdout="the same text with those ANSI escape sequences removed"$'\n'""
summary="Strip ANSI console escape sequences from a file"
usage="stripAnsi [ None. ]"
