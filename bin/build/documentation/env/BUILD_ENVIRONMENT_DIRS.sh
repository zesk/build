# shellcheck disable=SC2034
base="BUILD_ENVIRONMENT_DIRS.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker" [2]="name")
description="Search directory for environment definition files. \`:\` separated."$'\n'"Note these should be *in addition* to the default environment variables ALWAYS located at \`./bin/build/env\`"$'\n'"THe default is \`\$(buildHome)/bin/env\`. Make sure to append to this as a \`:\`-list."$'\n'""$'\n'""
descriptionLineCount="4"
env="BUILD_ENVIRONMENT_DIRS"
envMarker="build_environment_dirs"
file="bin/build/env/BUILD_ENVIRONMENT_DIRS.sh"
fn="BUILD_ENVIRONMENT_DIRS"
foundNames=([0]="name" [1]="type" [2]="category")
name="Build Environment Directory List"
rawComment="Name: Build Environment Directory List"$'\n'"Search directory for environment definition files. \`:\` separated."$'\n'"Note these should be *in addition* to the default environment variables ALWAYS located at \`./bin/build/env\`"$'\n'"THe default is \`\$(buildHome)/bin/env\`. Make sure to append to this as a \`:\`-list."$'\n'"Type: DirectoryList"$'\n'"Category: Build Configuration"$'\n'""$'\n'""
sourceFile="bin/build/env/BUILD_ENVIRONMENT_DIRS.sh"
sourceHash="4c2180379fa1da3f6b98fbf16e2336c9924a7046"
sourceLine=""
summary="Search directory for environment definition files. \`:\` separated."
summaryComputed="true"
type="DirectoryList"
