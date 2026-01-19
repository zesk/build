#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
argument="code ... - UnsignedInteger. String. Exit code value to output."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="_sugar.sh"
description="Output the exit code as a string"$'\n'""$'\n'""
fn="returnCodeString"
foundNames=([0]="argument" [1]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/_sugar.sh"
stdout="exitCodeToken, one per line"$'\n'""
summary="Output the exit code as a string"
usage="returnCodeString [ code ... ] [ --help ]"
