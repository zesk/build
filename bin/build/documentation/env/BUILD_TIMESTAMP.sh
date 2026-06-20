# shellcheck disable=SC2034
base="BUILD_TIMESTAMP.sh"
category="Deployment"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Time when a build was initiated, set upon first invocation if not already\n\n'
descriptionLineCount="2"
env="BUILD_TIMESTAMP"
envMarker="build_timestamp"
file="bin/build/env/BUILD_TIMESTAMP.sh"
fn="BUILD_TIMESTAMP"
foundNames=([0]="name" [1]="category" [2]="type")
name="Build Timestamp"
original="BUILD_TIMESTAMP"
rawComment=$'Name: Build Timestamp\nTime when a build was initiated, set upon first invocation if not already\nCategory: Deployment\nType: UnsignedInteger\n\n'
sourceFile="bin/build/env/BUILD_TIMESTAMP.sh"
sourceHash="2d7e42b4134a87efee3ff8195f9fe45cba471c4a"
sourceLine=""
summary="Time when a build was initiated, set upon first invocation"
summaryComputed="true"
type="UnsignedInteger"
