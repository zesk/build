# shellcheck disable=SC2034
base="BUILD_MAINTENANCE_CREATED_FILE.sh"
category="Application"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'When true, means the `.env.local` file was created by the maintenance hook and should be deleted when maintenance is\nno longer enabled.\n\n'
descriptionLineCount="3"
env="BUILD_MAINTENANCE_CREATED_FILE"
envMarker="build_maintenance_created_file"
file="bin/build/env/BUILD_MAINTENANCE_CREATED_FILE.sh"
fn="BUILD_MAINTENANCE_CREATED_FILE"
foundNames=([0]="name" [1]="category" [2]="type")
name="Maintenance Created Flag"
original="BUILD_MAINTENANCE_CREATED_FILE"
rawComment=$'Name: Maintenance Created Flag\nCategory: Application\nWhen true, means the `.env.local` file was created by the maintenance hook and should be deleted when maintenance is\nno longer enabled.\nType: Boolean\n\n'
sourceFile="bin/build/env/BUILD_MAINTENANCE_CREATED_FILE.sh"
sourceHash="194e7cca72dcbdd49a1fde63a8247f2123d20dfa"
sourceLine=""
summary="When true, means the \`.env.local\` file was created by the"
summaryComputed="true"
type="Boolean"
