#!/usr/bin/env bash
#
# Bash Prompt Tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/prompt.md
# Test: ./test/tools/prompt-tests.sh

__bashPromptList() {
  local promptCommand

  for promptCommand in "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}"; do
    if isFunction "$promptCommand"; then
      printf -- "- %s (%s)\n" "$(decorate code "$promptCommand")" "$(decorate orange "function")"
    else
      printf -- "- %s (%s)\n" "$(decorate value "$promptCommand")" "$(decorate blue "file")"
    fi
  done
}

# Usage: {fn} [ --first | --last | module ]
# Argument: --first - Flag. Optional. All subsequent modules are added first to the list.
# Argument: --last - Flag. Optional. ALl subsequent modules are added to the end of the list.
# Argument: module - Callable. Required. The module to add
__bashPromptAdd() {
  local usage="$1" && shift
  local argument nArguments argumentIndex saved
  local first=false debug=false verbose=false found

  export __BASH_PROMPT_MODULES
  if ! isArray "__BASH_PROMPT_MODULES"; then
    __BASH_PROMPT_MODULES=()
  fi

  ! $debug || decorate info "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}")"
  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      --verbose)
        verbose=true
        ;;
      --debug)
        debug=true
        ;;
      --first)
        first=true
        ;;
      --last)
        first=false
        ;;
      *)
        isCallable "$argument" || __failArgument "$usage" "$argument must be executable or a function" || return $?
        found=false
        ! inArray "$argument" "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}" || found=true
        if $first; then
          ! $debug || decorate info "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
          if $found; then
            if [ "${__BASH_PROMPT_MODULES[0]-}" != "$argument" ]; then
              return 0
            fi
            __bashPromptRemove "$usage" "$argument" || return $?
            ! $debug || decorate info "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
            ! $verbose || decorate info "Moving bash module to first: $(decorate code "$argument")"
          else
            ! $verbose || decorate info "Added bash module: $(decorate code "$argument")"
          fi
          __BASH_PROMPT_MODULES=("$argument" "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}")
        else
          ! $debug || decorate info "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
          if $found; then
            if [ "${__BASH_PROMPT_MODULES[${#__BASH_PROMPT_MODULES[@]} - 1]}" != "$argument" ]; then
              return 0
            fi
            __bashPromptRemove "$usage" "$argument" || return $?
            ! $debug || decorate info "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
            ! $verbose || decorate info "Moving bash module to last: $(decorate code "$argument")"
          else
            ! $verbose || decorate info "Added bash module: $(decorate code "$argument")"
          fi
          __BASH_PROMPT_MODULES=("${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}" "$argument")
        fi
        ! $debug || decorate info "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  ! $debug || decorate info "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
  return 0
}

# Usage: {fn} usageFunction removeModule
# Fails if not found
__bashPromptRemove() {
  local usage="$1" module="$2" current modules=() found=false

  export __BASH_PROMPT_MODULES
  if ! isArray "__BASH_PROMPT_MODULES"; then
    __BASH_PROMPT_MODULES=()
  fi
  for current in "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}"; do
    if [ "$module" = "$current" ]; then
      found=true
    else
      modules+=("$current")
    fi
  done
  $found || __failEnvironment "$usage" "$module was not found in $(_list modules: "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}")" || return $?
  __BASH_PROMPT_MODULES=("${modules[@]+"${modules[@]}"}")
}

#
# Show current application and path as a badge
#
bashPromptModule_ApplicationPath() {
  local folderIcon="📂"
  local path applicationPath
  path=$(__environment pwd) || return $?
  applicationPath=$(decoratePath "$path")
  if [ "$applicationPath" != "$path" ]; then
    iTerm2Badge -i "$(printf -- "%s\n%s %s\n" "$(buildEnvironmentGet APPLICATION_NAME)" "$folderIcon" "$applicationPath")"
  fi
}

