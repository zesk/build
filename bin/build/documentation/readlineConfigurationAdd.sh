#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/readline.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"keyStroke - Required. String."$'\n'"action - Required. String."$'\n'""
base="readline.sh"
description="Add configuration to \`~/.inputrc\` for a key binding"$'\n'""
example="readlineConfigurationAdd \"\\ep\" history-search-backward"$'\n'""
file="bin/build/tools/readline.sh"
fn="readlineConfigurationAdd"
foundNames=([0]="argument" [1]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/readline.sh"
sourceModified="1768683751"
summary="Add configuration to \`~/.inputrc\` for a key binding"
usage="readlineConfigurationAdd [ --help ] keyStroke action"
