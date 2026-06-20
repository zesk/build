# shellcheck disable=SC2034
base="BUILD_PROJECT_DEACTIVATE.sh"
category="Application"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Set this to a function which cleans up the project context and\nwill be run on `project-deactivate` hook which is sourced.\n\n'
descriptionLineCount="3"
env="BUILD_PROJECT_DEACTIVATE"
envMarker="build_project_deactivate"
file="bin/build/env/BUILD_PROJECT_DEACTIVATE.sh"
fn="BUILD_PROJECT_DEACTIVATE"
foundNames=([0]="name" [1]="type" [2]="category")
name="Project Deactivation Function"
original="BUILD_PROJECT_DEACTIVATE"
rawComment=$'Name: Project Deactivation Function\nType: Function\nCategory: Application\nSet this to a function which cleans up the project context and\nwill be run on `project-deactivate` hook which is sourced.\n\n'
sourceFile="bin/build/env/BUILD_PROJECT_DEACTIVATE.sh"
sourceHash="2e661e4b8fbe3b1fe00de662443f905547c4e4ad"
sourceLine=""
summary="Set this to a function which cleans up the project"
summaryComputed="true"
type="Function"
