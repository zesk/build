#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/version.sh"
argument="--application application - Directory. Optional. Application home directory."$'\n'"version - String. Optional. Version for the release notes path. If not specified uses the current version."$'\n'""
base="version.sh"
description="Output path to current release notes"$'\n'""$'\n'"If this fails it outputs an error to stderr"$'\n'""$'\n'"When this tool succeeds it outputs the path to the current release notes file"$'\n'""$'\n'"shellcheck disable=SC2120"$'\n'""
environment="BUILD_RELEASE_NOTES"$'\n'""
example="    open \$(bin/build/release-notes.sh)"$'\n'"    vim \$(releaseNotes)"$'\n'""
file="bin/build/tools/version.sh"
fn="releaseNotes"
foundNames=([0]="summary" [1]="environment" [2]="argument" [3]="output" [4]="hook" [5]="example")
hook="version-current"$'\n'""
output="docs/release/version.md"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/version.sh"
sourceModified="1768721469"
summary="Output path to current release notes"$'\n'""
usage="releaseNotes [ --application application ] [ version ]"
