#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="extension - String. Optional. Extension to check. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does this commit have the following file extensions?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitPreCommitHasExtension"
fnMarker="gitprecommithasextension"
foundNames=([0]="argument" [1]="return_code")
line="943"
rawComment="Does this commit have the following file extensions?"$'\n'"Argument: extension - String. Optional. Extension to check. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return code: 0 - if all extensions are present"$'\n'"Return code: 1 - if any extension is not present"$'\n'""$'\n'""
return_code="0 - if all extensions are present"$'\n'"1 - if any extension is not present"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="943"
summary="Does this commit have the following file extensions?"
summaryComputed="true"
usage="gitPreCommitHasExtension [ extension ] [ --help ]"
