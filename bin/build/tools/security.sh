#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
#
# Docs: o ./documentation/source/tools/security.md
# Test: o ./test/tools/security-tests.sh

__doEvalCheck() {
  local usage="$1" && shift
  local file firstLine checkLine checkLineFailed failed tempResults

  tempResults=$(fileTemporaryName "$usage") || return $?
  while [ $# -gt 0 ]; do
    file=$(usageArgumentFile "$usage" "file" "$1") || return $?
    shift
    if ! grep -n -B 1 -e '^[^#]*\seval "' <"$file" >"$tempResults"; then
      continue
    fi
    firstLine=false
    failed=0
    while read -r line; do
      lineNo="${line%%:*}"
      if [ "$lineNo" = "$line" ]; then
        # grep uses - for non-matching lines and : for matching ones
        lineNo="${line%%-*}"
        if [ -z "$lineNo" ]; then
          firstLine=true
          continue
        fi
        [ "$lineNo" != "$line" ] || __catchEnvironment "$usage" "Unable to parse line: $line" || return $?
        line="${line#-*}"
      else
        line="${line#:*}"
      fi
      if $firstLine; then
        checkLineFailed=false
        checkLine="${line##*evalCheck:}"
        if [ "$checkLine" = "$line" ]; then
          checkLineFailed=true
        else
          checkLine="$(trimSpace "$checkLine")" || :
        fi
        firstLine=false
      else
        if "$checkLineFailed"; then
          failed=$((failed + 1))
          printf "%s in %s line %s: %s\n" "$(decorate error "Unchecked eval")" "$(decorate info "$1")" "$(decorate blue "$lineNo")" "$(decorate code "$line")"
        else
          printf "%s in %s line %s: %s\n" "$(decorate success "evalCheck FOUND")" "$(decorate info "$1")" "$(decorate blue "$lineNo")" "$(decorate code "$checkLine")"
        fi
      fi
    done <"$tempResults"
  done
  __catchEnvironment "$usage" rm -rf "$tempResults" || return $?
  [ "$failed" -eq 0 ] || __throwEnvironment "$usage" "evalCheck failed for $failed $(plural "$failed" file files)" || return $?
}

# Check files to ensure `eval`s in code have been checked
evalCheck() {
  local usage="_${FUNCNAME[0]}"

  local fileName
  if [ $# -gt 0 ]; then
    __doEvalCheck "$usage" "$@" || return $?
  else
    while IFS= read -r fileName; do
      statusMessage decorate info "Checking $fileName"
      __doEvalCheck "$usage" "$fileName" || return $?
    done
  fi
}
