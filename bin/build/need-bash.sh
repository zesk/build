#!/usr/bin/env sh
#
# IDENTICAL licenseHeader 11
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#

# Install bash and then run it
# Install a simple profile
# Some containers do not have bash installed by default
# Argument: installationCommand ... -- - Executable. Required. Command terminated with a `--` to install bash.
# Requires: sh printf dirname chmod exec bash
# Argument: runCommand ... - Executable. Optional. Command to pass to bash once installed.
__needBash() {
  export LC_TERMINAL
  export TERM
  verboseFlag=false
  title="${1-}"
  shift
  install=""
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      shift
      break
    fi
    install="$install $1"
    shift
  done
  if [ -z "$(command -v bash)" ]; then
    ! $verboseFlag || printf -- "%s" "Installing bash ..."
    if ! ${install# } >/dev/null; then
      printf -- "\n%s\n" "Failed installing bash, exiting." 1>&2
      return 1
    fi
    ! $verboseFlag || printf -- "\r                  \r"
  fi
  if [ ! -f "$HOME/.bashrc" ]; then
    here=$(dirname "$0")
    printf -- "%s\n" "#!/usr/bin/env bash" "source $here/tools.sh" "bashPrompt consoleDefaultTitle" "cd \$HOME/build" "iTerm2Badge -i \"$title\"" >"$HOME/.bashrc"
    chmod +x "$HOME/.bashrc"
  fi
  if [ $# -gt 0 ]; then
    cc="\"$1\""
    shift
    # quote remaining arguments as bash does not have a way to do this on the command line which TBH is surprising
    # you can do stdin (bash -s) but argument parsing is not supported so you have to quote anyway there or
    # have who calls this to then quote properly for being within double quotes and that sucks so ...
    while [ $# -gt 0 ]; do
      cc="${cc} \"$(printf "%s\n" "$1" | sed 's/"/\\"/g')\""
      shift
    done
    exec bash -c "$cc"
  else
    exec bash
  fi
}

__needBash "$@"
