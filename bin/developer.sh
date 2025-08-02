#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Developer scripts

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/tools.sh"; then

  # This has limited usage aside from the image stuff currently, can add it to core if needed
  # Argument: count - UnsignedInteger. Required. Number of character to skip on each line.
  # Argument: text - String. Optional. Text to output, each argument is one per line.
  __decorateExtensionSkip() {
    local handler="_${FUNCNAME[0]}"
    local count="${1-}"
    shift && isUnsignedInteger "$count" || __throwArgument "$handler" "Integer count required: $count" || retyrn $?
    __executeInputSupport "$handler" __decorateExtensionMoveRelative "$handler" "$count" -- "$@" || return $?
  }
  ___decorateExtensionSkip() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __decorateExtensionMoveRelative() {
    local handler="$1" && shift
    local count="$1" && shift
    local curX curY
    IFS=$'\n' read -r -d '' curX curY < <(cursorGet) || :
    while [ $# -gt 0 ]; do
      __catch "$handler" cursorSet "$((curX + count))" "$curY" && printf -- "%s\n" "$1" && curY=$((curY + 1)) || return $?
      shift
    done
  }

  # Configure your shell for build developer
  # Adds some aliases (t, tools, IdenticalRepair), adds a bash prompt
  # and shell completions, terminal colors, and outputs banner and shows new functions
  __buildConfigure() {
    local imageLineHeight=10 imageColumnWidth=25
    local handler="_${FUNCNAME[0]}"
    local home

    home=$(__catch "$handler" buildHome) || return $?

    bashDebugInterruptFile --interrupt --error
    local skipWidth=0
    # Logo for iTerm2
    if isiTerm2; then
      local curX curY

      if iTerm2Image "$home/etc/zesk-build-icon.png"; then
        : "Icon output"
      fi
      IFS=$'\n' read -r -d '' curX curY < <(cursorGet) || :
      [ "$curY" -ge $imageLineHeight ] || curY=$imageLineHeight
      cursorSet "1" "$((curY - imageLineHeight))"
      skipWidth="$imageColumnWidth"
      : "$curX" is ignored
    fi

    # Title
    local name
    name=$(__catch "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -n "$name" ] || name=$(basename "$home")
    title="$name $(__catch "$handler" hookVersionCurrent)" || return $?
    bigText --bigger "$title" | decorate skip "$skipWidth"

    # shellcheck disable=SC2139
    alias t="$home/bin/build/tools.sh"
    alias tools=t
    # shellcheck disable=SC2139
    alias IdenticalRepair="$home/bin/build/identical-repair.sh"

    printf "%s" "$(decorate warning "Watching ")"
    reloadChanges --name "$name" bin/build/tools.sh bin/build/tools
    buildCompletion

    bashPrompt --skip-prompt bashPromptModule_TermColors

    pathConfigure --last "$home/bin" "$home/bin/build"

    # developerAnnounce < <(developerTrack)

    export BUILD_PROJECT_DEACTIVATE=__buildConfigureUndo
  }
  ___buildConfigure() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __buildConfigureUndo() {
    local handler="_return"
    local home

    home=$(__catch "$handler" buildHome) || return $?

    local name
    name=$(__catch "$handler" directoryChange "$home" buildEnvironmentContext buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -n "$name" ] || name=$(basename "$home")

    statusMessage decorate notice "Deactivating $name ..."

    pathRemove "$home/bin" "$home/bin/build"

    developerUndo < <(developerTrack)

    unset __buildConfigureUndo 2>/dev/null
  }

  __buildConfigure

  unset __buildConfigure
else
  printf "%s\n" "Loading ${BASH_SOURCE[0]%/*}/tools.sh failed" 1>&2
  false
fi
