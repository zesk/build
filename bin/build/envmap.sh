#!/bin/bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

errEnv=1
me=$(basename "$0")
if ! cd "$(dirname "${BASH_SOURCE[0]}")"; then
	echo "$me: Can not cd" 1>&2
	exit $errEnv
fi

# shellcheck source=/dev/null
. tools.sh

sedFile=$(mktemp)
cleanup() {
	[ -f "$sedFile" ] && rm "$sedFile"
}
trap cleanup EXIT INT

for i in $(env | cut -d = -f 1); do
	case "$i" in
	LD_*) ;;
	_*) ;;
	*)
		echo "s/{$(quoteSedPattern "$i")}/$(quoteSedPattern "${!i}")/g" >>"$sedFile"
		;;
	esac

done
sed -f "$sedFile"
rm "$sedFile"
