#!/usr/bin/env bash
#
# identical-tests.sh
#
# identical tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests
tests+=(testIdenticalCheck)

testIdenticalCheck() {
  #
  # Unusual quoting here is to avoid matching the word uh, IDENTICAL with the comment here
  #

  local single singles
  singles=()
  while read -r single; do
    single="${single#"${single%%[![:space:]]*}"}"
    single="${single%"${single##*[![:space:]]}"}"
    if [ "${single###}" = "${single}" ]; then
      singles+=(--single "$single")
    fi
  done <./etc/identical-check-singles.txt

  # shellcheck disable=SC2059
  printf "SINGLES: $(consoleCode "%s")\n" "${singles[@]}"
  identicalCheck "${singles[@]+"${singles[@]}"}" --extension sh --prefix '# ''IDENTICAL' || return $?
}
