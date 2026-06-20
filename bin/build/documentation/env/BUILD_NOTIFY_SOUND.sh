# shellcheck disable=SC2034
base="BUILD_NOTIFY_SOUND.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Sound for notifications. Set to `-` for no sound. Defaults to `zesk-build-notification`.\n\n'
descriptionLineCount="2"
env="BUILD_NOTIFY_SOUND"
envMarker="build_notify_sound"
file="bin/build/env/BUILD_NOTIFY_SOUND.sh"
fn="BUILD_NOTIFY_SOUND"
foundNames=([0]="name" [1]="see" [2]="type" [3]="category")
name="Notification Sound"
original="BUILD_NOTIFY_SOUND"
rawComment=$'Name: Notification Sound\nSound for notifications. Set to `-` for no sound. Defaults to `zesk-build-notification`.\nSee: darwinNotification\nType: String\nCategory: Build Configuration\n\n'
see=$'darwinNotification\n'
sourceFile="bin/build/env/BUILD_NOTIFY_SOUND.sh"
sourceHash="1090cc489d8ae8e58278d123e6daf7f76ab743b8"
sourceLine=""
summary="Sound for notifications. Set to \`-\` for no sound. Defaults"
summaryComputed="true"
type="String"
