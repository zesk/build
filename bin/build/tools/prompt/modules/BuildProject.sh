#!/usr/bin/env bash
#
# Bash Prompt Module: binBuild
#
# Copyright &copy; 2026 Market Acumen, Inc.

# Check which bin/build we are running and keep local to current project. Activates when we switch between projects.
#
# - Re-sources `bin/build` so versions do not conflict.
# - Runs hook `project-deactivate` in the old project (using that `bin/build` library)
# - Runs the `project-activate` hook in the new project
# - Displays the change in Zesk Build version
#
# Run-Hook: project-activate
# Run-Hook: project-deactivate
bashPromptModule_BuildProject() {
  local handler="_${FUNCNAME[0]}"

  local home here tools="bin/build/tools.sh" version="bin/build/build.json" oldVersion newMessage buildMessage currentVersion
  export HOME

  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

  local home && home=$(catchReturn "$handler" buildHome) || return $?
  local here && here=$(catchReturn "$handler" pwd) || return $?

  if [ "${here#"$home"}" != "$here" ]; then
    return 0
  fi

  local otherHome && otherHome=$(bashLibraryHome "$tools" "$here" 2>/dev/null) || return 0

  [ -x "$home/$tools" ] || return 0
  local oldVersion newVersion newestVersion
  oldVersion="$(jq -r .version "$home/$version")"
  newVersion="$(jq -r .version "$otherHome/$version")"
  newestVersion="$(printf -- "%s\n" "$oldVersion" "$newVersion" | textVersionSort | tail -n 1)"
  if [ "$oldVersion" != "$newVersion" ]; then
    if [ "$oldVersion" = "$newestVersion" ]; then
      buildMessage="$(printf -- "build %s -> %s " "$(decorate green "$oldVersion")" "$(decorate yellow "$newVersion")")"
    else
      buildMessage="$(printf -- "build %s -> %s " "$(decorate blue "$oldVersion")" "$(decorate green "$newVersion")")"
    fi
  fi

  local exitCode=0
  # After deactivate we should assume Zesk Build has been unloaded
  hookSourceOptional --application "$home" project-deactivate "$home" || exitCode=1

  # Assume nothing defined here

  # shellcheck source=/dev/null
  if ! source "$otherHome/$tools"; then
    printf "%s\n" "Failed to load $(decorate file "$otherHome")/$tools" 1>&2
    return 1
  fi

  [ "$exitCode" = 0 ] || returnEnvironment "project-deactivate failed" || :

  # buildHome will be changed here

  catchReturn "$handler" hookSourceOptional --application "$otherHome" project-activate "$home" || returnMessage "project-activate failed in $(decorate file "$otherHome")" || :
  currentVersion="$(hookRunOptional --application "$otherHome" version-current)"

  printf -- "%s %s %s@ %s\n" "$newMessage" "$(decorate code "$currentVersion")" "$buildMessage" "$(decorate code "$(decorate file "$(buildHome)")")"
}
_bashPromptModule_BuildProject() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
