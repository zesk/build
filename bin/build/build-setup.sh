#!/usr/bin/env bash
#
# Load build system - part of zesk/build
#
# Copy this into your project to install the build system during development and in pipelines
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

# Change this line when placing in your project
relTop=../..

# The remaining lines will be replaced by the main script every time.
errEnv=1
set -eo pipefail
# set -x # Debugging

myBinary="${BASH_SOURCE[0]}"
me=$(basename "$myBinary")
if ! cd "$(dirname "$myBinary")"; then
  echo "$me: Can not cd" 1>&2
  exit $errEnv
fi
myBinary="$(pwd)/$me"
if ! cd "$relTop"; then
  echo "me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi

if [ ! -d bin/build ]; then
  start=$(($(date +%s) + 0))
  curl -L -s "$(curl -s https://api.github.com/repos/zesk/build/releases/latest | jq -r .tarball_url)" -o build.tar.gz
  tar xf build.tar.gz --strip-components=1 --wildcards '*/bin/build/*'
  rm build.tar.gz
  if [ ! -d bin/build ]; then
    echo "Unable to download and install bin/build" 1>&2
    exit $errEnv
  fi

  # shellcheck source=/dev/null
  . bin/build/tools.sh

  consoleInfo -n "Installed bin/build "
  reportTiming "$start"
else
  if [ ! -f bin/build/tools.sh ]; then
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

diffLines=$(diff "$(pwd)/bin/build/build-setup.sh" "$myBinary" | grep -v 'relTop=' | grep -c '[<>]' || :)
if [ "$diffLines" -gt 0 ]; then
  replace=$(quoteSedPattern "relTop=$relTop")
  sed -e "s/^relTop=.*/$replace/" <bin/build/build-setup.sh >"$myBinary"
  echo "$(consoleValue -n "$myBinary") $(consoleWarning -n " was updated.")"
else
  echo "$(consoleValue -n "$myBinary") $(consoleSuccess -n " is up to date.")"
fi
