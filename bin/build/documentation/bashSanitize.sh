#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"-- - Flag. Optional. Interactive mode on fixing errors."$'\n'"--home home - Directory. Optional. Sanitize files starting here. (Defaults to \`buildHome\`)"$'\n'"--interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"--check checkDirectory - Directory. Optional. Check shell scripts in this directory for common errors."$'\n'"... - Additional arguments are passed to \`bashLintFiles\` \`validateFileContents\`"$'\n'""
base="bash.sh"
configuration_file="bashSanitize.conf (file containing simple \`stringContains\` matches to skip file NAMES, one per line, e.g. \`etc/docker\`)"$'\n'""
description="Sanitize bash files for code quality."$'\n'"used in find \`find ... ! -path '*LINE*'\` and in grep -e 'LINE'"$'\n'"TODO - use one mechanism for bashSanitize.conf format"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashSanitize"
foundNames=([0]="argument" [1]="configuration_file")
rawComment="Sanitize bash files for code quality."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: -- - Flag. Optional. Interactive mode on fixing errors."$'\n'"Argument: --home home - Directory. Optional. Sanitize files starting here. (Defaults to \`buildHome\`)"$'\n'"Argument: --interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"Argument: --check checkDirectory - Directory. Optional. Check shell scripts in this directory for common errors."$'\n'"Argument: ... - Additional arguments are passed to \`bashLintFiles\` \`validateFileContents\`"$'\n'"Configuration File: bashSanitize.conf (file containing simple \`stringContains\` matches to skip file NAMES, one per line, e.g. \`etc/docker\`)"$'\n'"used in find \`find ... ! -path '*LINE*'\` and in grep -e 'LINE'"$'\n'"TODO - use one mechanism for bashSanitize.conf format"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="f595398f728c584ee7c7e2255d6ece3e08b0d67d"
summary="Sanitize bash files for code quality."
summaryComputed="true"
usage="bashSanitize [ --help ] [ -- ] [ --home home ] [ --interactive ] [ --check checkDirectory ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
