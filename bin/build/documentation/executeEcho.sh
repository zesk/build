#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
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
rawComment=$'Output the `command ...` to stdout prior to running, then `execute` it\nArgument: command ... - Any command and arguments to run.\nReturn Code: Any\nArgument: --help - Flag. Optional. Display this help.\nRequires: helpArgument decorate execute __decorateExtensionQuote __decorateExtensionEach\n\n'
requires=$'helpArgument decorate execute __decorateExtensionQuote __decorateExtensionEach\n'
return_code=$'Any\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="8d5ac9aefc03ec2923c4a48ed0d33aed85646581"
sourceLine="124"
summary="Output the \`command ...\` to stdout prior to running, then"
summaryComputed="true"
usage="executeEcho [ command ... ] [ --help ]"
