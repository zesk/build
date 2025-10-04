#!/usr/bin/env bash
#
# Interactivity: Files
#
# Support functions here
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/interactive.md
# Test: ./test/tools/interactive-tests.sh

####################################################################################################
####################################################################################################
#  ▜▘   ▐              ▐  ▗                         ▐
#  ▐ ▛▀▖▜▀ ▞▀▖▙▀▖▝▀▖▞▀▖▜▀ ▄▌ ▌▞▀▖ ▞▀▘▌ ▌▛▀▖▛▀▖▞▀▖▙▀▖▜▀
#  ▐ ▌ ▌▐ ▖▛▀ ▌  ▞▀▌▌ ▖▐ ▖▐▐▐ ▛▀  ▝▀▖▌ ▌▙▄▘▙▄▘▌ ▌▌  ▐ ▖
#  ▀▘▘ ▘ ▀ ▝▀▘▘  ▝▀▘▝▀  ▀ ▀▘▘ ▝▀▘ ▀▀ ▝▀▘▌  ▌  ▝▀ ▘   ▀
####################################################################################################
####################################################################################################

__fileCopy() {
  local handler="$1" && shift

  local mapFlag=false copyFunction="_fileCopyRegular" owner="" mode="" source="" destination=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --map)
      mapFlag=true
      ;;
    --escalate)
      copyFunction=_fileCopyEscalated
      ;;
    --owner)
      shift
      usageArgumentString "$handler" "$argument" "${1-}" || return $?
      owner="$1"
      ;;
    --mode)
      shift
      usageArgumentString "$handler" "$argument" "${1-}" || return $?
      mode="$1"
      ;;
    *)
      local source destination actualSource verb prefix
      source="$1"
      [ -f "$source" ] || __throwEnvironment "$handler" "source \"$source\" does not exist" || return $?
      shift
      destination=$(usageArgumentFileDirectory returnArgument "destination" "${1-}") || return $?
      shift
      [ $# -eq 0 ] || __catchArgument "$handler" "unknown argument $1" || return $?
      if $mapFlag; then
        actualSource=$(fileTemporaryName "$handler")
        if ! mapEnvironment <"$source" >"$actualSource"; then
          rm "$actualSource" || :
          __catchEnvironment "$handler" "Failed to mapEnvironment $source" || return $?
        fi
        verb=" (mapped)"
      else
        actualSource="$source"
        verb=""
      fi
      if [ -f "$destination" ]; then
        if ! diff -q "$destination" "$actualSource" >/dev/null; then
          prefix="$(decorate subtle "$(basename "$source")"): "
          _fileCopyPrompt "$source" "$destination" "Changes" || :
          diff "$destination" "$actualSource" | sed '1d' | decorate code | decorate wrap "$prefix"
          verb="File changed${verb}"
        else
          return 0
        fi
      else
        _fileCopyShowNew "$source" "$actualSource" "$destination" || :
        verb="File created${verb}"
      fi
      "$copyFunction" "$source" "$actualSource" "$destination" "$verb"
      exitCode=$?
      if [ $exitCode -eq 0 ] && [ -n "$owner" ]; then
        __catchEnvironment "$handler" chown "$owner" "$destination" || exitCode=$?
      fi
      if [ $exitCode -eq 0 ] && [ -n "$mode" ]; then
        __catchEnvironment "$handler" chmod "$mode" "$destination" || exitCode=$?
      fi
      if $mapFlag; then
        rm "$actualSource" || :
      fi
      return $exitCode
      ;;
    esac
    shift
  done
  __throwArgument "$handler" "Missing source" || return $?
}

__fileCopyWouldChange() {
  local handler="$1" && shift

  local mapFlag=false source=""
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --map)
      mapFlag=true
      ;;
    *)
      if [ -z "$source" ]; then
        source=$(usageArgumentFile "$handler" "source" "$1") || return $?
      else
        local actualSource destination

        destination=$(usageArgumentFileDirectory "$handler" "destination" "$1") || return $?
        shift
        if [ $# -gt 0 ]; then
          # _IDENTICAL_ argumentUnknownHandler 1
          __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
        fi
        if [ ! -f "$destination" ]; then
          return 0
        fi
        local exitCode=1
        if $mapFlag; then
          actualSource=$(fileTemporaryName "$handler") || return $?
          __catch "$handler" mapEnvironment <"$source" >"$actualSource" || returnClean $? "$actualSource" || return $?
          if ! diff -q "$actualSource" "$destination" >/dev/null; then
            exitCode=0
          fi
          __catchEnvironment "$handler" rm -f "$actualSource" || return $?
        else
          actualSource="$source"
          if ! diff -q "$actualSource" "$destination" >/dev/null; then
            exitCode=0
          fi
        fi
        return "$exitCode"
      fi
      ;;
    esac
    shift
  done
  __throwArgument "$handler" "Missing source" || return $?
}

#
# Usage: _fileCopyEscalated displaySource source destination verb
#
_fileCopyEscalated() {
  decorate reset
  printf "\n%s -> %s: %s\n\n" "$(decorate green "$1")" "$(decorate red "$3")" "$(decorate bold-red "$4")"
  if confirmYesNo --yes "$(printf "%s: %s\n(%s/%s - default %s)? " \
    "$(decorate bold Copy privileged file to)" \
    "$(decorate code "$3")" \
    "$(decorate red Yes)" \
    "$(decorate green No)" "$(decorate red Yes)")"; then
    __execute cp "$2" "$3" || return $?
    return $?
  fi
  printf "%s \"%s\"\n" "$(decorate error "Used declined update of")" "$(decorate red "$3")" 1>&2
  returnArgument || return $?
}

#
# Usage: {fn} displaySource source destination verb
#
# Copy a file with no privilege escalation
#
_fileCopyRegular() {
  local displaySource="$1" source="$2" destination="$3" verb="$4"
  _fileCopyPrompt "OVERRIDE $displaySource" "$destination" "$verb" || :
  __execute cp "$source" "$destination" || return $?
}

_fileCopyPrompt() {
  local source="$1" destination="$2" verb="$3"
  printf "%s -> %s %s\n" "$(decorate green "$source")" "$(decorate red "$destination")" "$(decorate cyan "$verb")"
}

#
# Show a new file which will be added
#
# Usage: {fn} displaySource source destination
# Argument: displaySource - Source path to show
# Argument: source - Actual source path
# Argument: destination - Destination path
_fileCopyShowNew() {
  local displaySource="$1" source="$2" destination="$3"
  local lines
  _fileCopyPrompt "$displaySource" "$destination" "Created"
  head -10 "$source" | decorate code
  lines=$(__catch "$handler" fileLineCount "$source") || lines="0" || :
  decorate info "$(printf "%d %s total" "$lines" "$(plural "$lines" line lines)")"
}
