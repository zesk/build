#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"value ... - Arguments. Optional. Array values as arguments."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Write an array value as NAME=([0]=\"a\" [1]=\"b\" [2]=\"c\")"$'\n'"Supports empty arrays"$'\n'"Bash outputs on different versions:"$'\n'""$'\n'"    declare -a foo='([0]=\"a'\\''s\" [1]=\"b\" [2]=\"c\")'"$'\n'"    declare -a foo=([0]=\"a's\" [1]=\"b\" [2]=\"c\")"$'\n'""$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentValueWriteArray"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768756695"
summary="Write an array value as NAME=([0]=\"a\" [1]=\"b\" [2]=\"c\")"
usage="environmentValueWriteArray [ --help ] [ value ... ] [ --help ]"
