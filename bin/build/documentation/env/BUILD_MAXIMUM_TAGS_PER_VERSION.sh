# shellcheck disable=SC2034
base="BUILD_MAXIMUM_TAGS_PER_VERSION.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker")
description=$'Number of versions tags (d0, d1, d2, etc.) to look for before giving up in `gitTagVersion`\n\n'
descriptionLineCount="2"
env="BUILD_MAXIMUM_TAGS_PER_VERSION"
envMarker="build_maximum_tags_per_version"
file="bin/build/env/BUILD_MAXIMUM_TAGS_PER_VERSION.sh"
fn="BUILD_MAXIMUM_TAGS_PER_VERSION"
foundNames=([0]="type" [1]="category" [2]="see")
rawComment=$'Number of versions tags (d0, d1, d2, etc.) to look for before giving up in `gitTagVersion`\nType: PositiveInteger\nCategory: Build Configuration\nSee: gitTagVersion\n\n'
see=$'gitTagVersion\n'
sourceFile="bin/build/env/BUILD_MAXIMUM_TAGS_PER_VERSION.sh"
sourceHash="90faaf7ea59404cd5f1b4deca68721ae223f02bc"
sourceLine=""
summary="Number of versions tags (d0, d1, d2, etc.) to look"
summaryComputed="true"
type="PositiveInteger"
