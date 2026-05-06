#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="prompt-modules.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Watches your HOME directory for \`.\` files which are added and unknown to you."$'\n'""$'\n'""
descriptionLineCount="2"
example="    bashPrompt bashPromptModule_dotFilesWatcher"$'\n'""
file="bin/build/tools/prompt-modules.sh"
fn="bashPromptModule_dotFilesWatcher"
fnMarker="bashpromptmodule_dotfileswatcher"
foundNames=([0]="example" [1]="requires")
line="94"
rawComment="Watches your HOME directory for \`.\` files which are added and unknown to you."$'\n'"Example:     bashPrompt bashPromptModule_dotFilesWatcher"$'\n'"Requires: sort buildEnvironmentGetDirectory touch returnEnvironment read basename inArray decorate printf confirmYesNo statusMessage grep rm"$'\n'""$'\n'""
requires="sort buildEnvironmentGetDirectory touch returnEnvironment read basename inArray decorate printf confirmYesNo statusMessage grep rm"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt-modules.sh"
sourceHash="88deb9ee5685724c1450f2249c6ebd6a9df5a223"
sourceLine="94"
summary="Watches your HOME directory for \`.\` files which are added"
summaryComputed="true"
usage="bashPromptModule_dotFilesWatcher"
