#!/usr/bin/env bash
#
# Bash Prompt Module: ApplicationPath
#
# Copyright &copy; 2026 Market Acumen, Inc.

__bashPromptModule_dotFilesWatcher() {
  local handler="$1" && shift
  local askFile dataFile

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  askFile="$(buildEnvironmentGetDirectory "XDG_STATE_HOME")/dotFilesWatcher-asked" 2>/dev/null || return 1
  dataFile="$(dotFilesApprovedFile)" || return 1

  for item in dataFile askFile; do
    [ -f "${!item}" ] || touch "${!item}" || returnEnvironment "Can not create $item: ${!item}" || return 1
  done
  [ "$(fileModificationSeconds "$askFile")" -lt 60 ] || printf -- "" >"$askFile"

  local item ok=() asked=()
  while read -r item; do ok+=("$item"); done < <(sort -u "$dataFile")
  while read -r item; do asked+=("$item"); done < <(sort -u "$askFile")

  local unapproved=() askFiles=() askDirectories=() foundFiles=() foundDirectories=()
  while read -r item; do
    local base
    base=$(basename "$item")
    if [ -d "$item" ]; then
      base="${base%/}/"
      if inArray "$base" "${ok[@]+"${ok[@]}"}"; then
        continue
      fi
      inArray "$base" "${asked[@]}" && foundDirectories+=("$base") || askDirectories+=("$base")
    elif [ -f "$item" ]; then
      if inArray "$base" "${ok[@]+"${ok[@]}"}"; then
        continue
      fi
      inArray "$base" "${asked[@]}" && foundFiles+=("$base") || askFiles+=("$base")
    else
      decorate warning "Unknown handled dot file type: $(decorate value "$(fileType "$item")")"
      continue
    fi
    unapproved+=("$base")
  done < <(find "$HOME" -maxdepth 1 -name ".*" | sort)

  [ $((${#askFiles[@]} + ${#askDirectories[@]})) -gt 0 ] || return 0

  [ ${#askFiles[@]} -eq 0 ] || printf "%s: %s\n" "$(decorate error "New $(plural ${#askFiles[@]} file files)") found" "$(decorate each file "${askFiles[@]}")"
  [ ${#askDirectories[@]} -eq 0 ] || printf "%s: %s\n" "$(decorate error "New $(plural ${#askDirectories[@]} directory directories)") found" "$(decorate each file "${askDirectories[@]}")"
  [ ${#foundFiles[@]} -eq 0 ] || printf "%s: %s\n" "$(decorate warning "Unknown $(plural ${#foundFiles[@]} file files)")" "$(decorate each file "${foundFiles[@]}")"
  [ ${#foundDirectories[@]} -eq 0 ] || printf "%s: %s\n" "$(decorate warning "Unknown $(plural ${#foundDirectories[@]} directory directories)")" "$(decorate each quote "${foundDirectories[@]}")"

  set -o pipefail
  if confirmYesNo --no --timeout 3 "Approve?" | tee "$askFile.$$"; then
    printf "%s\n" "${unapproved[@]}" >>"$dataFile"
    if sort -u "$dataFile" >>"$dataFile.sorted"; then
      mv -f "$dataFile.sorted" "$dataFile"
    else
      rm -f "$dataFile.sorted"
    fi
    statusMessage --last decorate success "Approved."
  else
    if grep -q TIMEOUT "$askFile.$$"; then
      statusMessage --last decorate warning "Not approved, will not ask for 1 minute."
      printf "%s\n" "${unapproved[@]}" | sort >"$askFile"
    else
      statusMessage --last decorate error "Not approved."
    fi
  fi
  rm -f "$askFile.$$" || :
}

# The lists
__dotFilesApprovedDefaults() {
  local items=()
  while [ $# -gt 0 ]; do
    case "$1" in
    "bash") items+=(".bash_profile" ".bashrc" ".profile" ".bash_history" ".inputrc" ".ssh/" ".cache/" ".config/" ".local/") ;;
    "git") items+=(".git-credentials" ".gitconfig" ".gitignore_global") ;;
    "darwin") items+=(".DS_Store" ".MacOSX/" ".TemporaryItems/" ".Trash/") ;;
    "mysql") items+=(".my.cnf" ".mylogin.cnf" ".mysql_history") ;;
    esac
    shift
  done
  printf -- "%s\n" "${items[@]}" | sort -u
}

# Lists of dot files which can be added to the dotFilesApprovedFile
__dotFilesApproved() {
  local handler="$1" && shift

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
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    "all")
      __dotFilesApprovedDefaults bash darwin git mysql
      return 0
      ;;
    "bash" | "darwin" | "git" | "mysql")
      __dotFilesApprovedDefaults "$1"
      return 0
      ;;
    *)
      throwArgument "$handler" "Unknown approved list: $1" || return $?
      ;;
    esac
  done
  __dotFilesApprovedDefaults bash
}
