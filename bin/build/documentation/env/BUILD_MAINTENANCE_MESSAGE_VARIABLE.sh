# shellcheck disable=SC2034
base="BUILD_MAINTENANCE_MESSAGE_VARIABLE.sh"
category="Application"
derivations=([0]="env" [1]="envMarker" [2]="name")
description="Name of the environment variable (if any) which reflects the current maintenance message."$'\n'"Default is \`MAINTENANCE_MESSAGE\` and this is typically added to the \`.env.local\` to a live"$'\n'"application. Your application should monitor these files for changes if they are cached and reload as needed to ensure"$'\n'"these messages are displayed immediately."$'\n'""$'\n'""
descriptionLineCount="5"
env="BUILD_MAINTENANCE_MESSAGE_VARIABLE"
envMarker="build_maintenance_message_variable"
file="bin/build/env/BUILD_MAINTENANCE_MESSAGE_VARIABLE.sh"
fn="BUILD_MAINTENANCE_MESSAGE_VARIABLE"
foundNames=([0]="name" [1]="category" [2]="type")
name="Maintenance Variable Message Name"
rawComment="Name: Maintenance Variable Message Name"$'\n'"Category: Application"$'\n'"Name of the environment variable (if any) which reflects the current maintenance message."$'\n'"Default is \`MAINTENANCE_MESSAGE\` and this is typically added to the \`.env.local\` to a live"$'\n'"application. Your application should monitor these files for changes if they are cached and reload as needed to ensure"$'\n'"these messages are displayed immediately."$'\n'"Type: EnvironmentVariable"$'\n'""$'\n'""
sourceFile="bin/build/env/BUILD_MAINTENANCE_MESSAGE_VARIABLE.sh"
sourceHash="6c18a3c0082524e8bf201d4bbd30658fc48782b8"
sourceLine=""
summary="Name of the environment variable (if any) which reflects the"
summaryComputed="true"
type="EnvironmentVariable"
