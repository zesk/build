#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="extension - String. Optional. Extension to list. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List the file(s) of an extension."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitPreCommitListExtension"
fnMarker="gitprecommitlistextension"
foundNames=([0]="argument" [1]="stdout")
line="979"
rawComment="List the file(s) of an extension."$'\n'"Argument: extension - String. Optional. Extension to list. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdout: File. One per line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="979"
stdout="File. One per line."$'\n'""
summary="List the file(s) of an extension."
summaryComputed="true"
usage="gitPreCommitListExtension [ extension ] [ --help ]"
