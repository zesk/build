#!/bin/bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

set -eo pipefail
errEnv=1

me=$(basename "$0")
relTop="../.."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
	echo "$me: Can not cd to $relTop" 1>&2
	exit $errEnv
fi

# shellcheck source=/dev/null
. bin/build/tools.sh

if [ "$1" = "$2" ]; then
	echo "### cannon.sh takes two parameters now. The ones you passed are identical..."
	exit 1
fi

search=$(quoteSedPattern "$1")
replace=$(quoteSedPattern "$2")
# echo "s/$search/$replace/g"
find . -type f ! -path '*/.*' -print0 | xargs -0 grep -l "$1" | tee /tmp/cannon.$$.log | xargs sed -i '' -e "s/$search/$replace/g"
echo "# Modified $(cat /tmp/cannon.$$.log | wc -l) files"
rm /tmp/cannon.$$.log
