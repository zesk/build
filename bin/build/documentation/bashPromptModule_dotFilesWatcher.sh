#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt-modules.sh"
argument="none"
base="prompt-modules.sh"
description="Watches your HOME directory for \`.\` files which are added and unknown to you."$'\n'""$'\n'""
example="    bashPrompt bashPromptModule_dotFilesWatcher"$'\n'""
file="bin/build/tools/prompt-modules.sh"
fn="bashPromptModule_dotFilesWatcher"
foundNames=([0]="example" [1]="requires")
requires="sort buildEnvironmentGetDirectory touch returnEnvironment read basename inArray decorate printf confirmYesNo statusMessage grep rm"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/prompt-modules.sh"
sourceModified="1768721469"
summary="Watches your HOME directory for \`.\` files which are added"
usage="bashPromptModule_dotFilesWatcher"
