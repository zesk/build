#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="none"
base="prompt-modules.sh"
description="Watches your HOME directory for \`.\` files which are added and unknown to you."$'\n'""
example="    bashPrompt bashPromptModule_dotFilesWatcher"$'\n'""
file="bin/build/tools/prompt-modules.sh"
fn="bashPromptModule_dotFilesWatcher"
foundNames=([0]="example" [1]="requires")
line="94"
lowerFn="bashpromptmodule_dotfileswatcher"
rawComment="Watches your HOME directory for \`.\` files which are added and unknown to you."$'\n'"Example:     bashPrompt bashPromptModule_dotFilesWatcher"$'\n'"Requires: sort buildEnvironmentGetDirectory touch returnEnvironment read basename inArray decorate printf confirmYesNo statusMessage grep rm"$'\n'""$'\n'""
requires="sort buildEnvironmentGetDirectory touch returnEnvironment read basename inArray decorate printf confirmYesNo statusMessage grep rm"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt-modules.sh"
sourceHash="63eede76c5295636fbb5072c5ff56c4dea30564b"
sourceLine="94"
summary="Watches your HOME directory for \`.\` files which are added"
summaryComputed="true"
usage="bashPromptModule_dotFilesWatcher"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashPromptModule_dotFilesWatcher'$'\e''[0m'$'\n'''$'\n''Watches your HOME directory for '$'\e''[[(code)]m.'$'\e''[[(reset)]m files which are added and unknown to you.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    bashPrompt bashPromptModule_dotFilesWatcher'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptModule_dotFilesWatcher'$'\n'''$'\n''Watches your HOME directory for . files which are added and unknown to you.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    bashPrompt bashPromptModule_dotFilesWatcher'$'\n'''
documentationPath="documentation/source/tools/prompt.md"
