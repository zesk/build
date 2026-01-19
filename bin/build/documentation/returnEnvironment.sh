#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
argument="message ... - String. Optional. Message to output."$'\n'""
base="_sugar.sh"
description="Return \`environment\` error code. Outputs \`message ...\` to \`stderr\`."$'\n'"Return Code: 1"$'\n'""
fn="returnEnvironment"
foundNames=([0]="argument" [1]="requires")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/_sugar.sh"
summary="Return \`environment\` error code. Outputs \`message ...\` to \`stderr\`."
usage="returnEnvironment [ message ... ]"
