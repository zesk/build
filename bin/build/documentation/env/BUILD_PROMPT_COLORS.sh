# shellcheck disable=SC2034
base="BUILD_PROMPT_COLORS.sh"
category="Decoration"
derivations=([0]="env" [1]="envMarker")
description=$'Colon-separated list of colors for the prompt\n\nColors are escape codes. Last entry is a reset simply to make environment output less messy.\n\n1. Success color\n2. Failure color\n3. User\n4. Host\n5. Path\n\n'
descriptionLineCount="10"
env="BUILD_PROMPT_COLORS"
envMarker="build_prompt_colors"
file="bin/build/env/BUILD_PROMPT_COLORS.sh"
fn="BUILD_PROMPT_COLORS"
format=$'colon-separated-list\n'
foundNames=([0]="format" [1]="category" [2]="see" [3]="type")
rawComment=$'Colon-separated list of colors for the prompt\nFormat: colon-separated-list\nColors are escape codes. Last entry is a reset simply to make environment output less messy.\n1. Success color\n2. Failure color\n3. User\n4. Host\n5. Path\nCategory: Decoration\nSee: bashPrompt\nType: ColonDelimitedList\n\n'
see=$'bashPrompt\n'
sourceFile="bin/build/env/BUILD_PROMPT_COLORS.sh"
sourceHash="f6ced5f12929f8bbe18ab2f315d8d37f7f85389e"
sourceLine=""
summary="Colon-separated list of colors for the prompt"
summaryComputed="true"
type="ColonDelimitedList"
