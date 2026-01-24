#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Summary: Display file paths and replace prefixes with icons
# Replace an absolute path prefix with an icon if it matches `HOME`, `BUILD_HOME` or `TMPDIR`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --path pathName=icon - Flag. Optional. Add an additional path mapping to icon.
# Argument: --no-app - Flag. Optional. Do not map `BUILD_HOME`.
# Argument: --skip-app - Flag. Optional. Synonym for `--no-app`.
# Argument: path - String. Path to display and replace matching paths with icons.
# Icons used:
# - 💣 - `TMPDIR`
# - 🍎 - `BUILD_HOME`
# - 🏠 - `HOME`
# Environment: TMPDIR
# Environment: BUILD_HOME
# Environment: HOME
decoratePath() {
  local handler="_${FUNCNAME[0]}"
  local skipApp=false
  local mapping=() items=()
  local path icon

  # _IDENTICAL_ argumentBlankLoopHandler 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --skip-app | --no-app) skipApp=true ;;
    --path)
      path="${argument%%=*}"
      icon="${argument#*=}"
      [ -n "$icon" ] || throwArgument "$handler" "Invalid path, must be in the form \`path=icon\`" || return $?
      mapping=("$path" "$icon" "${mapping[@]+"${mapping[@]}"}")
      ;;
    *) items+=("$argument") ;;
    esac
    shift
  done
  [ "${#items[@]}" -gt 0 ] || return 0

  export HOME BUILD_HOME TMPDIR

  [ -z "${TMPDIR-}" ] || mapping+=("$TMPDIR" "💣")
  $skipApp || [ -z "${BUILD_HOME-}" ] || mapping+=("$BUILD_HOME" "🍎")
  [ -z "${HOME-}" ] || mapping+=("$HOME" "🏠")
  for item in "${items[@]}"; do
    set -- "${mapping[@]}"
    while [ $# -gt 1 ]; do
      item="${item//$1/$2}"
      shift 2
    done
    [ -z "$item" ] || printf "%s\n" "$item"
  done
}
_decoratePath() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
