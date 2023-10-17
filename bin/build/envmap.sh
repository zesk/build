#!/bin/bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

errorEnvironment=1
me=$(basename "$0")
if ! cd "$(dirname "${BASH_SOURCE[0]}")"; then
	echo "$me: Can not cd" 1>&2
	exit $errorEnvironment
fi

if [ ! -f ./tools.sh ]; then
	echo "$me: missing $(pwd)/tools.sh" 1>&2
	exit $errorEnvironment
fi

# shellcheck source=/dev/null
. ./tools.sh

sedFile=$(mktemp)
cleanup() {
	[ -f "$sedFile" ] && rm "$sedFile"
}
trap cleanup EXIT INT

for i in $(environmentVariables); do
	case "$i" in
	*[%{}]*) ;;
	LD_*) ;;
	_*) ;;
	*)
		echo "s/{$(quoteSedPattern "$i")}/$(quoteSedPattern "${!i}")/g" >>"$sedFile"
		;;
	esac
done
sed -f "$sedFile"
