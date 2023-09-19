#!/usr/bin/env bash
#
# Shell colors
#
# Usage: source ./bin/build/tools.sh
#
# Depends: -
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errEnv=1

# shellcheck source=/dev/null
. ./bin/build/tools/text.sh
# shellcheck source=/dev/null
. ./bin/build/tools/colors.sh
# shellcheck source=/dev/null
. ./bin/build/tools/pipeline.sh
# shellcheck source=/dev/null
. ./bin/build/tools/os.sh

# shellcheck source=/dev/null
. ./bin/build/tools/usage.sh
# shellcheck source=/dev/null
. ./bin/build/tools/aws.sh
# shellcheck source=/dev/null
. ./bin/build/tools/git.sh

#
# Debugging, dumps the proc1file which is used to figure out if we
# are insideDocker or not; use this to confirm platform implementation
#
dumpDockerTestFile() {
  local proc1File=/proc/1/sched

  if [ -f "$proc1File" ]; then
    bigText $proc1File
    prefixLines "$(consoleMagenta)" <"$proc1File"
  else
    consoleWarning "Missing $proc1File"
  fi
}

#
# Are we inside a docker container right now?
#
insideDocker() {
  if [ ! -f /proc/1/sched ]; then
    # Not inside
    return 1
  fi
  if head -n 1 /proc/1/sched | grep -q init; then
    # Not inside
    return 1
  fi
  # inside
  return 0
}

#
# Usage: dotEnvConfig
#
# Loads "./.env" which is the current project configuration file
# Also loads "./.env.local" if it exists
# Generally speaking - these are NAME=value files and should be parsable by
# bash and other languages.
#
dotEnvConfig() {
  if [ ! -f ./.env ]; then
    usage $errEnv "Missing ./.env"
  fi

  set -a
  # shellcheck source=/dev/null
  . ./.env
  # shellcheck source=/dev/null
  [ -f ./.env.local ] && . ./.env.local
  set +a
}

#
# Install docker PHP extensions
#
# TODO not used anywhere deprecated
#
dockerPHPExtensions() {
  local start
  start=$(beginTiming)
  consoleInfo -n "Installing PHP extensions ... "
  [ -d "./.build" ] || mkdir -p "./.build"
  docker-php-ext-install mysqli pcntl calendar >>"./.build/docker-php-ext-install.log"
  reportTiming "$start" Done
}
