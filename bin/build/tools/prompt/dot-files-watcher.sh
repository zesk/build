#!/usr/bin/env bash
#
# Bash Prompt Module: ApplicationPath
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Watches your HOME directory for `.` files which are added and unknown to you.
#
# Example:     bashPrompt bashPromptModule_dotFilesWatcher
# Requires: sort buildEnvironmentGetDirectory touch _environment read basename inArray decorate printf confirmYesNo statusMessage grep rm
bashPromptModule_dotFilesWatcher() {
  local askFile dataFile

  askFile="$(buildEnvironmentGetDirectory "XDG_STATE_HOME")/dotFilesWatcher-asked" 2>/dev/null || return 1
  dataFile="$(dotFilesApprovedFile)" || return 1

  for item in dataFile askFile; do
    [ -f "${!item}" ] || touch "${!item}" || _environment "Can not create $item: ${!item}" || return 1
  done
  [ "$(modificationSeconds "$askFile")" -lt 60 ] || printf -- "" >"$askFile"

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
      decorate warning "Unknown handled dot file type: $(decorate value "$(betterType "$item")")"
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

# The dot files approved file. Add files to this to approve.
# Environment: XDG_DATA_HOME
dotFilesApprovedFile() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0
  printf "%s\n" "$(buildEnvironmentGetDirectory "XDG_DATA_HOME")/dotFilesWatcher"
}
_dotFilesApprovedFile() {
  ! true || dotFilesApprovedFile --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# The lists
__dotFilesApproved() {
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
# Argument: listType - String. Optional. One of `all`, `bash`, `git`, `darwin`, or `mysql`
# If none specified, returns `bash` list.
# Special value `all` returns all values
dotFilesApproved() {
  local usage="_${FUNCNAME[0]}"

  while [ $# -gt 0 ]; do
    case "$1" in
      "all")
        __dotFilesApproved bash darwin git mysql
        return 0
        ;;
      "bash" | "darwin" | "git" | "mysql")
        __dotFilesApproved "$1"
        return 0
        ;;
      *)
        __throwArgument "$usage" "Unknown approved list: $1" || return $?
        ;;
    esac
  done
  __dotFilesApproved bash
}
_dotFilesApproved() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
