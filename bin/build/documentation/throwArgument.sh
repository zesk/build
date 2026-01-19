#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-19
# shellcheck disable=SC2034
argument="handler - Function. Required. Failure command"$'\n'"message ... - String. Optional. Error message to display."$'\n'""
base="_sugar.sh"
description="Run \`handler\` with an argument error"$'\n'""
fn="throwArgument"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/_sugar.sh"
sourceModified="1768721470"
summary="Run \`handler\` with an argument error"
usage="throwArgument handler [ message ... ]"
