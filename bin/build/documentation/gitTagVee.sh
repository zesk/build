#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Given a tag in the form \"1.1.3\" convert it to \"v1.1.3\" so it has a character prefix \"v\""$'\n'"Delete the old tag as well"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/git.sh"
fn="gitTagVee"
fnMarker="gittagvee"
foundNames=()
line="185"
rawComment="Given a tag in the form \"1.1.3\" convert it to \"v1.1.3\" so it has a character prefix \"v\""$'\n'"Delete the old tag as well"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="185"
summary="Given a tag in the form \"1.1.3\" convert it to"
summaryComputed="true"
usage="gitTagVee"
