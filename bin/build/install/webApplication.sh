#!/usr/bin/env bash
#
# Support scripts to set up a system for running PHP and Apache software
#
# Copyright &copy; 2024 Market Acumen, LLC
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
source ./bin/build/tools.sh

#
# Configure the web application server as root
#
webApplicationConfigure() {
  local start
  if ! start=$(beginTiming); then
    return $?
  fi
  while [ $# -gt 0 ]; do
    case $1 in
      *) ;;
    esac
    shift
  done
  reportTiming "$start" "${FUNCNAME[0]} completed in"
}

if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ] && [ $# -gt 0 ]; then
  webApplicationConfigure "$@"
fi
