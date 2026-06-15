# shellcheck disable=SC2034
base="BUILD_DEBUG.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Constant for turning debugging on during build to find errors in the build scripts.\nEnable debugging globally in the build scripts. Set to a comma (`,`) delimited list string to enable specific debugging, or `true` for ALL debugging, `false` (or blank) for NO debugging.\n\n'
descriptionLineCount="3"
env="BUILD_DEBUG"
envMarker="build_debug"
file="bin/build/env/BUILD_DEBUG.sh"
fn="BUILD_DEBUG"
foundNames=([0]="name" [1]="category" [2]="type")
name="Debugging Flag"
rawComment=$'Name: Debugging Flag\nConstant for turning debugging on during build to find errors in the build scripts.\nEnable debugging globally in the build scripts. Set to a comma (`,`) delimited list string to enable specific debugging, or `true` for ALL debugging, `false` (or blank) for NO debugging.\nCategory: Build Configuration\nType: CommaDelimitedList\n\n'
sourceFile="bin/build/env/BUILD_DEBUG.sh"
sourceHash="c58298de250878f9df605144e490c57d3fc4c27e"
sourceLine=""
summary="Constant for turning debugging on during build to find errors"
summaryComputed="true"
type="CommaDelimitedList"
