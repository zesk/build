#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--application application - Directory. Optional. Application home directory."$'\n'"version - String. Optional. Version for the release notes path. If not specified uses the current version."$'\n'""
base="version.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output path to current release notes"$'\n'""$'\n'"If this fails it outputs an error to stderr"$'\n'""$'\n'"When this tool succeeds it outputs the path to the current release notes file"$'\n'""$'\n'""
descriptionLineCount="6"
environment="BUILD_RELEASE_NOTES"$'\n'""
example="    open \$(bin/build/release-notes.sh)"$'\n'"    vim \$(releaseNotes)"$'\n'""
file="bin/build/tools/version.sh"
fn="releaseNotes"
fnMarker="releasenotes"
foundNames=([0]="summary" [1]="environment" [2]="argument" [3]="output" [4]="hook" [5]="example")
hook="version-current"$'\n'""
line="64"
output="docs/release/version.md"$'\n'""
rawComment="Summary: Output path to current release notes"$'\n'"Output path to current release notes"$'\n'"If this fails it outputs an error to stderr"$'\n'"When this tool succeeds it outputs the path to the current release notes file"$'\n'"Environment: BUILD_RELEASE_NOTES"$'\n'"Argument: --application application - Directory. Optional. Application home directory."$'\n'"Argument: version - String. Optional. Version for the release notes path. If not specified uses the current version."$'\n'"Output: docs/release/version.md"$'\n'"Hook: version-current"$'\n'"Example:     open \$(bin/build/release-notes.sh)"$'\n'"Example:     vim \$(releaseNotes)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceHash="8d1283d5353b479e2bc32aaf234efc0a9cb6570e"
sourceLine="64"
summary="Output path to current release notes"
summaryComputed=""
usage="releaseNotes [ --application application ] [ version ]"
