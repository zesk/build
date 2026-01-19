#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-19
# shellcheck disable=SC2034
argument="returnCode - Integer. Required. Return code."$'\n'"handler - Function. Required. Error handler."$'\n'"message ... - String. Optional. Error message"$'\n'""
base="_sugar.sh"
description="Run \`handler\` with a passed return code"$'\n'""
fn="returnThrow"
foundNames=([0]="argument" [1]="requires")
requires="returnArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/_sugar.sh"
sourceModified="1768721470"
summary="Run \`handler\` with a passed return code"
usage="returnThrow returnCode handler [ message ... ]"
