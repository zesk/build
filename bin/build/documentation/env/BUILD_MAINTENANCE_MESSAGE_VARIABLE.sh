# shellcheck disable=SC2034
base="BUILD_MAINTENANCE_MESSAGE_VARIABLE.sh"
category="Application"
derivations=([0]="env" [1]="envMarker")
description=$'Name of the environment variable (if any) which reflects the current maintenance message.\nDefault is `MAINTENANCE_MESSAGE` and this is typically added to the `.env.local` to a live\napplication. Your application should monitor these files for changes if they are cached and reload as needed to ensure\nthese messages are displayed immediately.\n\n'
descriptionLineCount="5"
env="BUILD_MAINTENANCE_MESSAGE_VARIABLE"
envMarker="build_maintenance_message_variable"
file="bin/build/env/BUILD_MAINTENANCE_MESSAGE_VARIABLE.sh"
fn="BUILD_MAINTENANCE_MESSAGE_VARIABLE"
foundNames=([0]="category" [1]="type")
rawComment=$'Category: Application\nName of the environment variable (if any) which reflects the current maintenance message.\nDefault is `MAINTENANCE_MESSAGE` and this is typically added to the `.env.local` to a live\napplication. Your application should monitor these files for changes if they are cached and reload as needed to ensure\nthese messages are displayed immediately.\nType: EnvironmentVariable\n\n'
sourceFile="bin/build/env/BUILD_MAINTENANCE_MESSAGE_VARIABLE.sh"
sourceHash="6c18a3c0082524e8bf201d4bbd30658fc48782b8"
sourceLine=""
summary="Name of the environment variable (if any) which reflects the"
summaryComputed="true"
type="EnvironmentVariable"
