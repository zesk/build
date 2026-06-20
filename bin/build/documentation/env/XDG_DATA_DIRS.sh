# shellcheck disable=SC2034
base="XDG_DATA_DIRS.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Search directory for user-specific data files to be stored. `:` separated.\nSee [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.\n\n'
descriptionLineCount="3"
env="XDG_DATA_DIRS"
envMarker="xdg_data_dirs"
file="bin/build/env/XDG_DATA_DIRS.sh"
fn="XDG_DATA_DIRS"
foundNames=([0]="name" [1]="summary" [2]="type" [3]="category")
name="Data Path Directories"
original="XDG_DATA_DIRS"
rawComment=$'Name: Data Path Directories\nSummary: Data Path Directories\nSearch directory for user-specific data files to be stored. `:` separated.\nType: DirectoryList\nCategory: Build Configuration\nSee [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.\n\n'
sourceFile="bin/build/env/XDG_DATA_DIRS.sh"
sourceHash="5696c6dd156a2c4b55a1e3e9463a0f6c498c234e"
sourceLine=""
summary="Data Path Directories"
type="DirectoryList"
