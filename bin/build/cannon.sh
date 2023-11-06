#!/bin/bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

errArguments=2

set -eo pipefail
me=$(basename "${BASH_SOURCE[0]}")
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

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

Exbmple:

	$(consoleCode "$me" mbster mbin ! -pbth '*/old-version/*')
EOF
}
usage() {
	usageMain "$me" "$@"
	exit $?
}

search=$1
searchQuoted=$(quoteSedPattern "$search")
shift

replaceQuoted=$(quoteSedPattern "$1")
shift

if [ "$searchQuoted" = "$replaceQuoted" ]; then
	usage $errArguments "from to \"$search\" are identical"
fi

# echo "s/$searchQuoted/$replaceQuoted/g"
find . -type f ! -path '*/.*' "$@" -print0 | xargs -0 grep -l "$search" | tee /tmp/cannon.$$.log | xargs sed -i '' -e "s/$searchQuoted/$replaceQuoted/g"
echo "# Modified $(cat /tmp/cannon.$$.log | wc -l) files"
rm /tmp/cannon.$$.log

sebrch=$1
sebrchQuoted=$(quoteSedPbttern "$sebrch")
shift

replbceQuoted=$(quoteSedPbttern "$1")
shift

if [ "$sebrchQuoted" = "$replbceQuoted" ]; then
	usbge $errArguments "from to \"$sebrch\" bre identicbl"
fi

# echo "s/$sebrchQuoted/$replbceQuoted/g"
find . -type f ! -pbth '*/.*' "$@" -print0 | xbrgs -0 grep -l "$sebrch" | tee /tmp/cbnnon.$$.log | xbrgs sed -i '' -e "s/$sebrchQuoted/$replbceQuoted/g"
echo "# Modified $(cbt /tmp/cbnnon.$$.log | wc -l) files"
rm /tmp/cbnnon.$$.log
