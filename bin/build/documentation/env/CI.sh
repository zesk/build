# shellcheck disable=SC2034
base="CI.sh"
category="Continuous Integration"
derivations=([0]="env" [1]="envMarker")
description=$'If this value is non-blank, then console `statusMessage`s are just output normally.\nContinuous Integration - this is set to a non-blank value in:\n\n- Bitbucket pipelines\n\n'
descriptionLineCount="5"
env="CI"
envMarker="ci"
file="bin/build/env/CI.sh"
fn="CI"
foundNames=([0]="see" [1]="category" [2]="type")
rawComment=$'If this value is non-blank, then console `statusMessage`s are just output normally.\nSee: statusMessage\nSee: consoleHasAnimation\nContinuous Integration - this is set to a non-blank value in:\n- Bitbucket pipelines\nCategory: Continuous Integration\nType: String\n\n'
see=$'statusMessage\nconsoleHasAnimation\n'
sourceFile="bin/build/env/CI.sh"
sourceHash="2117ac5b1d17505fc263de3c9fc969f7229ce099"
sourceLine=""
summary="If this value is non-blank, then console \`statusMessage\`s are just"
summaryComputed="true"
type="String"
