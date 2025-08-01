#!/usr/bin/env bash
#
# Bash Prompt Module: binBuild
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Check which bin/build we are running and keep local to current project. Activates when we switch between projects.
# - Re-sources `bin/build` so versions do not conflict.
# - Runs hook `project-deactivate` in the old project (using that `bin/build` library)
# - Runs the `project-activate` hook in the new project
# - Adds the current project's `bin` directory to the `PATH`
# - Removes the old project's `bin` directory from the `PATH`
# - Displays the change in Zesk Build version
#
# Run-Hook: project-activate
# Run-Hook: project-deactivate
bashPromptModule_binBuild() {
  local home gitHome tools="bin/build/tools.sh" version="bin/build/build.json" oldVersion newMessage buildMessage currentVersion showHome showGitHome
  export HOME

  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

  __environment buildEnvironmentLoad HOME || return $?
  home=$(__environment buildHome) || return $?
  showHome="${home//$HOME/~}"
  gitHome=$(gitFindHome "$(pwd)" 2>/dev/null) || return 0
  [ "$home" != "$gitHome" ] || return 0
  showGitHome="${gitHome//$HOME/~}"
  [ -x "$gitHome/$tools" ] || return 0
  local oldVersion newVersion newestVersion
  oldVersion="$(jq -r .version "$home/$version")"
  newVersion="$(jq -r .version "$gitHome/$version")"
  newestVersion="$(printf -- "%s\n" "$oldVersion" "$newVersion" | versionSort | tail -n 1)"
  if [ "$oldVersion" != "$newVersion" ]; then
    if [ "$oldVersion" = "$newestVersion" ]; then
      buildMessage="$(printf -- "build %s -> %s " "$(decorate green "$oldVersion")" "$(decorate yellow "$newVersion")")"
    else
      buildMessage="$(printf -- "build %s -> %s " "$(decorate blue "$oldVersion")" "$(decorate green "$newVersion")")"
    fi
  fi

  local exitCode=0
  # After deactivate we should assume Zesk Build has been unloaded
  hookSourceOptional --application "$home" project-deactivate "$gitHome" || exitCode=1

  # Assume nothing defined here

  # shellcheck source=/dev/null
  if ! source "$gitHome/$tools"; then
    printf "%s\n" "Failed to load $showGitHome/$tools" 1>&2
    return 1
  fi

  [ "$exitCode" = 0 ] || _environment "project-deactivate failed" || :

  # buildHome will be changed here

  hookSourceOptional --application "$gitHome" project-activate "$home" || _environment "project-activate failed" || :

  currentVersion="$(hookRunOptional --application "$gitHome" version-current)"

  pathSuffix=
  if [ -d "$gitHome/bin" ]; then
    __environment pathConfigure --last "$gitHome/bin" || return $?
    pathSuffix="$pathSuffix +$(decorate cyan "$showGitHome/bin")"
  fi
  if isFunction pathRemove; then
    if [ -d "$home/bin" ]; then
      pathRemove "$home/bin"
      pathSuffix="$pathSuffix -$(decorate magenta "$showHome/bin")"
    fi
  fi
  [ -z "$pathSuffix" ] || pathSuffix=" $(decorate warning "PATH:")$pathSuffix"

  printf -- "%s %s %s@ %s%s\n" "$newMessage" "$(decorate code "$currentVersion")" "$buildMessage" "$(decorate code "$(decorate file "$(buildHome)")")" "$pathSuffix"
}
_bashPromptModule_binBuild() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
