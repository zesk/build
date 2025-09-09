#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# The dot files approved file. Add files to this to approve.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
dotFilesApprovedFile() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf "%s\n" "$(buildEnvironmentGetDirectory "XDG_DATA_HOME")/dotFilesWatcher"
}
_dotFilesApprovedFile() {
  true || dotFilesApprovedFile --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Lists of dot files which can be added to the dotFilesApprovedFile
# Argument: listType - String. Optional. One of `all`, `bash`, `git`, `darwin`, or `mysql`
# If none specified, returns `bash` list.
# Special value `all` returns all values
dotFilesApproved() {
  local handler="_${FUNCNAME[0]}"

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
    "all")
      __dotFilesApproved bash darwin git mysql
      return 0
      ;;
    "bash" | "darwin" | "git" | "mysql")
      __dotFilesApproved "$1"
      return 0
      ;;
    *)
      __throwArgument "$handler" "Unknown approved list: $1" || return $?
      ;;
    esac
  done
  __dotFilesApproved bash
}
_dotFilesApproved() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
