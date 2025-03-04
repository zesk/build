#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Developer scripts

__buildAnnounce() {
  decorate info "Added aliases $(decorate each code t tools IdenticalRepair)"
  decorate info "Available functions $(decorate each code buildPreRelease buildAddTool buildContainer)"
}

__buildAliases() {
  local home

  home=$(__environment buildHome) || return $?

  # shellcheck disable=SC2139
  alias t="$home/bin/build/tools.sh"
  alias tools=t
  # shellcheck disable=SC2139
  alias IdenticalRepair="$home/bin/build/identical-repair.sh"

}

__buildAliasesUndo() {
  unalias t 2>/dev/null
  unalias tools 2>/dev/null
  unalias IdenticalRepair 2>/dev/null
}

buildPreRelease() {
  local home

  home=$(__environment buildHome) || return $?

  statusMessage decorate info "Deprecated cleanup ..."
  __execute "$home/bin/build/deprecated.sh" || exitCode=$?
  statusMessage decorate info "Identical repair (internal, long) ..."
  __execute "$home/bin/build/identical-repair.sh" --internal || exitCode=$?
  statusMessage decorate info "Linting"
  find "$home" -name '*.sh' ! -path '*/.*/*' | bashLintFiles || exitCode=$?

  local exitCode=0
  # __execute "$home/bin/documentation.sh" --clean || exitCode=$?
  __execute "$home/bin/documentation.sh" || exitCode=$?
  if [ "$exitCode" -eq 0 ]; then
    if gitRepositoryChanged; then
      statusMessage decorate info "Committing changes ..."
      gitCommit -- "buildPreRelease $(hookVersionCurrent)"
      statusMessage decorate info --last "Committed and ready to release."
    else
      statusMessage decorate info --last "No changes to commit."
    fi
  fi
  return "$exitCode"
}

# Argument: name - String. Optional. Name of tool to add.
buildAddTool() {
  local usage="_return" home file

  home=$(__catchEnvironment "$usage" buildHome) || return $?

  while [ $# -gt 0 ]; do
    case "$1" in
      *[^[:alnum:]]*)
        __throwArgument "$usage" "Invalid name: $1" || return $?
        ;;
    esac
    for file in "bin/build/tools/$1.sh" "test/tools/$1-tests.sh"; do
      if [ ! -f "$home/$file" ]; then
        touch "$home/$file"
        chmod +x "$home/$file"
      fi
      git add "$home/$file"
    done
    file="documentation/source/tools/$1.md"
    if [ ! -f "$home/$file" ]; then
      touch "$home/$file"
    fi
    git add "$home/$file"
    shift
  done
}

# Argument: image - String. Optional. Image to load
# Load Zesk Build in a preconfigured container
# Starts in `/root/build`
# Loads .env.STAGING first
buildContainer() {
  local image="${1-ubuntu:latest}"
  local name="${image%:latest}"
  local ee=(
    "bashPrompt --label \"$name\" bashPromptModule_binBuild bashPromptModule_ApplicationPath bashPromptModule_dotFilesWatcher bashPromptModule_iTerm2Colors"
    "approved=\$(dotFilesApprovedFile)"
    "[ -f \"\$approved\" ] || dotFilesApproved bash mysql >>\$approved"
    "packageWhich --verbose shasum apt-rdepends"
    "cd ~/build"
  )
  dockerLocalContainer --image "$image" --path /root/build --env-file .env.STAGING /root/build/bin/build/bash-build.sh --rc-extras "${ee[@]}" -- "$@"
}

__buildAliases
__buildAnnounce
reloadChanges bin/build/tools.sh bin "Zesk Build"

unset __buildAliases __buildAnnounce
