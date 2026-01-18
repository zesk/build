#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="script - File. Required. Bash script to fetch requires tokens from."$'\n'""
base="bash.sh"
description="Gets a list of the \`Requires:\` comments in a bash file"$'\n'"Returns a unique list of tokens"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashGetRequires"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/bash.sh"
sourceModified="1768721469"
summary="Gets a list of the \`Requires:\` comments in a bash"
usage="bashGetRequires script"
