#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="version.sh"
description="Summary: Output path to current release notes"$'\n'"Output path to current release notes"$'\n'"If this fails it outputs an error to stderr"$'\n'"When this tool succeeds it outputs the path to the current release notes file"$'\n'"Environment: BUILD_RELEASE_NOTES"$'\n'"Argument: --application application - Directory. Optional. Application home directory."$'\n'"Argument: version - String. Optional. Version for the release notes path. If not specified uses the current version."$'\n'"Output: docs/release/version.md"$'\n'"Hook: version-current"$'\n'"Example:     open \$(bin/build/release-notes.sh)"$'\n'"Example:     vim \$(releaseNotes)"$'\n'"shellcheck disable=SC2120"$'\n'""
file="bin/build/tools/version.sh"
foundNames=()
rawComment="Summary: Output path to current release notes"$'\n'"Output path to current release notes"$'\n'"If this fails it outputs an error to stderr"$'\n'"When this tool succeeds it outputs the path to the current release notes file"$'\n'"Environment: BUILD_RELEASE_NOTES"$'\n'"Argument: --application application - Directory. Optional. Application home directory."$'\n'"Argument: version - String. Optional. Version for the release notes path. If not specified uses the current version."$'\n'"Output: docs/release/version.md"$'\n'"Hook: version-current"$'\n'"Example:     open \$(bin/build/release-notes.sh)"$'\n'"Example:     vim \$(releaseNotes)"$'\n'"shellcheck disable=SC2120"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceHash="d77afda1e8e2f6fc82e83a8aab8cb537d29f8c0e"
summary="Summary: Output path to current release notes"
usage="releaseNotes"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreleaseNotes'$'\e''[0m'$'\n'''$'\n''Summary: Output path to current release notes'$'\n''Output path to current release notes'$'\n''If this fails it outputs an error to stderr'$'\n''When this tool succeeds it outputs the path to the current release notes file'$'\n''Environment: BUILD_RELEASE_NOTES'$'\n''Argument: --application application - Directory. Optional. Application home directory.'$'\n''Argument: version - String. Optional. Version for the release notes path. If not specified uses the current version.'$'\n''Output: docs/release/version.md'$'\n''Hook: version-current'$'\n''Example:     open $(bin/build/release-notes.sh)'$'\n''Example:     vim $(releaseNotes)'$'\n''shellcheck disable=SC2120'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: releaseNotes'$'\n'''$'\n''Summary: Output path to current release notes'$'\n''Output path to current release notes'$'\n''If this fails it outputs an error to stderr'$'\n''When this tool succeeds it outputs the path to the current release notes file'$'\n''Environment: BUILD_RELEASE_NOTES'$'\n''Argument: --application application - Directory. Optional. Application home directory.'$'\n''Argument: version - String. Optional. Version for the release notes path. If not specified uses the current version.'$'\n''Output: docs/release/version.md'$'\n''Hook: version-current'$'\n''Example:     open $(bin/build/release-notes.sh)'$'\n''Example:     vim $(releaseNotes)'$'\n''shellcheck disable=SC2120'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.851
