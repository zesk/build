#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="command ... - Any command and arguments to run."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="_sugar.sh"
description="Output the \`command ...\` to stdout prior to running, then \`execute\` it"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="executeEcho"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="123"
lowerFn="executeecho"
rawComment="Output the \`command ...\` to stdout prior to running, then \`execute\` it"$'\n'"Argument: command ... - Any command and arguments to run."$'\n'"Return Code: Any"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: helpArgument decorate execute __decorateExtensionQuote __decorateExtensionEach"$'\n'""$'\n'""
requires="helpArgument decorate execute __decorateExtensionQuote __decorateExtensionEach"$'\n'""
return_code="Any"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="1cf1ee5794e801d06a483b8f311df83c051c18a0"
sourceLine="123"
summary="Output the \`command ...\` to stdout prior to running, then"
summaryComputed="true"
usage="executeEcho [ command ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecuteEcho'$'\e''[0m '$'\e''[[(blue)]m[ command ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcommand ...  '$'\e''[[(value)]mAny command and arguments to run.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the '$'\e''[[(code)]mcommand ...'$'\e''[[(reset)]m to stdout prior to running, then '$'\e''[[(code)]mexecute'$'\e''[[(reset)]m it'$'\n'''$'\n''Return codes:'$'\n''- Any'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: executeEcho [ command ... ] [ --help ]'$'\n'''$'\n''    command ...  Any command and arguments to run.'$'\n''    --help       Flag. Optional. Display this help.'$'\n'''$'\n''Output the command ... to stdout prior to running, then execute it'$'\n'''$'\n''Return codes:'$'\n''- Any'$'\n'''
documentationPath="documentation/source/tools/sugar-core.md"
