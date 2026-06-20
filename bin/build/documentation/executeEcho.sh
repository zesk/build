#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'command ... - Any command and arguments to run.\n--help - Flag. Optional. Display this help.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output the `command ...` to stdout prior to running, then `execute` it\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="executeEcho"
fnMarker="executeecho"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="124"
original="executeEcho"
rawComment=$'Output the `command ...` to stdout prior to running, then `execute` it\nArgument: command ... - Any command and arguments to run.\nReturn Code: Any\nArgument: --help - Flag. Optional. Display this help.\nRequires: helpArgument decorate execute __decorateExtensionQuote __decorateExtensionEach\n\n'
requires=$'helpArgument decorate execute __decorateExtensionQuote __decorateExtensionEach\n'
return_code=$'Any\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="8d5ac9aefc03ec2923c4a48ed0d33aed85646581"
sourceLine="124"
summary="Output the \`command ...\` to stdout prior to running, then"
summaryComputed="true"
usage="executeEcho [ command ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecuteEcho'$'\e''[0m '$'\e''[[(blue)]m[ command ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcommand ...  '$'\e''[[(value)]mAny command and arguments to run.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the '$'\e''[[(code)]mcommand ...'$'\e''[[(reset)]m to stdout prior to running, then '$'\e''[[(code)]mexecute'$'\e''[[(reset)]m it'$'\n'''$'\n''Return codes:'$'\n''- Any'
# shellcheck disable=SC2016
helpPlain='Usage: executeEcho [ command ... ] [ --help ]'$'\n'''$'\n''    command ...  Any command and arguments to run.'$'\n''    --help       Flag. Optional. Display this help.'$'\n'''$'\n''Output the command ... to stdout prior to running, then execute it'$'\n'''$'\n''Return codes:'$'\n''- Any'
documentationPath="documentation/source/tools/sugar-core.md"
