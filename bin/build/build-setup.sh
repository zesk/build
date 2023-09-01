#!/usr/bin/env bash
#
# Load build system - part of zesk/build
#
# Copy this into your project to install the build system during development and in pipelines
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errEnv=1
set -eo pipefail
# set -x # Debugging

me=$(basename "${BASH_SOURCE[0]}")
relTop="../.."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi

if [ ! -d "bin/build" ]; then
  start=$(($(date +%s) + 0))
  curl -L -s "$(curl -s https://api.github.com/repos/zesk/build/releases/latest | jq -r .tarball_url)" -o build.tar.gz
  tar xf build.tar.gz --strip-components=1 --include=*/bin/build/*
  rm build.tar.gz
  if [ ! -d "bin/build" ]; then
    echo "Unable to download and install bin/build" 1>&2
    exit $errEnv
  fi

  # shellcheck source=/dev/null
  . bin/build/tools.sh

  consoleInfo -n "Installed bin/build "
  reportTiming "$start"
else
  if [ -f bin/build/tools.sh ]; then
    exec 1>&2
    echo "Incorrect build version or broken install (can't find tools.sh):"
    echo
    echo "  rm -rf bin/build"
    echo "  ${BASH_SOURCE[0]}"
    exit $errEnv
  fi
  # shellcheck source=/dev/null
  . bin/build/tools.sh
fi

if ! diff -q bin/build/build-setup.sh "${BASH_SOURCE[0]}"; then
  replace=$(sedQuotePattern "relTop=$relTop")
  sed -e "s/relTop=.*/$replace/" <bin/build/build-setup.sh >"${BASH_SOURCE[0]}"
  consoleInfo "Updated local ${BASH_SOURCE[0]} to latest"
fi
