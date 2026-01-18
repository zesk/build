#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"-- - Flag. Optional. Interactive mode on fixing errors."$'\n'"--home home - Directory. Optional. Sanitize files starting here. (Defaults to \`buildHome\`)"$'\n'"--interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"--check checkDirectory - Directory. Optional. Check shell scripts in this directory for common errors."$'\n'"... - Additional arguments are passed to \`bashLintFiles\` \`validateFileContents\`"$'\n'""
base="bash.sh"
description="Sanitize bash files for code quality."$'\n'""$'\n'"Configuration File: bashSanitize.conf (file containing simple \`stringContains\` matches to skip file NAMES, one per line, e.g. \`etc/docker\`)"$'\n'"used in find \`find ... ! -path '*LINE*'\` and in grep -e 'LINE'"$'\n'"TODO - use one mechanism for bashSanitize.conf format"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashSanitize"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/bash.sh"
sourceModified="1768721469"
summary="Sanitize bash files for code quality."
usage="bashSanitize [ --help ] [ -- ] [ --home home ] [ --interactive ] [ --check checkDirectory ] [ ... ]"
