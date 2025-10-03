#!/usr/bin/env bash
#
# Bash Prompt Tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/prompt.md
# Test: ./test/tools/prompt-tests.sh

__bashPrompt() {
  local handler="$1" && shift

  local addArguments=() resetFlag=false verbose=false listFlag=false skipPrompt=false

  export __BASH_PROMPT_PREVIOUS

  isArray __BASH_PROMPT_PREVIOUS || __BASH_PROMPT_PREVIOUS=()

  local colorsText=""
  local promptFormat="" successPrompt="${__BASH_PROMPT_PREVIOUS[0]-}" failurePrompt="${__BASH_PROMPT_PREVIOUS[1]-}" colorsTextFormatted="${__BASH_PROMPT_PREVIOUS[2]-}" label="${__BASH_PROMPT_PREVIOUS[3]-}"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --success)
      shift
      successPrompt=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --failure)
      shift
      failurePrompt=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --label)
      shift
      label="$(usageArgumentEmptyString "$handler" "$argument" "${1-}")" || return $?
      [ -z "$label" ] || label="$label "
      ;;
    --list)
      listFlag=true
      ;;
    --format)
      shift
      promptFormat=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --remove)
      shift
      local module
      module=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      __bashPromptRemove "$handler" "$module" || return $?
      ;;
    --skip-prompt)
      skipPrompt=true
      ;;
    --reset)
      resetFlag=true
      ;;
    --colors)
      shift
      colorsText="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      local colors
      IFS=":" read -r -a colors <<<"$colorsText" || :
      [ "${#colors[@]}" -ge 2 ] || __throwArgument "$handler" "$argument should be min 2 colors separated by a colon: $(decorate code "$colorsText")" || return $?
      [ "${#colors[@]}" -le 5 ] || __throwArgument "$handler" "$argument should be max 5 colors separated by a colon: $(decorate code "$colorsText")" || return $?
      colorsTextFormatted=$(bashPromptColorsFormat "${colorsText}")
      ;;
    --first | --last | --debug)
      addArguments+=("$argument")
      ;;
    --order)
      shift
      order=$(usageArgumentUnsignedInteger "$handler" "$argument" "${1-}") || return $?
      addArguments+=("$argument" "$order")
      ;;
    --verbose)
      verbose=true
      ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      addArguments+=("$(usageArgumentCallable "$handler" "module" "$argument")") || return $?
      ;;
    esac
    shift
  done

  if [ ${#addArguments[@]} -gt 0 ]; then
    __bashPromptAdd "$handler" "${addArguments[@]+"${addArguments[@]}"}" || return $?
  fi

  if $listFlag; then
    __bashPromptList
    return 0
  fi

  if [ -z "$successPrompt" ] || $resetFlag; then
    successPrompt=">"
  fi
  if [ -z "$failurePrompt" ] || $resetFlag; then
    failurePrompt=" §" # Space for code
  fi
  if [ -z "$promptFormat" ] || $resetFlag; then
    promptFormat="{label}{user}@{host} {directory} {return}{status} "
  fi

  export PROMPT_COMMAND PS1 __BASH_PROMPT_PREVIOUS __BASH_PROMPT_MODULES BUILD_PROMPT_COLORS

  if $resetFlag; then
    __BASH_PROMPT_MODULES=()
    addArguments=()
    ! $verbose || decorate info "Prompt modules reset to empty list."
  fi

  if [ -z "$colorsTextFormatted" ] || $resetFlag; then
    if ! $resetFlag; then
      __catch "$handler" buildEnvironmentLoad BUILD_PROMPT_COLORS || return $?
      [ -z "${BUILD_PROMPT_COLORS-}" ] || colorsText="$BUILD_PROMPT_COLORS"
    fi
    if $resetFlag || [ -z "$colorsText" ]; then
      colorsText=$(bashPromptColorScheme default)
    fi
    colorsTextFormatted=$(bashPromptColorsFormat "${colorsText}")
  fi

  local colors=()
  IFS=":" read -r -a colors <<<"$colorsTextFormatted"

  isArray __BASH_PROMPT_PREVIOUS || __BASH_PROMPT_PREVIOUS=()
  __BASH_PROMPT_PREVIOUS=("$successPrompt" "$failurePrompt" "$colorsTextFormatted" "$label" 0 "${colors[0]}" "$successPrompt" "")

  # Skip prompt on time
  ! $skipPrompt || return 0

  local theCommand="__bashPromptCommand"
  if [ -n "${PROMPT_COMMAND-}" ] && [ "${PROMPT_COMMAND#*"$theCommand"}" = "$PROMPT_COMMAND" ]; then
    local commands=() command updated=()
    IFS=";" read -r -a commands <<<"${PROMPT_COMMAND-}"
    updated=("$theCommand")
    for command in "${commands[@]}"; do
      command=$(trimSpace "$command")
      if [ "$command" = "$theCommand" ]; then
        continue
      fi
      updated+=("$command")
    done
    PROMPT_COMMAND="$(listJoin ";" "${updated[@]}")"
  else
    PROMPT_COMMAND="$theCommand"
  fi
  export PS1
  PS1="$(__bashPromptFormat "$promptFormat" "$colorsTextFormatted")"
  export __BASH_PROMPT_SKIP_FIRST=true
}

# Requires: isArray
# Environment: __BASH_PROMPT_MODULES
# Environment: __BASH_PROMPT_PREVIOUS
__bashPromptSanity() {
  export __BASH_PROMPT_MODULES __BASH_PROMPT_PREVIOUS
  if ! isArray "__BASH_PROMPT_MODULES"; then
    __BASH_PROMPT_MODULES=()
  fi
  if ! isArray "__BASH_PROMPT_PREVIOUS"; then
    __BASH_PROMPT_PREVIOUS=()
  fi
}

# Requires: isFunction printf decorate
__bashPromptList() {
  local promptCommand

  __bashPromptSanity

  for promptCommand in "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}"; do
    local order=${promptCommand%%:*}
    promptCommand=${promptCommand#[0-9]*:}
    if isFunction "$promptCommand"; then
      printf -- "- %s (%s) %s\n" "$(decorate code "$promptCommand")" "$(decorate orange "function")" "$(decorate subtle "[$order]")"
    else
      printf -- "- %s (%s) %s\n" "$(decorate value "$promptCommand")" "$(decorate blue "file")" "$(decorate subtle "[$order]")"
    fi
  done
}

# Usage: {fn} [ --first | --last | module ]
# Argument: --first - Flag. Optional. All subsequent modules are added first to the list.
# Argument: --last - Flag. Optional. ALl subsequent modules are added to the end of the list.
# Argument: --order ordering - UnsignedInteger. Ordering of the prompt call. 0 is first, higher numbers are last. Capped at 99.
# Argument: module - Callable. Required. The module to add
__bashPromptAdd() {
  local handler="$1" && shift

  local order=50

  __bashPromptSanity

  export __BASH_PROMPT_MODULES
  local modules=("${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}")

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --order)
      shift
      order=$(usageArgumentUnsignedInteger "$handler" "$argument" "${1-}") || return $?
      [ "$order" -gt 0 ] || order=0
      [ "$order" -lt 99 ] || order=99
      ;;
    --first)
      order=0
      ;;
    --last)
      order=99
      ;;
    *)
      local module mm=()
      for module in "${modules[@]+"${modules[@]}"}"; do
        [ "${argument}" = "${module#[0-9]*:}" ] || mm+=("$module")
      done
      modules=("${mm[@]+"${mm[@]}"}" "$order:$argument")
      ;;
    esac
    shift
  done

  __catch "$handler" __bashPromptModulesSave "${modules[@]}" || return $?
  return 0
}

