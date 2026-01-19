#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
argument="command ... - Any command and arguments to run."$'\n'""
base="_sugar.sh"
description="Output the \`command ...\` to stdout prior to running, then \`execute\` it"$'\n'"Return Code: Any"$'\n'""
fn="executeEcho"
foundNames=([0]="argument" [1]="requires")
requires="printf decorate execute __decorateExtensionQuote __decorateExtensionEach"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/_sugar.sh"
summary="Output the \`command ...\` to stdout prior to running, then"
usage="executeEcho [ command ... ]"
