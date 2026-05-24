# shellcheck disable=SC2034
base="BUILD_DEBUG_LINES.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker")
description=$'Number of lines of debugging output to send to stderr before stopping\n\n'
descriptionLineCount="2"
env="BUILD_DEBUG_LINES"
envMarker="build_debug_lines"
file="bin/build/env/BUILD_DEBUG_LINES.sh"
fn="BUILD_DEBUG_LINES"
foundNames=([0]="category" [1]="type")
rawComment=$'Number of lines of debugging output to send to stderr before stopping\nCategory: Build Configuration\nType: PositiveInteger\n\n'
sourceFile="bin/build/env/BUILD_DEBUG_LINES.sh"
sourceHash="5285b56565e1d34e80e22c3ff2e1decdb0a0dd87"
sourceLine=""
summary="Number of lines of debugging output to send to stderr"
summaryComputed="true"
type="PositiveInteger"