__bashPromptModulesSave() {
  export __BASH_PROMPT_MODULES
  IFS=$'\n' read -d '' -r -a __BASH_PROMPT_MODULES < <(printf "%s\n" "$@" | sort -n | sort -u) || :
}

# Usage: {fn} usageFunction removeModule
# Fails if not found
# Requires: isArray read inArray decorate listJoin
__bashPromptRemove() {
  local handler="$1" module="$2" current modules=() found=false

  __bashPromptSanity

  for current in "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}"; do
    if [ "$module" = "${current#[0-9]*:}" ]; then
      found=true
    else
      modules+=("$current")
    fi
  done

  if ! $found; then
    local moduleList
    [ "${#__BASH_PROMPT_MODULES[@]}" -eq 0 ] && moduleList="$(decorate warning none)" || moduleList=$(decorate each code "${__BASH_PROMPT_MODULES[@]}")
    __throwEnvironment "$handler" "$module was not found in modules: $moduleList" || return $?
  fi
  __BASH_PROMPT_MODULES=("${modules[@]+"${modules[@]}"}")
}

#
__bashPromptFormat() {
  local formatString="${1-}" && shift || returnArgument "${FUNCNAME[0]}:$LINENO" || return $?
  local colorsTextFormatted="${1-}" && shift || returnArgument "${FUNCNAME[0]}:$LINENO" || return $?

  if [ -n "$formatString" ]; then
    while read -r token replacement && [ "${formatString#*{}" != "$formatString" ]; do
      formatString=$(stringReplace "{${token}}" "$replacement" "$formatString")
    done < <(__bashPromptCode "$colorsTextFormatted")
  fi
  printf -- "%s%s%s" "\[\${__BASH_PROMPT_MARKERS[0]-}\]" "$formatString" "\[\${__BASH_PROMPT_MARKERS[1]-}\]"
}

