# shellcheck disable=SC2034
base="__BASH_PROMPT_MODULES.sh"
BUILD_DEBUG="fingerprint-audit,handler,fast-usage"
category="Bash Prompt"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'List of modules to run each prompt command.\n\nManage with `bashPrompt functionName` to add, `bashPrompt --remove functionName` to remove.\n\nMake your functions *really* fast otherwise the shell becomes sluggish. Also try:\n\n    BUILD_DEBUG=bashPrompt\n\nTo report on each command and timing.\n\nAn automatic reporting occurs when commands exceed 0.3s.\n\n'
descriptionLineCount="12"
env="__BASH_PROMPT_MODULES"
envMarker="__bash_prompt_modules"
file="bin/build/env/__BASH_PROMPT_MODULES.sh"
fn="__BASH_PROMPT_MODULES"
foundNames=([0]="name" [1]="summary" [2]="category" [3]="type" [4]="see")
name="Prompt module list"
rawComment=$'Name: Prompt module list\nSummary: List of functions to run each prompt command\nList of modules to run each prompt command.\nManage with `bashPrompt functionName` to add, `bashPrompt --remove functionName` to remove.\nMake your functions *really* fast otherwise the shell becomes sluggish. Also try:\n    BUILD_DEBUG=bashPrompt\nTo report on each command and timing.\nAn automatic reporting occurs when commands exceed 0.3s.\nCategory: Bash Prompt\nType: Array:Callable\nSee: bashPrompt\n\n'
see=$'bashPrompt\n'
sourceFile="bin/build/env/__BASH_PROMPT_MODULES.sh"
sourceHash="037ef31431321b55e3a9f1e36da3ec90d3dceb0f"
sourceLine=""
summary="List of functions to run each prompt command"
type="Array:Callable"
