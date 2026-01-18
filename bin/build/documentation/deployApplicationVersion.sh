#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="applicationHome - Directory. Required. Application home to get the version from."$'\n'""
base="deploy.sh"
description="Extracts version from an application either from \`.deploy\` files or from the the \`.env\` if"$'\n'"that does not exist."$'\n'""$'\n'"Checks \`APPLICATION_ID\` and \`APPLICATION_TAG\` and uses first non-blank value."$'\n'""$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployApplicationVersion"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/deploy.sh"
sourceModified="1768721469"
summary="Extracts version from an application either from \`.deploy\` files or"
usage="deployApplicationVersion applicationHome"
