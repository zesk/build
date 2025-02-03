#!/usr/bin/env bash
#
# Hook: project-deactivate
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-source-header 2
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# Run the developer-undo.sh file or developer-undo/ directory of shell files
__hookProjectDeactivateContext() {
  local usage="_${FUNCNAME[0]}" home item items=() candidates=("$home/bin/developer-undo.sh" "$home/bin/developer-undo/")

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  for item in "${candidates[@]}"; do [ ! -e "$home/$item" ] || items+=("$home/$item"); done

  [ ${#items[@]} -eq 0 ] || interactiveBashSource --prefix "Deactivate" || return $?
}
___hookProjectDeactivateContext() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# shellcheck source=/dev/null
if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
  __hookProjectDeactivateContext || decorate warning "Project context deactivation failed" || :
fi
