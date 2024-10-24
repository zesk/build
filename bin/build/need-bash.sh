#!/usr/bin/env sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# Install bash and then run it
# Install a simple profile
# Some containers do not have bash installed by default
#
__needBash() {
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
    printf "%s" "Installing bash ..."
    if ! ${install# } >/dev/null; then
      printf "\n%s\n" "Failed installing bash, exiting." 1>&2
      return 1
    fi
    printf "\r                  \r"
  fi
  if [ ! -f "$HOME/.bashrc" ]; then
    here=$(dirname "$0")
    printf "%s\n" "#!/usr/bin/env bash" "source $here/tools.sh" "bashPrompt consoleDefaultTitle" "cd \$HOME/build" >"$HOME/.bashrc"
    chmod +x "$HOME/.bashrc"
  fi
  exec bash "$@"
}

__needBash "$@"
