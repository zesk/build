#!/bin/bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

#
# Quote sed strings for shell use
#
quoteSedPattern() {
	echo -n "$1" | sed 's/\([\/.*+?]\)/\\\1/g'
}
#
# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
environmentVariables() {
	declare -px | grep 'declare -x ' | cut -f 1 -d= | cut -f 3 -d' '
}

cd "$(dirname "${BASH_SOURCE[0]}")"
sedFile=$(mktemp)
cleanup() {
	[ -f "$sedFile" ] && rm "$sedFile"
}
trap cleanup EXIT INT

generateSedFile() {
	local sedFile=$1

	shift
	for i in "$@"; do
		case "$i" in
		*[%{}]*) ;;
		LD_*) ;;
		_*) ;;
		*)
			echo "s/{$(quoteSedPattern "$i")}/$(quoteSedPattern "${!i}")/g" >>"$sedFile"
			;;
		esac
	done
}

if [ $# -eq 0 ]; then
	ee=()
	for e in $(environmentVariables); do
		ee+=("$e")
	done
	generateSedFile "$sedFile" "${ee[@]}"
else
	generateSedFile "$sedFile" "$@"
fi

sed -f "$sedFile"
