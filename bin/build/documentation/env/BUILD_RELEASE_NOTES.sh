# shellcheck disable=SC2034
base="BUILD_RELEASE_NOTES.sh"
category="Build Configuration"
default=$'./docs/release\n'
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Constant for the release notes path. Defaults to `./docs/release`.\n\n'
descriptionLineCount="2"
env="BUILD_RELEASE_NOTES"
envMarker="build_release_notes"
file="bin/build/env/BUILD_RELEASE_NOTES.sh"
fn="BUILD_RELEASE_NOTES"
foundNames=([0]="name" [1]="category" [2]="default" [3]="type")
name="Release Notes Application Path"
original="BUILD_RELEASE_NOTES"
rawComment=$'Name: Release Notes Application Path\nConstant for the release notes path. Defaults to `./docs/release`.\nCategory: Build Configuration\nDefault: ./docs/release\nType: ApplicationDirectory\n\n'
sourceFile="bin/build/env/BUILD_RELEASE_NOTES.sh"
sourceHash="1f1650298b1bcd6f16a09bdbb3ba8cf6754ea0e5"
sourceLine=""
summary="Constant for the release notes path. Defaults to \`./docs/release\`."
summaryComputed="true"
type="ApplicationDirectory"
