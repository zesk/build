#!/bin/bash
#
# Tools for writing your own deprecated.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

#
# Take a deprecated.txt file and add a comment with the current version number to the top
# Argument: target - File. Required. File to update.
# Argument: version - String. Required. Version to place at the top of the file.
deprecatedFilePrependVersion() {
  local usage="_${FUNCNAME[0]}"

  local target="" version=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ -z "$target" ]; then
          target="$(usageArgumentFile "$usage" "target" "${1-}")" || return $?
        elif [ -z "$version" ]; then
          version="$(usageArgumentString "$usage" "version" "$1")" || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$target" ] || __throwArgument "$usage" "Missing target" || return $?
  [ -n "$version" ] || __throwArgument "$usage" "Missing version" || return $?

  local newTarget

  newTarget=$(fileTemporaryName "$usage") || _clean $? "$newTarget" || return $?
  __catchEnvironment "$usage" printf -- "%s\n\n" "# $version" >"$newTarget" || _clean $? "$newTarget" || return $?
  __catchEnvironment "$usage" cat "$target" >>"$newTarget" || _clean $? "$newTarget" || return $?
  __catchEnvironment "$usage" mv -f "$newTarget" "$target" || _clean $? "$newTarget" || return $?
}
_deprecatedFilePrependVersion() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a list of tokens for `find` to ignore in deprecated calls
# Skips dot directories and release notes by default and any file named `deprecated.sh` `deprecated.txt` or `deprecated.md`.
#
# Environment: BUILD_RELEASE_NOTES
deprecatedIgnore() {
  local usage="_${FUNCNAME[0]}"
  local notes

  export __BUILD_DEPRECATED_EXTRAS

  isArray __BUILD_DEPRECATED_EXTRAS || __BUILD_DEPRECATED_EXTRAS=()

  notes=$(__catchEnvironment "$usage" buildEnvironmentGet BUILD_RELEASE_NOTES) || return $?
  if [ -z "$notes" ]; then
    __throwEnvironment "$usage" "BUILD_RELEASE_NOTES is blank?" || return $?
  fi
  # Trim extra stuff from release notes partial path
  notes="${notes#.}"
  notes="${notes#/}"
  notes="${notes%/}"
  printf -- "%s\n" \
    ! -name 'deprecated*.txt' \
    ! -name 'deprecated.sh' \
    ! -name 'deprecated*.md' \
    ! -name 'unused.md' \
    ! -path "*$notes/*" \
    ! -path "*/.*/*" \
    "${__BUILD_DEPRECATED_EXTRAS[@]+"${__BUILD_DEPRECATED_EXTRAS[@]}"}"
}
_deprecatedIgnore() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run deprecated tokens file search
deprecatedTokensFile() {
  local usage="_${FUNCNAME[0]}"

  local findArgumentFunction="" files=() cannonPath=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --path)
        shift
        cannonPath=$(usageArgumentDirectory "$usage" "$argument cannonPath" "${1-}") || return $?
        ;;
      *)
        if [ -z "$findArgumentFunction" ]; then
          findArgumentFunction=$(usageArgumentFunction "$usage" "ignoreFunction" "$1") || return $?
        else
          files+=("$(usageArgumentFile "$usage" "cannonFile" "$1")") || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$findArgumentFunction" ] || __throwArgument "$usage" "findArgumentFunction required" || return $?
  [ -n "$cannonPath" ] || cannonPath=$(__catchEnvironment "$usage" buildHome) || return $?

  local line tokens=()
  local exitCode=0 start results comment="" commentText="(start of file)"

  start=$(timingStart)
  results=$(fileTemporaryName "$usage") || return $?
  while read -r line; do
    comment="${line#\#}"
    if [ "$comment" != "$line" ]; then
      comment=$(trimSpace "$comment")
      commentText="$(decorate info "$(buildEnvironmentGet APPLICATION_NAME)") $(decorate label "$comment")"
      statusMessage printf "%s\n" "$commentText ..."
      continue
    fi
    IFS="|" read -r -a tokens <<<"$line" || :
    if [ "${#tokens[@]}" -gt 0 ]; then
      statusMessage decorate info "$commentText deprecated tokens: $(decorate each code "${tokens[@]}") ..."
      if deprecatedFind "$findArgumentFunction" "${tokens[@]}" >"$results"; then
        statusMessage --last decorate error "$commentText token found: $(decorate each code "${tokens[@]}")"
        decorate code <"$results"
        exitCode=1
      fi
    fi
  done < <(cat "${files[@]+"${files[@]}"}")
  __catchEnvironment "$usage" rm -rf "$results" || return $?

  statusMessage --last timingReport "$start" "Deprecated token scan took"
}
_deprecatedTokensFile() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: findArgumentFunction - Function. Required. Find arguments (for `find`) for cannon.
# Argument: cannonFile - File. Required. One or more files delimited with `|` characters, one per line `search|replace|findArguments|...`. If not files are supplied then pipe file via stdin.
# Run cannon using a configuration file or files.
# Comment lines (First character is `#`) are considered the current "state" (e.g. version) and are displayed during processing.
#
# Sample file:
#
#     # v0.25.0
#     timingStart|timingStart
#     timingReport|timingReport
#     bashUserInput|bashUserInput
#
#     # v0.24.0
#     listJoin|listJoin
#     mapTokens|mapTokens
#
# Exit Code: 0 - No changes were made in any files.
# Exit Code: 1 - changes were made in at least one file.
deprecatedCannonFile() {
  local usage="_${FUNCNAME[0]}"

  local findArgumentFunction="" files=() cannonPath=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --path)
        shift
        cannonPath=$(usageArgumentDirectory "$usage" "$argument cannonPath" "${1-}") || return $?
        ;;
      *)
        if [ -z "$findArgumentFunction" ]; then
          findArgumentFunction=$(usageArgumentFunction "$usage" "ignoreFunction" "$1") || return $?
        else
          files+=("$(usageArgumentFile "$usage" "cannonFile" "$1")") || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$findArgumentFunction" ] || __throwArgument "$usage" "findArgumentFunction required" || return $?
  [ -n "$cannonPath" ] || cannonPath=$(__catchEnvironment "$usage" buildHome) || return $?

  local start
  start=$(__environment timingStart) || return $?

  local exitCode=0 version="No version yet"

  while read -r line; do
    local IFS tokens=() trimmed
    trimmed=$(__environment trimSpace "$line") || return $?
    [ -n "$trimmed" ] || continue
    if [ "${trimmed:0:1}" = "#" ]; then
      version="$(__environment trimSpace "${trimmed:1}")" || return $?
      continue
    fi
    IFS="|" read -r -a tokens <<<"$line" || :
    if [ "${#tokens[@]}" -le 1 ]; then
      decorate error "Bad line: $line" || :
      exitCode=1
      continue
    fi
    statusMessage --first printf -- "%s: %s -> %s %s" "$(decorate bold-magenta "$version")" "$(decorate code "${tokens[0]}")" "$(decorate code "${tokens[1]}")"
    if ! deprecatedCannon --path "$cannonPath" "$findArgumentFunction" "${tokens[@]}"; then
      printf -- "\n"
      exitCode=1
    fi
  done < <(cat "${files[@]+"${files[@]}"}")
  statusMessage --last timingReport "$start" "Deprecated cannon took"
  return "$exitCode"
}
_deprecatedCannonFile() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Find files which match a token or tokens
# Exit code: 0 - One of the search tokens was found in a file (which matches find arguments)
# Exit code: 1 - Search tokens were not found in any file (which matches find arguments)
# Argument: findArgumentFunction - Function. Required. Find arguments (for `find`) for cannon.
# Argument: search - String. Required. String to search for (one or more)
# Argument: --path cannonPath - Optional. Directory. Run cannon operation starting in this directory.
# See: buildHome
deprecatedFind() {
  local usage="_${FUNCNAME[0]}"
  local cannonPath="" search="" findArgumentFunction="" aa=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --path)
        shift
        cannonPath=$(usageArgumentDirectory "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        if [ -z "$findArgumentFunction" ]; then
          findArgumentFunction=$(usageArgumentFunction "$usage" "ignoreFunction" "$1") || return $?
          local aa=()
          read -d '' -r -a aa < <("$findArgumentFunction") || [ "${#aa[@]}" -gt 0 ] || __throwArgument "$usage" "$findArgumentFunction returned empty" || return $?
        else
          [ -n "$cannonPath" ] || cannonPath=$(__catchEnvironment "$usage" buildHome) || return $?
          search="$(usageArgumentString "$usage" "search" "${1-}")" || return $?
          search="$(quoteGrepPattern "$search")"
          if find "$cannonPath" -type f "${aa[@]}" -print0 | xargs -0 grep -n -l -e "$search"; then
            return 0
          fi
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  return 1
}
_deprecatedFind() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} search replace [ findArgumentFunction ] [ extraCannonArguments ]
# Argument: --path cannonPath - Optional. Directory. Run cannon operation starting in this directory.
# Argument: findArgumentFunction - Function. Required. Find arguments (for `find`) for cannon.
# Argument: search - String. Required. String to search for
# Argument: replace - String. Required. String to search for
# Argument: extraCannonArguments - Arguments. Optional. Any additional arguments are passed to `cannon`.
deprecatedCannon() {
  local usage="_${FUNCNAME[0]}"
  local search="" replace="" findArgumentFunction="" cannonPath=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --path)
        shift
        cannonPath=$(usageArgumentDirectory "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        if [ -z "$findArgumentFunction" ]; then
          findArgumentFunction=$(usageArgumentFunction "$usage" "ignoreFunction" "$1") || return $?
        elif [ -z "$search" ]; then
          search="$(usageArgumentString "$usage" "search" "${1-}")" || return $?
        elif [ -z "$replace" ]; then
          replace="$(usageArgumentString "$usage" "replace" "${1-}")" || return $?
        else
          break
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ -n "$cannonPath" ] || cannonPath=$(__catchEnvironment "$usage" buildHome) || return $?
  [ -n "$findArgumentFunction" ] || __throwArgument "$usage" "findArgumentFunction required" || return $?
  [ -n "$search" ] || __throwArgument "$usage" "search required" || return $?
  [ -n "$replace" ] || __throwArgument "$usage" "replace required" || return $?

  local aa=()
  read -d '' -r -a aa < <("$findArgumentFunction") || [ "${#aa[@]}" -gt 0 ] || __throwArgument "$usage" "$findArgumentFunction returned empty" || return $?
  # ignore should go at the end so it has priority over previous entries
  cannon --path "$cannonPath" "$search" "$replace" "$@" "${aa[@]}"
}
_deprecatedCannon() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
