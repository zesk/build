# shellcheck disable=SC2034
base="BUILD_CACHE_HOME.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Location for the build system cache files. Defaults to `$HOME/.build` and if `$HOME` is not a directory then `$(buildHome)/.build`\nCache MAY be deleted at any time. If you need your files to be preserved, store them elsewhere.\n\n'
descriptionLineCount="3"
env="BUILD_CACHE_HOME"
envMarker="build_cache_home"
file="bin/build/env/BUILD_CACHE_HOME.sh"
fn="BUILD_CACHE_HOME"
foundNames=([0]="name" [1]="category" [2]="type")
name="Build Cache Directory"
original="BUILD_CACHE_HOME"
rawComment=$'Name: Build Cache Directory\nLocation for the build system cache files. Defaults to `$HOME/.build` and if `$HOME` is not a directory then `$(buildHome)/.build`\nCache MAY be deleted at any time. If you need your files to be preserved, store them elsewhere.\nCategory: Build Configuration\nType: Directory\n\n'
sourceFile="bin/build/env/BUILD_CACHE_HOME.sh"
sourceHash="1c9526d7026c3def628aa861751473f9ecd87358"
sourceLine=""
summary="Location for the build system cache files. Defaults to \`\$HOME/.build\`"
summaryComputed="true"
type="Directory"
