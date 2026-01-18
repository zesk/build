#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="none"
base="environment.sh"
description="Output a list of environment variables and ignore function definitions"$'\n'""$'\n'"both \`set\` and \`env\` output functions and this is an easy way to just output"$'\n'"exported variables"$'\n'""$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentVariables"
foundNames=([0]="requires")
requires="declare grep cut usageDocument __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768759812"
summary="Output a list of environment variables and ignore function definitions"
usage="environmentVariables"
