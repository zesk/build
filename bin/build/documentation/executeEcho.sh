#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="_sugar.sh"
description="Output the \`command ...\` to stdout prior to running, then \`execute\` it"$'\n'"Argument: command ... - Any command and arguments to run."$'\n'"Return Code: Any"$'\n'"Requires: printf decorate execute __decorateExtensionQuote __decorateExtensionEach"$'\n'""
file="bin/build/tools/_sugar.sh"
foundNames=()
rawComment="Output the \`command ...\` to stdout prior to running, then \`execute\` it"$'\n'"Argument: command ... - Any command and arguments to run."$'\n'"Return Code: Any"$'\n'"Requires: printf decorate execute __decorateExtensionQuote __decorateExtensionEach"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="4bce6d8a22071b1c44a64aadb33672fc47a840f1"
summary="Output the \`command ...\` to stdout prior to running, then"
usage="executeEcho"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecuteEcho'$'\e''[0m'$'\n'''$'\n''Output the '$'\e''[[(code)]mcommand ...'$'\e''[[(reset)]m to stdout prior to running, then '$'\e''[[(code)]mexecute'$'\e''[[(reset)]m it'$'\n''Argument: command ... - Any command and arguments to run.'$'\n''Return Code: Any'$'\n''Requires: printf decorate execute __decorateExtensionQuote __decorateExtensionEach'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: executeEcho'$'\n'''$'\n''Output the command ... to stdout prior to running, then execute it'$'\n''Argument: command ... - Any command and arguments to run.'$'\n''Return Code: Any'$'\n''Requires: printf decorate execute __decorateExtensionQuote __decorateExtensionEach'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.46
