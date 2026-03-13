#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="command ... - Any command and arguments to run."$'\n'""
base="_sugar.sh"
description="Output the \`command ...\` to stdout prior to running, then \`execute\` it"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="executeEcho"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
rawComment="Output the \`command ...\` to stdout prior to running, then \`execute\` it"$'\n'"Argument: command ... - Any command and arguments to run."$'\n'"Return Code: Any"$'\n'"Requires: printf decorate execute __decorateExtensionQuote __decorateExtensionEach"$'\n'""$'\n'""
requires="printf decorate execute __decorateExtensionQuote __decorateExtensionEach"$'\n'""
return_code="Any"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="1ff9bebad70c8fea8d82a17d32a3d8b9fd324874"
summary="Output the \`command ...\` to stdout prior to running, then"
summaryComputed="true"
usage="executeEcho [ command ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecuteEcho'$'\e''[0m '$'\e''[[(blue)]m[ command ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcommand ...  '$'\e''[[(value)]mAny command and arguments to run.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the '$'\e''[[(code)]mcommand ...'$'\e''[[(reset)]m to stdout prior to running, then '$'\e''[[(code)]mexecute'$'\e''[[(reset)]m it'$'\n'''$'\n''Return codes:'$'\n''- Any'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: executeEcho [ command ... ]'$'\n'''$'\n''    command ...  Any command and arguments to run.'$'\n'''$'\n''Output the command ... to stdout prior to running, then execute it'$'\n'''$'\n''Return codes:'$'\n''- Any'$'\n'''
