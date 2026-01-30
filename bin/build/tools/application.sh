#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs:  ./documentation/source/tools/application.md
# Test: ./test/tools/application-tests.sh

__applicationHomeFile() {
  local f home

  home=$(catchReturn "$handler" buildEnvironmentGetDirectory XDG_STATE_HOME) || return $?
  f="$home/.applicationHome"
  [ -f "$f" ] || catchEnvironment "$handler" touch "$f" || return $?
  printf "%s\n" "$f"
}

__applicationHomeGo() {
  local handler="$1" && shift
  local file home label uHome oldHome=""

  file=$(catchReturn "$handler" __applicationHomeFile) || return $?
  home=$(trimSpace "$(catchEnvironment "$handler" head -n 1 "$file")") || return $?
  if [ -z "$home" ]; then
    throwEnvironment "$handler" "No code home set, try $(decorate code "applicationHome")" || return $?
  fi
  [ -d "$home" ] || throwEnvironment "$handler" "Application home directory deleted $(decorate code "$home")" || return $?

  oldHome=$(catchReturn "$handler" buildHome) || return $?

  if [ -d "$oldHome" ] && [ "$oldHome" != "$home" ]; then
    hookSourceOptional --application "$oldHome" project-deactivate "$home" || :
  fi
  catchEnvironment "$handler" cd "$home" || return $?
  label="Working in"
  if [ $# -gt 0 ]; then
    label="${*-}"
    [ -n "$label" ] || return 0
  fi
  uHome="${HOME%/}"
  printf "%s %s\n" "$(decorate label "$label")" "$(decorate value "${home//"$uHome"/~}")"
  hookSourceOptional --application "$home" project-activate "$oldHome" || :
  return 0
}

#
# Set, or cd to current application home directory.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: directory - Directory. Optional. Set the application home to this directory.
# Argument: --go - Flag. Optional. Change to the current saved application home directory.
applicationHome() {
  local handler="_${FUNCNAME[0]}"

  local here="" home="" buildTools="bin/build/tools.sh"

  export HOME

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --go)
      shift
      __applicationHomeGo "$handler" "$@"
      return 0
      ;;
    *)
      [ -z "$here" ] || throwArgument "$handler" "Unknown argument (applicationHome set already to $(decorate code "$here"))"
      here=$(validate "$handler" Directory "directory" "$argument") || return $?
      ;;
    esac
    shift
  done
  [ -n "$here" ] || here=$(catchEnvironment "$handler" pwd) || return $?
  home=$(bashLibraryHome "$buildTools" "$here" 2>/dev/null) || home="$here"
  printf "%s\n" "$home" >"$(__applicationHomeFile)"
  __applicationHomeGo "$handler" "${__saved[0]-} Application home set to" || return $?
}
_applicationHome() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Set aliases `G` and `g` default for `applicationHome`
# Localize as you wish for your own shell
# Argument: goAlias - String. Alias for `applicationHome --go`. Default is `g`.
# Argument: setAlias - String. Alias for `applicationHome`. Default is `G`.
applicationHomeAliases() {
  local handler="_${FUNCNAME[0]}"
  local goAlias="" setAlias=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$goAlias" ]; then
        goAlias=$(validate "$handler" String "goAlias" "$argument") || return $?
      elif [ -z "$setAlias" ]; then
        setAlias=$(validate "$handler" String "setAlias" "$argument") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$goAlias" ] || goAlias="g"
  [ -n "$setAlias" ] || setAlias="G"

  # shellcheck disable=SC2139
  alias "$goAlias"='applicationHome --go' || throwEnvironment "$handler" "alias $goAlias failed" || return $?
  # shellcheck disable=SC2139
  alias "$setAlias"=applicationHome || throwEnvironment "$handler" "alias $setAlias failed" || return $?
}
_applicationHomeAliases() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Set up a new project for Zesk Build
# - Creates shell development environment
# - Registers git hooks
# - Configures base environment variables
# EXPERIMENTAL - not finished yet.
buildApplicationConfigure() {
  local handler="_${FUNCNAME[0]}"

  local home="" name="" interactive=true code=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --non-interactive) interactive=false ;;
    --name) shift && name="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --code) shift && code="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --path) shift && home="$(validate "$handler" Directory "$argument" "${1-}")" || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local templateHome && templateHome=$(catchReturn "$handler" buildHome) || return $?
  [ -n "$home" ] || home="$templateHome"
  [ -n "$name" ] || throwArgument "$handler" "Requires name" || return $?
  if [ -z "$code" ]; then
    catchReturn "$handler" decorate warning "Using default code $(decorate code "$code")" || return $?
    code="$(catchReturn "$handler" basename "$home")" || return $?
  fi

  __buildApplicationConfigurePaths "$handler" "$home" true || return $?
  __buildApplicationConfigureShellFiles "$handler" "$home" true "$templateHome" || return $?
  APPLICATION_CODE=$code APPLICATION_NAME=$name __buildApplicationConfigureEnvironmentFiles "$handler" "$home" true "$interactive" || return $?

  __buildApplicationConfigurePaths "$handler" "$home" false || return $?
  __buildApplicationConfigureShellFiles "$handler" "$home" false "$templateHome" || return $?
  APPLICATION_CODE=$code APPLICATION_NAME=$name __buildApplicationConfigureEnvironmentFiles "$handler" "$home" false "$interactive" || return $?
}
_buildApplicationConfigure() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__buildApplicationConfigurePaths() {
  local handler="$1" && shift
  local home="$1" && shift
  local preflight="$1" && shift

  local d && for d in bin/env bin/hooks bin/tools etc; do
    local target="$home/$d"
    if $preflight; then
      [ -d "$target" ] || decorate info "Will create $(decorate file "$target")" || return $?
    else
      directoryRequire --handler "$handler" "$home/$d" || return $?
    fi
  done
}

