#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'file - File. Optional. File to download.\n--name name - String. Optional. Target name of the file once downloaded.\n--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.\n'
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Download an file from remote to terminal host\nArgument:\n\n'
descriptionLineCount="3"
file="bin/build/tools/iterm2.sh"
fn="iTerm2Download"
fnMarker="iterm2download"
foundNames=([0]="argument" [1]="stdin")
line="364"
rawComment=$'Download an file from remote to terminal host\nArgument: file - File. Optional. File to download.\nArgument: --name name - String. Optional. Target name of the file once downloaded.\nArgument:\nArgument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.\nstdin: file\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="13698f5ecbedc059696bbffbebc13f8cf7096e44"
sourceLine="364"
stdin=$'file\n'
summary="Download an file from remote to terminal host"
summaryComputed="true"
usage="iTerm2Download [ file ] [ --name name ] [ --ignore | -i ]"
