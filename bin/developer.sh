#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Developer scripts

developerTrack "${BASH_SOURCE[0]}"

__buildFunctions() {
  developerTrack "${BASH_SOURCE[0]}" --list
}
__buildAnnounce() {
  developerAnnounce < <(__buildFunctions)
}

__buildConfigure() {
  local home

  home=$(__environment buildHome) || return $?

  # shellcheck disable=SC2139
  alias t="$home/bin/build/tools.sh"
  alias tools=t
  # shellcheck disable=SC2139
  alias IdenticalRepair="$home/bin/build/identical-repair.sh"

  reloadChanges bin/build/tools.sh bin "Zesk Build"
  decorate info "Watching $(decorate file "$home/bin") for changes to reload"
}

__buildConfigureUndo() {
  developerUndo < <(__buildFunctions)
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

# read urls one per line
githubURLsToCSV() {
  local url
  home=$(buildHome) || return $?
  while read -r url; do
    if ! repo=$(githubURLParse "$url"); then
      printf -- "\"%s\",\"%s\",\"%s\"\n" "-" "$url" "" || return $?
    else
      local date hasReleases=true
      date=$(githubPublishDate "$repo") || return $?
      if [ "$date" = "null" ]; then
        hasReleases=false
        date=$(githubLatest "$repo" | jq -r .pushed_at) || return $?
      fi
      printf -- "\"%s\",\"%s\",\"%s\"\n" "$date" "$url" "$hasReleases" || return $?
      sleep 1
    fi
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
    "bashPrompt --label \"$name\" bashPromptModule_binBuild bashPromptModule_ApplicationPath bashPromptModule_dotFilesWatcher bashPromptModule_iTerm2Colors"
    "approved=\$(dotFilesApprovedFile)"
    "[ -f \"\$approved\" ] || dotFilesApproved bash mysql >>\$approved"
    "packageWhich --verbose shasum apt-rdepends"
    "cd ~/build"
  )
  dockerLocalContainer --image "$image" --path /root/build --env-file .STAGING.env /root/build/bin/build/bash-build.sh --rc-extras "${ee[@]}" -- "$@"
}

__buildConfigure
__buildAnnounce

unset __buildConfigure __buildAnnounce
