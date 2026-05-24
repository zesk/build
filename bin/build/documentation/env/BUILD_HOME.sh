# shellcheck disable=SC2034
base="BUILD_HOME.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker")
description=$'`BUILD_HOME` is `.` when this code is installed - at `./bin/build`. Usually an absolute path and does NOT end with a trailing slash.\nThis is computed from the current source file using `${BASH_SOURCE[0]}`.\n\n'
descriptionLineCount="3"
env="BUILD_HOME"
envMarker="build_home"
file="bin/build/env/BUILD_HOME.sh"
fn="BUILD_HOME"
foundNames=([0]="category" [1]="type")
rawComment=$'`BUILD_HOME` is `.` when this code is installed - at `./bin/build`. Usually an absolute path and does NOT end with a trailing slash.\nThis is computed from the current source file using `${BASH_SOURCE[0]}`.\nCategory: Build Configuration\nType: Directory\n\n'
sourceFile="bin/build/env/BUILD_HOME.sh"
sourceHash="7bd511aaff21c7e361c5cd50fc852d316f46479d"
sourceLine=""
summary="\`BUILD_HOME\` is \`.\` when this code is installed - at"
summaryComputed="true"
type="Directory"
