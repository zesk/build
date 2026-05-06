#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"keyStroke - String. Required."$'\n'"action - String. Required."$'\n'""
base="readline.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Add configuration to \`~/.inputrc\` for a key binding"$'\n'""$'\n'""
descriptionLineCount="2"
example="readlineConfigurationAdd \"\\ep\" history-search-backward"$'\n'""
file="bin/build/tools/readline.sh"
fn="readlineConfigurationAdd"
fnMarker="readlineconfigurationadd"
foundNames=([0]="argument" [1]="example")
line="13"
rawComment="Add configuration to \`~/.inputrc\` for a key binding"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: keyStroke - String. Required."$'\n'"Argument: action - String. Required."$'\n'"Example: readlineConfigurationAdd \"\\ep\" history-search-backward"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/readline.sh"
sourceHash="ea9774938e79ec8413d673a5a0be7dc2a19eb038"
sourceLine="13"
summary="Add configuration to \`~/.inputrc\` for a key binding"
summaryComputed="true"
usage="readlineConfigurationAdd [ --help ] keyStroke action"
