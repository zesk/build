#!/bin/bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

# IDENTICAL errorArgument 1
errorArgument=2

# IDENTICAL bashHeader2 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

me=$(basename "${BASH_SOURCE[0]}")

usageOptions() {
	cat <<EOF
	fromText Required. String of text to search for.
	toText Required. String of text to replace.
	findArgs... Any additional arguments are meant to filter files.
EOF
}
usageDescription() {
	cat <<EOF
Replace text $(consoleCode fromText) with $(consoleCode toText) in files, using $(consoleCode findArgs) to filter files if needed.

This can mess up your files so use with caution.

Example:

	$(consoleCode "$me" master main ! -path '*/old-version/*')
EOF
}
usage() {
	usageMain "$me" "$@"
	return $?
}

#
# fn: cannon.sh
# Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.
#
# This can break your files so use with caution.
#
# Example:     cannon master main ! -path '*/old-version/*')
# Usage: cannon fromText toText [ findArgs ... ]
# Argument: fromText - Required. String of text to search for.
# Argument: toText - Required. String of text to replace.
# Argument: findArgs ... - Any additional arguments are meant to filter files.
# Exit Code: 0 - Success
# Exit Code: 1 - Arguments are identical
#
#
cannon() {
	local search searchQuoted replaceQuoted

	if [ -z "${1-}" ]; then
		usage "$errorArgument" "Empty search string"
		return $?
	fi
	search=${1-}
	searchQuoted=$(quoteSedPattern "$search")
	shift || usage "$errorArgument" "Missing replacement argument"
	if [ -z "${1-}" ]; then
		usage "$errorArgument" "Empty replacement string"
		return $?
	fi
	replaceQuoted=$(quoteSedPattern "${1-}")
	shift
	if [ "$searchQuoted" = "$replaceQuoted" ]; then
		usage "$errorArgument" "from to \"$search\" are identical"
	fi

	cannonLog=$(mktemp)
	find . -type f ! -path '*/.*' "$@" -print0 | xargs -0 grep -l "$search" | tee "$cannonLog" | xargs sed -i '' -e "s/$searchQuoted/$replaceQuoted/g"
	consoleSuccess "# Modified $(wc -l <"$cannonLog") files"
	rm "$cannonLog"
}

cannon "$@"
