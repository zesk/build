# shellcheck disable=SC2034
base="BUILD_HOOK_DIRS.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker" [2]="name")
description="List of directories to search for hooks. Defaults to \`bin/hooks:bin/build/hooks\`."$'\n'"Colon (\`:\`) separated list."$'\n'""$'\n'""
descriptionLineCount="3"
env="BUILD_HOOK_DIRS"
envMarker="build_hook_dirs"
file="bin/build/env/BUILD_HOOK_DIRS.sh"
fn="BUILD_HOOK_DIRS"
foundNames=([0]="name" [1]="category" [2]="type")
name="Build Hook Directory List"
rawComment="Name: Build Hook Directory List"$'\n'"List of directories to search for hooks. Defaults to \`bin/hooks:bin/build/hooks\`."$'\n'"Colon (\`:\`) separated list."$'\n'"Category: Build Configuration"$'\n'"Type: ApplicationDirectoryList"$'\n'""$'\n'""
sourceFile="bin/build/env/BUILD_HOOK_DIRS.sh"
sourceHash="de13618c4bdd94e1382f7c96b14787c50052c7b2"
sourceLine=""
summary="List of directories to search for hooks. Defaults to \`bin/hooks:bin/build/hooks\`."
summaryComputed="true"
type="ApplicationDirectoryList"
