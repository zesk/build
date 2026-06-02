# shellcheck disable=SC2034
base="XDG_STATE_HOME.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Base directory for user-specific state files to be stored\nSee [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.\n\n'
descriptionLineCount="3"
env="XDG_STATE_HOME"
envMarker="xdg_state_home"
file="bin/build/env/XDG_STATE_HOME.sh"
fn="XDG_STATE_HOME"
foundNames=([0]="name" [1]="summary" [2]="category" [3]="type")
name="State Home Directory"
rawComment=$'Name: State Home Directory\nSummary: State Home Directory\nBase directory for user-specific state files to be stored\nCategory: Build Configuration\nSee [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.\nType: Directory\n\n'
sourceFile="bin/build/env/XDG_STATE_HOME.sh"
sourceHash="747a95f570e9d968bba7ef2b87619b2ad8a6c00d"
sourceLine=""
summary="State Home Directory"
type="Directory"
