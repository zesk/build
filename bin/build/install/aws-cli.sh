#!/usr/bin/env bash
#
# aws-cli.sh
#
# Depends: apt
#
# aws cli install
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

errorEnvironment=1

me=$(basename "$0")
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errorEnvironment
fi
quietLog="./.build/$me.log"

# shellcheck source=/dev/null
. ./bin/build/tools.sh

if which aws >/dev/null; then
  exit 0
fi

./bin/build/install/apt.sh

consoleInfo -n "Installing aws-cli ... "
start=$(beginTiming)
case "$HOSTTYPE" in
arm64 | aarch64)
  url="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip"
  ;;
*)
  url="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
  ;;
esac

buildDir=./.build/
requireFileDirectory "$quietLog"
if ! curl -s "$url" -o "${buildDir}awscliv2.zip" >>"$quietLog"; then
  buildFailed "$quietLog"
fi
if ! unzip "${buildDir}awscliv2.zip" >>"$quietLog"; then
  buildFailed "$quietLog"
fi
if ! "${buildDir}aws/install" >>"$quietLog"; then
  buildFailed "$quietLog"
fi
# This failed once, not sure why, .build will be deleted anyway
rm -rf "${buildDir}aws/" "${buildDir}awscliv2.zip" 2>/dev/null || :
consoleValue -n "$(aws --version) "
reportTiming "$start" OK
