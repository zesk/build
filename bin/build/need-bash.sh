#!/usr/bin/env sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Install bash and then run it
# Install a simple profile
# Some containers do not have bash installed by default
# Usage: {fn} installationCommand ... -- runCommand ...
# Requires: sh printf dirname chmod exec bash
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
  if [ -z "$(command which bash)" ]; then
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
