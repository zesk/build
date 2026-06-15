# shellcheck disable=SC2034
base="__BASH_PROMPT_SLOW.sh"
category="Bash Prompt"
default=$'300\n'
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Number of milliseconds after which a `bashPrompt` command is considered slow.\n\n'
descriptionLineCount="2"
env="__BASH_PROMPT_SLOW"
envMarker="__bash_prompt_slow"
file="bin/build/env/__BASH_PROMPT_SLOW.sh"
fn="__BASH_PROMPT_SLOW"
foundNames=([0]="name" [1]="summary" [2]="category" [3]="type" [4]="default" [5]="see")
name="Prompt command slow threshold"
rawComment=$'Name: Prompt command slow threshold\nSummary: Bash Prompt slow timer\nNumber of milliseconds after which a `bashPrompt` command is considered slow.\nCategory: Bash Prompt\nType: PositiveInteger\nDefault: 300\nSee: bashPrompt\n\n'
see=$'bashPrompt\n'
sourceFile="bin/build/env/__BASH_PROMPT_SLOW.sh"
sourceHash="08d10fbac4b107bbbfcfd503f375225b560bc425"
sourceLine=""
summary="Bash Prompt slow timer"
type="PositiveInteger"
