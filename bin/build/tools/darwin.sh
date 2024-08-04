#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/darwin.md
# Test: o ./test/tools/darwin-tests.sh
#

# Usage: {fn} [ --help ] [ --choice choiceText ] [ --ok ] [ --cancel ] [ --default buttonIndex ] message ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --choice choiceText - Optional. String. Title of the thing.
# Argument: --ok - Optional. Flag. Adds "OK" as an option.
# Argument: --cancel - Optional. Flag. Adds "Cancel" as an option.
# Argument: --default buttonIndex - Required. Integer. The button (0-based index) to make the default button choice.
# Argument: message ... - Required. String. The message to display in the dialog.
# Display a dialog using `osascript` with the choices provided. Typically this is found in Darwin, Mac OS X's operating system.
# Outputs the selected button text upon exit.
darwinDialog() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local message choices choice defaultButton choiceText messageText maxChoice

  export OSTYPE
  requireBinary osascript || __failEnvironment "$usage" "Requires osascript typically on Darwin: ${OSTYPE-}" || return $?
  message=()
  defaultButton=0
  choices=()
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --choice)
        shift
        choices+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --ok)
        choices+=("Ok")
        ;;
      --cancel)
        choices+=("Cancel")
        ;;
      --default)
        shift
        defaultButton="$(usageArgumentInteger "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        message+=("$1")
        ;;
    esac
    shift
  done
  choiceText=()
  if [ ${#choices[@]} -eq 0 ]; then
    choices+=(Ok)
  fi
  for choice in "${choices[@]}"; do
    choiceText+=("$(printf '"%s"' "$(escapeDoubleQuotes "$choice")")")
  done
  maxChoice=$((${choices[@]} - 1))
  if [ "$defaultButton" -gt $maxChoice ]; then
    __failArgument "$usage" "defaultButton $defaultButton is out of range 0 ... $maxChoice" || return $?
  fi
  messageText="$(escapeDoubleQuotes "$(printf "%s\\\n" "${message[@]}")")"
  # Index is 1-based
  defaultButton=$((defaultButton + 1))
  (
    IFS=','
    result="$(__usageEnvironment "$usage" osascript -e "display dialog \"$messageText\" buttons { ${choiceText[*]} } default button $defaultButton" | cut -d : -f 2)" || return $?
    printf "%s\n" "$result"
  ) || return $?
}
_darwinDialog() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
