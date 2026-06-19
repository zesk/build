#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--application application - Directory. Optional. Application home directory.\nversion - String. Optional. Version for the release notes path. If not specified uses the current version.\n'
base="version.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output path to current release notes\n\nIf this fails it outputs an error to stderr\n\nWhen this tool succeeds it outputs the path to the current release notes file\n\n'
descriptionLineCount="6"
environment=$'BUILD_RELEASE_NOTES\n'
example=$'    open $(bin/build/release-notes.sh)\n    vim $(releaseNotes)\n'
file="bin/build/tools/version.sh"
fn="releaseNotes"
fnMarker="releasenotes"
foundNames=([0]="summary" [1]="environment" [2]="argument" [3]="output" [4]="hook" [5]="example")
hook=$'version-current\n'
line="147"
output=$'docs/release/version.md\n'
rawComment=$'Summary: Output path to current release notes\nOutput path to current release notes\nIf this fails it outputs an error to stderr\nWhen this tool succeeds it outputs the path to the current release notes file\nEnvironment: BUILD_RELEASE_NOTES\nArgument: --application application - Directory. Optional. Application home directory.\nArgument: version - String. Optional. Version for the release notes path. If not specified uses the current version.\nOutput: docs/release/version.md\nHook: version-current\nExample:     open $(bin/build/release-notes.sh)\nExample:     vim $(releaseNotes)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/version.sh"
sourceHash="c99a643316ae012c003405614babad883b2035e7"
sourceLine="147"
summary="Output path to current release notes"
summaryComputed=""
usage="releaseNotes [ --application application ] [ version ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreleaseNotes'$'\e''[0m '$'\e''[[(blue)]m[ --application application ]'$'\e''[0m '$'\e''[[(blue)]m[ version ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--application application  '$'\e''[[(value)]mDirectory. Optional. Application home directory.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mversion                    '$'\e''[[(value)]mString. Optional. Version for the release notes path. If not specified uses the current version.'$'\e''[[(reset)]m'$'\n'''$'\n''Output path to current release notes'$'\n'''$'\n''If this fails it outputs an error to stderr'$'\n'''$'\n''When this tool succeeds it outputs the path to the current release notes file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_RELEASE_NOTES'$'\n'''$'\n''Example:'$'\n''    open $(bin/build/release-notes.sh)'$'\n''    vim $(releaseNotes)'
# shellcheck disable=SC2016
helpPlain='Usage: releaseNotes [ --application application ] [ version ]'$'\n'''$'\n''    --application application  Directory. Optional. Application home directory.'$'\n''    version                    String. Optional. Version for the release notes path. If not specified uses the current version.'$'\n'''$'\n''Output path to current release notes'$'\n'''$'\n''If this fails it outputs an error to stderr'$'\n'''$'\n''When this tool succeeds it outputs the path to the current release notes file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_RELEASE_NOTES'$'\n'''$'\n''Example:'$'\n''    open $(bin/build/release-notes.sh)'$'\n''    vim $(releaseNotes)'
documentationPath="documentation/source/tools/version.md"
