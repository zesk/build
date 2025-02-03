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
  dataFile="$(dotFilesApproved)" || return 1

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
    if inArray "$base" "${ok[@]+"${ok[@]}"}"; then
      continue
    fi
    if [ -d "$item" ]; then
      base="${base%/}/"
      inArray "$base" "${asked[@]}" && foundDirectories+=("$base") || askDirectories+=("$base")
    elif [ -f "$item" ]; then
      inArray "$base" "${asked[@]}" && foundFiles+=("$base") || askFiles+=("$base")
    else
      decorate warning "Unknown handled dot file type: $(decorate value "$(betterType "$item")")"
      continue
    fi
    unapproved+=("$base")
  done < <(find "$HOME" -name ".*" -maxdepth 1 | sort)

  [ $((${#askFiles[@]} + ${#askDirectories[@]})) -gt 0 ] || return 0

  printf "%s: %s\n" "$(decorate error "New $(plural ${#askFiles[@]} file files)") found" "$(decorate each file "${askFiles[@]}")"
  printf "%s: %s\n" "$(decorate error "New $(plural ${#askDirectories[@]} directory directories)") found" "$(decorate each file "${askDirectories[@]}")"
  [ ${#foundFiles[@]} -eq 0 ] || printf "%s: %s\n" "$(decorate warning "Unknown $(plural ${#foundFiles[@]} file files)")" "$(decorate each file "${foundFiles[@]}")"
  [ ${#foundDirectories[@]} -eq 0 ] || printf "%s: %s\n" "$(decorate warning "Unknown $(plural ${#foundDirectories[@]} directory directories)")" "$(decorate each quote "${foundDirectories[@]}")"

  set -o pipefail
  if confirmYesNo --no --timeout 10 "Approve all?" | tee "$askFile.$$"; then
    printf "%s\n" "${unapproved[@]}" >>"$dataFile"
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

dotFilesApproved() {
  printf "%s\n" "$(buildEnvironmentGetDirectory "XDG_DATA_HOME")/dotFilesWatcher"
}
