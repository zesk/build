#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"text - String. Required. Text to replace."$'\n'"replace - String. Optional. Replacement string for newlines."$'\n'""
base="text.sh"
description="Hide newlines in text (to ensure single-line output or other manipulation)"$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/text.sh"
fn="newlineHide"
foundNames=([0]="argument" [1]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768776345"
stdout="The text with the newline replaced with another character, suitable typically for single-line output"$'\n'""
summary="Hide newlines in text (to ensure single-line output or other"
usage="newlineHide [ --help ] text [ replace ]"
