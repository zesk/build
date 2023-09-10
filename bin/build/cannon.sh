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

usage() {
	local exitCode=$1

	shift
	exec 1>&2
	consoleError "$*"
	echo
	consoleInfo "$me fromText toText [ findArgs ... ]"
	echo
	consoleInfo "Replace text fromText with toText in files, using findArgs to filter files if needed"
	echo
	consoleInfo "This can mess up your files so use with caution."
	echo
	exit "$exitCode"
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