# Internal documentation - do not depend on this external of this file:
#
# __BASH_PROMPT_PREVIOUS[0] - successText
# __BASH_PROMPT_PREVIOUS[1] - failureText
# __BASH_PROMPT_PREVIOUS[2] - colors
# __BASH_PROMPT_PREVIOUS[3] - label
# __BASH_PROMPT_PREVIOUS[4] - return code
# __BASH_PROMPT_PREVIOUS[5] - return color
# __BASH_PROMPT_PREVIOUS[6] - return text
# __BASH_PROMPT_PREVIOUS[7] - return string

__bashPromptHideEscapes() {
  printf -- "\[%s\]%s\[%s\]" "$1" "$2" "$3"
}

# Environment: __BASH_PROMPT_PREVIOUS
__bashPromptCode() {
  local colors=() reset colorFormat="${1-}" && shift || return $?
  reset="$(decorate reset --)"
  IFS=":" read -r -a colors <<<"$colorFormat" || :
  printf "%s %s\n" \
    "$" "$(__bashPromptHideEscapes "\${__BASH_PROMPT_PREVIOUS[5]-}" "\$" "$reset")" \
    "code" "$(__bashPromptHideEscapes "\${__BASH_PROMPT_PREVIOUS[5]-}" "\${__BASH_PROMPT_PREVIOUS[4]#0}" "$reset")" \
    "return" "$(__bashPromptHideEscapes "\${__BASH_PROMPT_PREVIOUS[5]-}" "\${__BASH_PROMPT_PREVIOUS[7]}" "$reset")" \
    "status" "$(__bashPromptHideEscapes "\${__BASH_PROMPT_PREVIOUS[5]-}" "\${__BASH_PROMPT_PREVIOUS[6]-}" "$reset")" \
    "label" "\${__BASH_PROMPT_PREVIOUS[3]-}" \
    "user" "$(__bashPromptHideEscapes "${colors[2]-}" "\u" "$reset")" \
    "host" "$(__bashPromptHideEscapes "${colors[3]-}" "\h" "$reset")" \
    "directory" "$(__bashPromptHideEscapes "${colors[4]-}" "\w" "$reset")" \
    "reset" "\[$reset\]"
}

__bashPromptReturnValue() {
  return "$1"
}

# This is the main command running each command prompt
__bashPromptCommand() {
  local exitCode=$?

  export __BASH_PROMPT_PREVIOUS

  # Index 0 1 2 3 4
  __BASH_PROMPT_PREVIOUS=("${__BASH_PROMPT_PREVIOUS[0]-}" "${__BASH_PROMPT_PREVIOUS[1]-}" "${__BASH_PROMPT_PREVIOUS[2]-}" "${__BASH_PROMPT_PREVIOUS[3]-}" "$exitCode")
  local colors
  IFS=":" read -r -a colors <<<"${__BASH_PROMPT_PREVIOUS[2]-}" || :
  if [ "$exitCode" -eq 0 ]; then
    # Index 5 - color
    __BASH_PROMPT_PREVIOUS+=("${colors[0]-}")
    # Index 6 - text
    __BASH_PROMPT_PREVIOUS+=("${__BASH_PROMPT_PREVIOUS[0]-}")
    # Index 7 - code text
    __BASH_PROMPT_PREVIOUS+=("")
  else
    # Index 5 - color
    __BASH_PROMPT_PREVIOUS+=("${colors[1]-}")
    # Index 6 - text
    __BASH_PROMPT_PREVIOUS+=("${__BASH_PROMPT_PREVIOUS[1]-}")
    # Index 7 - code text
    __BASH_PROMPT_PREVIOUS+=("$(exitString "$exitCode")")
  fi

  local debug=false
  ! buildDebugEnabled bashPrompt || debug=true

  if [ "${__BASH_PROMPT_SKIP_FIRST-}" = "true" ]; then
    unset __BASH_PROMPT_SKIP_FIRST
    ! $debug || statusMessage decorate warning "Skipping first run"
    return $exitCode
  fi

  ! $debug || statusMessage decorate warning "Running $(decorate each --count code "${__BASH_PROMPT_MODULES[@]}") "

  local promptCommand start
  for promptCommand in "${__BASH_PROMPT_MODULES[@]}"; do
    promptCommand="${promptCommand#[0-9]*:}"
    if isFunction "$promptCommand"; then
      ! $debug || statusMessage decorate warning "Running $(decorate code "$promptCommand") "
      start=$(timingStart)
      set +e
      __bashPromptReturnValue "$exitCode"
      "$promptCommand"
      ! $debug || timingReport "$start"
    else
      ! $debug || statusMessage decorate warning "Sourcing $(decorate code "$promptCommand")"
      start=$(timingStart)
      # shellcheck source=/dev/null
      . "$promptCommand"
      ! $debug || timingReport "$start"
    fi
  done
  return $exitCode
}
