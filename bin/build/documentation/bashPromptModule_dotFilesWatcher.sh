#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="none"
base="prompt-modules.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Watches your HOME directory for `.` files which are added and unknown to you.\n\n'
descriptionLineCount="2"
example=$'    bashPrompt bashPromptModule_dotFilesWatcher\n'
file="bin/build/tools/prompt-modules.sh"
fn="bashPromptModule_dotFilesWatcher"
fnMarker="bashpromptmodule_dotfileswatcher"
foundNames=([0]="summary" [1]="example" [2]="requires")
line="95"
rawComment=$'Summary: Monitor home directory for new `.` files\nWatches your HOME directory for `.` files which are added and unknown to you.\nExample:     bashPrompt bashPromptModule_dotFilesWatcher\nRequires: sort buildEnvironmentGetDirectory touch returnEnvironment read basename inArray decorate printf confirmYesNo statusMessage grep rm\n\n'
requires=$'sort buildEnvironmentGetDirectory touch returnEnvironment read basename inArray decorate printf confirmYesNo statusMessage grep rm\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/prompt-modules.sh"
sourceHash="2bee64ea201a03444ec1e39db3efb63042869b7e"
sourceLine="95"
summary="Monitor home directory for new \`.\` files"
summaryComputed=""
usage="bashPromptModule_dotFilesWatcher"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashPromptModule_dotFilesWatcher'$'\e''[0m'$'\n'''$'\n''Watches your HOME directory for '$'\e''[[(code)]m.'$'\e''[[(reset)]m files which are added and unknown to you.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    bashPrompt bashPromptModule_dotFilesWatcher'
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptModule_dotFilesWatcher'$'\n'''$'\n''Watches your HOME directory for . files which are added and unknown to you.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    bashPrompt bashPromptModule_dotFilesWatcher'
documentationPath="documentation/source/tools/prompt.md"
