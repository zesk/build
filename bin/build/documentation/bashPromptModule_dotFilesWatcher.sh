#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="none"
base="prompt-modules.sh"
description="Watches your HOME directory for \`.\` files which are added and unknown to you."$'\n'""
example="    bashPrompt bashPromptModule_dotFilesWatcher"$'\n'""
file="bin/build/tools/prompt-modules.sh"
fn="bashPromptModule_dotFilesWatcher"
foundNames=([0]="example" [1]="requires")
rawComment="Watches your HOME directory for \`.\` files which are added and unknown to you."$'\n'"Example:     bashPrompt bashPromptModule_dotFilesWatcher"$'\n'"Requires: sort buildEnvironmentGetDirectory touch returnEnvironment read basename inArray decorate printf confirmYesNo statusMessage grep rm"$'\n'""$'\n'""
requires="sort buildEnvironmentGetDirectory touch returnEnvironment read basename inArray decorate printf confirmYesNo statusMessage grep rm"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt-modules.sh"
sourceHash="70c950e31baf7d3e42320e431154d468f2889b6a"
summary="Watches your HOME directory for \`.\` files which are added"
summaryComputed="true"
usage="bashPromptModule_dotFilesWatcher"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