#
# Check which bin/build we are running and keep local to current project
# When changing projects, runs the `project-activate` hook in the new project
# Also shows the change in Zesk Build version numbers
#
# Run-Hook: project-activate
bashPromptModule_binBuild() {
  local home gitHome tools="bin/build/tools.sh" version="bin/build/build.json" oldVersion oldMessage newMessage buildMessage currentVersion showHome showGitHome
  export HOME

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

  oldMessage="$(runOptionalHook --application "$home" project-deactivate "$gitHome")" || oldMessage="$home: $(decorate error project-deactivate FAILED): $?" || :
  [ -z "$oldMessage" ] || printf -- "%s @ %s" "$oldMessage" "$(decorate code "$home")"
  # shellcheck source=/dev/null
  source "$gitHome/$tools" || __environment "Failed to load $showGitHome/$tools" || return $?
  # buildHome will be changed here

  newMessage="$(runOptionalHook --application "$home" project-activate "$home")"
  currentVersion="$(runOptionalHook --application "$gitHome" version-current)"

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

# Usage: {fn} [ --first | --last | module ] [ --colors colorsText ]
# Argument: --reset - Flag. Optional. Remove all prompt modules.
# Argument: --list - Flag. Optional. List the current modules.
# Argument: --first - Flag. Optional. Add all subsequent modules first to the list.
# Argument: --last - Flag. Optional. Add all subsequent modules last to the list.
# Argument: module - String. Optional. Module to enable or disable. To disable, specify `-module`
# Argument: --colors colorsText - String. Optional. Set the prompt colors
# Argument: --skip-terminal - Flag. Optional. Skip the check for a terminal attached to standard in.
# Bash prompt creates a prompt and adds return code status display and modules
# Modules are any binary or executable to run each prompt, and can be added or removed here
# - `consoleDefaultTitle`
# Example: bashPrompt --colors "$(decorate bold-cyan):$(decorate bold-magenta):$(decorate green):$(decorate orange):$(decorate code)"
bashPrompt() {
  local usage="_${FUNCNAME[0]}"

  local saved=("$@") nArguments=$#
  local label=$'\0' addArguments=() colorsText="" resetFlag=false verbose=false skipTerminal=false
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --label)
        shift
        label="$(usageArgumentEmptyString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --list)
        # IDENTICAL bashPromptAddArguments 3
        if [ ${#addArguments[@]} -gt 0 ]; then
          __bashPromptAdd "$usage" "${addArguments[@]+"${addArguments[@]}"}" || return $?
        fi
        addArguments=()
        __bashPromptList
        ;;
      --skip-terminal)
        skipTerminal=true
        ;;
      --reset)
        resetFlag=true
        ;;
      --colors)
        shift
        colorsText="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        local colors
        IFS=":" read -r -a colors <<<"$colorsText" || :
        [ "${#colors[@]}" -ge 2 ] || __failArgument "$usage" "$argument should be min 2 colors separated by a colon: $(decorate code "$colorsText")" || return $?
        [ "${#colors[@]}" -le 5 ] || __failArgument "$usage" "$argument should be max 5 colors separated by a colon: $(decorate code "$colorsText")" || return $?
        ;;
      --first | --last | --debug)
        addArguments+=("$argument")
        ;;
      --verbose)
        verbose=true
        addArguments+=("$argument")
        ;;
      *)
        if [ "${argument#-}" != "$argument" ]; then
          __bashPromptRemove "$usage" "${argument#-}" || return $?
        else
          addArguments+=("$argument")
        fi
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  $skipTerminal || [ -t 0 ] || __failEnvironment "$usage" "Requires a terminal" || return $?

  export PROMPT_COMMAND PS1 __BASH_PROMPT_PREVIOUS __BASH_PROMPT_MODULES BUILD_PROMPT_COLORS

  if $resetFlag; then
    __BASH_PROMPT_MODULES=()
    ! $verbose || decorate info "Prompt modules reset to empty list."
  fi
  # IDENTICAL bashPromptAddArguments 3
  if [ ${#addArguments[@]} -gt 0 ]; then
    __bashPromptAdd "$usage" "${addArguments[@]+"${addArguments[@]}"}" || return $?
  fi

  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_PROMPT_COLORS || return $?

  [ -z "$colorsText" ] || BUILD_PROMPT_COLORS="${colorsText}"
  [ -n "${BUILD_PROMPT_COLORS-}" ] || BUILD_PROMPT_COLORS="$(bashPromptColorScheme default)"

  PROMPT_COMMAND=__bashPromptCommand
  isArray __BASH_PROMPT_PREVIOUS || __BASH_PROMPT_PREVIOUS=()
  if [ "$label" != $'\0' ]; then
    label="$label "
    __BASH_PROMPT_PREVIOUS=("${__BASH_PROMPT_PREVIOUS[0]-}" "$label")
  fi
  PS1="$(__bashPromptGeneratePS1)"
}
_bashPrompt() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Color schemes for prompts
# Options are:
# - forest
# - default
bashPromptColorScheme() {
  local colors
  case "$1" in
    forest) colors="$(decorate bold-cyan):$(decorate bold-magenta):$(decorate green):$(decorate orange):$(decorate code)" ;;
    *) colors="$(decorate green):$(decorate red):$(decorate magenta):$(decorate blue):$(decorate bold-black)" ;;
  esac
  printf -- "%s" "$colors"
}

# Prompt is the following literal tokens concatenated:
# - user
# - "@"
# - host
# - " "
# - CWD
# - " "
# - exit status ">" or "X"
# - " "
__bashPromptGeneratePS1() {
  local colors reset
  export BUILD_PROMPT_COLORS __BASH_PROMPT_PREVIOUS
  reset="$(decorate reset)"
  IFS=":" read -r -a colors <<<"${BUILD_PROMPT_COLORS-}" || :
  printf -- "%s%s@%s %s %s " \
    "\${__BASH_PROMPT_PREVIOUS[1]-}" \
    "\[${colors[2]-}\]\u\[${reset}\]" \
    "\[${colors[3]-}\]\h" \
    "\[${colors[4]-}\]\w\[${reset}\]" \
    "\[\${__BASH_PROMPT_PREVIOUS[2]-}\]\${__BASH_PROMPT_PREVIOUS[3]-}\[${reset}\]"
}
__bashPromptCommand() {
  __BASH_PROMPT_PREVIOUS=("$?" "${__BASH_PROMPT_PREVIOUS[1]-}")
  local colors promptCommand
  export BUILD_PROMPT_COLORS
  IFS=":" read -r -a colors <<<"${BUILD_PROMPT_COLORS-}" || :
  if [ "${__BASH_PROMPT_PREVIOUS[0]}" -eq 0 ]; then
    __BASH_PROMPT_PREVIOUS+=("${colors[0]-}")
    __BASH_PROMPT_PREVIOUS+=(">")
  else
    __BASH_PROMPT_PREVIOUS+=("${colors[1]-}")
    __BASH_PROMPT_PREVIOUS+=("§")
  fi
  for promptCommand in "${__BASH_PROMPT_MODULES[@]}"; do
    if isFunction "$promptCommand"; then
      "$promptCommand"
    else
      # shellcheck source=/dev/null
      . "$promptCommand"
    fi
  done
}
