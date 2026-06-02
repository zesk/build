# shellcheck disable=SC2034
base="BUILD_COMPOSER_VERSION.sh"
category="Installation"
default=$'latest\n'
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Version of composer to use for building vendor directory\n\n'
descriptionLineCount="2"
env="BUILD_COMPOSER_VERSION"
envMarker="build_composer_version"
file="bin/build/env/BUILD_COMPOSER_VERSION.sh"
fn="BUILD_COMPOSER_VERSION"
foundNames=([0]="name" [1]="type" [2]="default" [3]="see" [4]="category")
name="Composer Version"
rawComment=$'Name: Composer Version\nVersion of composer to use for building vendor directory\nType: String\nDefault: latest\nSee: phpComposer\nCategory: Installation\n\n'
see=$'phpComposer\n'
sourceFile="bin/build/env/BUILD_COMPOSER_VERSION.sh"
sourceHash="77828ef6e30352b86fcb5eeaca919eedf7e878a1"
sourceLine=""
summary="Version of composer to use for building vendor directory"
summaryComputed="true"
type="String"
