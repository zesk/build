#!/usr/bin/env bash
#
# pre-release.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Argument: name - String. Optional. Name of tool to add.
buildAddTool() {
  local usage="_return" home file

  home=$(__catchEnvironment "$usage" buildHome) || return $?

  while [ $# -gt 0 ]; do
    case "$1" in
    *[^-[:alnum:]]*)
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
# Loads .STAGING.env first
buildContainer() {
  local image="${1-ubuntu:latest}"
  local name="${image%:latest}"
  local ee=(
    "bashPrompt --label \"$name\" bashPromptModule_binBuild bashPromptModule_ApplicationPath bashPromptModule_dotFilesWatcher --order 8 bashPromptModule_iTerm2Colors"
    "approved=\$(dotFilesApprovedFile)"
    "[ -f \"\$approved\" ] || dotFilesApproved bash mysql >>\$approved"
    "packageWhich --verbose shasum apt-rdepends"
    "cd ~/build"
  )
  dockerLocalContainer --image "$image" --path /root/build --env-file .STAGING.env /root/build/bin/build/bash-build.sh --rc-extras "${ee[@]}" -- "$@"
}
