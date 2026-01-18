#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
description="Ensures blank lines are singular"$'\n'"Used often to clean up markdown \`.md\` files, but can be used for any line-based configuration file which allows blank lines."$'\n'""$'\n'""
file="bin/build/tools/text.sh"
fn="singleBlankLines"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768721469"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs modified lines where any blank lines are replaced with a single blank line."$'\n'""
summary="Ensures blank lines are singular"
usage="singleBlankLines [ --help ]"
