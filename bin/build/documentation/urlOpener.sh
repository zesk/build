#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--exec - Executable. Optional. If not supplied uses \`urlOpen\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Open URLs which appear in a stream"$'\n'"(but continue to output the stream)"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/url.sh"
fn="urlOpener"
fnMarker="urlopener"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="stdout")
line="268"
rawComment="Summary: URL opener stream filter"$'\n'"Open URLs which appear in a stream"$'\n'"(but continue to output the stream)"$'\n'"Argument: --exec - Executable. Optional. If not supplied uses \`urlOpen\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: text"$'\n'"stdout: text"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="8a95c52ce8bb5cc766609fdc6a03daab47743e41"
sourceLine="268"
stdin="text"$'\n'""
stdout="text"$'\n'""
summary="URL opener stream filter"
summaryComputed=""
usage="urlOpener [ --exec ] [ --help ]"
