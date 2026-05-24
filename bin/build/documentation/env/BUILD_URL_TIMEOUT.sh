# shellcheck disable=SC2034
base="BUILD_URL_TIMEOUT.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker")
description=$'Timeout in seconds for fetching URLs in `urlFetch`\n\n'
descriptionLineCount="2"
env="BUILD_URL_TIMEOUT"
envMarker="build_url_timeout"
file="bin/build/env/BUILD_URL_TIMEOUT.sh"
fn="BUILD_URL_TIMEOUT"
foundNames=([0]="see" [1]="category" [2]="type")
rawComment=$'Timeout in seconds for fetching URLs in `urlFetch`\nSee: urlFetch\nCategory: Build Configuration\nType: PositiveInteger\n\n'
see=$'urlFetch\n'
sourceFile="bin/build/env/BUILD_URL_TIMEOUT.sh"
sourceHash="9609bf21590355cfdac166c2aabb6366dfd0ff70"
sourceLine=""
summary="Timeout in seconds for fetching URLs in \`urlFetch\`"
summaryComputed="true"
type="PositiveInteger"
