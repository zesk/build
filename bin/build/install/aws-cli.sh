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

errEnv=1

me=$(basename "$0")
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi
quietLog="./.build/$me.log"

# shellcheck source=/dev/null
. ./bin/build/tools.sh

if ! which aws >/dev/null; then
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

  requireFileDirectory "$quietLog"
  if ! curl -s "$url" -o "awscliv2.zip" >>"$quietLog"; then
    failed "$quietLog"
  fi
  if ! unzip awscliv2.zip >>"$quietLog"; then
    failed "$quietLog"
  fi
  if ! ./aws/install >>"$quietLog"; then
    failed "$quietLog"
  fi
  rm -rf ./aws/ awscliv2.zip
  consoleValue -n "$(aws --version) "
  reportTiming "$start" OK
fi
