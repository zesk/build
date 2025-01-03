#!/usr/bin/env sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Install bash and then run it
# Install a simple profile
# Some containers do not have bash installed by default
# Usage: {fn} installationCommand ... -- runCommand ...
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
  if [ -z "$(which bash)" ]; then
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
  exec bash "$@"
}

__needBash "$@"