__buildApplicationConfigureEnvironmentFiles() {
  local handler="$1" && shift
  local home="$1" && shift
  local preflight="$1" && shift
  local interactive="$1" && shift

  local envs=(
    APPLICATION_NAME APPLICATION_CODE APPLICATION_CODE_EXTENSIONS APPLICATION_CODE_IGNORE APPLICATION_JSON APPLICATION_JSON_PREFIX BUILD_RELEASE_NOTES
  )
  local e && for e in "${envs[@]}"; do
    local target="$home/bin/env/$e.sh"
    local value="${!e-}"
    if $preflight; then
      [ -f "$target" ] || decorate info "Will create $(decorate file "$target") - current value \"$(decorate code "$value")\"" || return $?
      if [ -z "$value" ]; then
        local type
        local envFileSource && envFileSource="$(catchReturn "$handler" buildEnvironmentFiles --application "$home" "$e" | tail -n 1)" || return $?
        type=$(catchReturn "$handler" bashCommentVariable Type <"$envFileSource") || return $?
        if [ -z "$type" ]; then
          decorate warning "Unable to retrieve type from file $(decorate file "$envFileSource")"
          type="String"
        fi
        if $interactive; then
          local finished=false && while ! $finished; do
            local newEnvValue && newEnvValue=$(bashUserInput -p "$(decorate notice "Value for") $(decorate code "$e")? (type $(decorate value "$type")) ")
            if newEnvValue=$(validate "$type" "$e" "$newEnvValue"); then
              finished=true
              declare -x "$e"="$newEnvValue"
            else
              decorate warning "$newEnvValue is not a valid $(decorate code "$type")"
            fi
          done
        fi
      fi
    else
      catchReturn "$handler" buildEnvironmentAdd --application "$home" "$e" --value "$value" || return $?
    fi
  done
}

__buildApplicationConfigureShellFiles() {
  local handler="$1" && shift
  local home="$1" && shift
  local preflight="$1" && shift
  local templateHome="$1" && shift

  local files=(
    bin/tools.sh
    bin/developer.sh
    bin/tools/__developer.sh
    bin/install-bin-build.sh
  )
  local file target
  if $preflight; then
    for file in "${files[@]}"; do
      target="$home/$file"
      [ -f "$target" ] || decorate info "Will create $(decorate file "$target")" || return $?
    done
  else
    # bin/tools.sh
    file=${files[0]}
    target="$home/$file"
    catchEnvironment "$handler" cp -f "$templateHome/bin/build/identical/application.sh" "$target" || return $?

    # bin/developer.sh
    file=${files[1]}
    target="$home/$file"
    if [ ! -e "$target" ]; then
      catchReturn "$handler" mapEnvironment <"$templateHome/bin/build/developer.sample.sh" >"$target" || return $?
    fi

    # bin/developer.sh
    file=${files[2]}
    target="$home/$file"
    if [ ! -e "$target" ]; then
      catchEnvironment "$handler" cp -f "$templateHome/bin/build/identical/__developer.sh" "$target" || return $?
    fi

    # bin/install-bin-build.sh
    catchReturn "$handler" installInstallBuild "$home/bin" "$home" || return $?
  fi
}
