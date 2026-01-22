#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt-modules.sh"
argument="none"
base="prompt-modules.sh"
description="Watches your HOME directory for \`.\` files which are added and unknown to you."$'\n'""$'\n'""
example="    bashPrompt bashPromptModule_dotFilesWatcher"$'\n'""
file="bin/build/tools/prompt-modules.sh"
fn="bashPromptModule_dotFilesWatcher"
foundNames=""
requires="sort buildEnvironmentGetDirectory touch returnEnvironment read basename inArray decorate printf confirmYesNo statusMessage grep rm"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt-modules.sh"
sourceModified="1768721469"
summary="Watches your HOME directory for \`.\` files which are added"
usage="bashPromptModule_dotFilesWatcher"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashPromptModule_dotFilesWatcher[0m

Watches your HOME directory for [38;2;0;255;0;48;2;0;0;0m.[0m files which are added and unknown to you.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    bashPrompt bashPromptModule_dotFilesWatcher
'
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptModule_dotFilesWatcher

Watches your HOME directory for . files which are added and unknown to you.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    bashPrompt bashPromptModule_dotFilesWatcher
'
