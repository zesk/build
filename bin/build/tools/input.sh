#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs:  ./docs/_templates/tools/input.md
# Test: ./test/tools/input-tests.sh

# Add configuration to `~/.inputrc` for a key binding
# Usage: {fn} keyStroke action
# Argument: keyStroke - Required. String.
# Argument: action - Required. String.
# Example: inputConfigurationAdd "\ep" history-search-backward
inputConfigurationAdd() {
  local usage="_${FUNCNAME[0]}"
  local target=".input""rc" keyStroke="${1-}" action="${2-}" pattern
  export HOME

  __usageArgument "$usage" buildEnvironmentLoad HOME || return $?
  [ -d "$HOME" ] || __failEnvironment "$usage" "HOME is not a directory $(decorate code "$HOME")" || return $?
  target="$HOME/$target"
  [ -f "$target" ] || __usageEnvironment "$usage" touch "$target" || return $?
  pattern="^$(quoteGrepPattern "\"$keyStroke\":")"
  if grep -q -e "$pattern" <"$target"; then
    grep -v "$pattern" >"$target.new" <"$target"
    __usageEnvironment "$usage" mv -f "$target.new" "$target" || _clean $? "$target.new" || return $?
  fi
  __usageEnvironment "$usage" printf "\"%s\": %s\n" "$keyStroke" "$action" >>"$target"
}
_inputConfigurationAdd() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
