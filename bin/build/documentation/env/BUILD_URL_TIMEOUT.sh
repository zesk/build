# shellcheck disable=SC2034
base="BUILD_URL_TIMEOUT.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Timeout in seconds for fetching URLs in `urlFetch`\n\n'
descriptionLineCount="2"
env="BUILD_URL_TIMEOUT"
envMarker="build_url_timeout"
file="bin/build/env/BUILD_URL_TIMEOUT.sh"
fn="BUILD_URL_TIMEOUT"
foundNames=([0]="name" [1]="see" [2]="category" [3]="type")
name="URL Timeout"
rawComment=$'Name: URL Timeout\nTimeout in seconds for fetching URLs in `urlFetch`\nSee: urlFetch\nCategory: Build Configuration\nType: PositiveInteger\n\n'
see=$'urlFetch\n'
sourceFile="bin/build/env/BUILD_URL_TIMEOUT.sh"
sourceHash="9609bf21590355cfdac166c2aabb6366dfd0ff70"
sourceLine=""
summary="Timeout in seconds for fetching URLs in \`urlFetch\`"
summaryComputed="true"
type="PositiveInteger"
