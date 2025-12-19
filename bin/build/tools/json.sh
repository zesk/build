#!/usr/bin/env bash
#
# JSON functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/json.md
# Test: ./test/tools/json-tests.sh

# _IDENTICAL_ jsonField 29

# Fetch a non-blank field from a JSON file with error handling
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: handler - Function. Required. Error handler.
# Argument: jsonFile - File. Required. A JSON file to parse
# Argument: ... - Arguments. Optional. Passed directly to jq
# stdout: selected field
# stderr: error messages
# Return Code: 0 - Field was found and was non-blank
# Return Code: 1 - Field was not found or is blank
# Requires: jq whichExists throwEnvironment printf rm decorate head
jsonField() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local handler="$1" jsonFile="$2" value message && shift 2

  [ -f "$jsonFile" ] || throwEnvironment "$handler" "$jsonFile is not a file" || return $?
  whichExists jq || throwEnvironment "$handler" "Requires jq - not installed" || return $?
  if ! value=$(jq -r "$@" <"$jsonFile"); then
    message="$(printf -- "%s\n%s\n" "Unable to fetch selector $(decorate each code -- "$@") from JSON:" "$(head -n 100 "$jsonFile")")"
    throwEnvironment "$handler" "$message" || return $?
  fi
  [ -n "$value" ] || throwEnvironment "$handler" "$(printf -- "%s\n%s\n" "Selector $(decorate each code -- "$@") was blank from JSON:" "$(head -n 100 "$jsonFile")")" || return $?
  printf -- "%s\n" "$value"
}
_jsonField() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Generate `jq` paths
#
# Generate a path for a JSON structure for use in `jq` queries
#
# Argument: path - String. Output a json path separated by dots.
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
jsonPath() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  local paths=()
  while [ $# -gt 0 ]; do
    [ -z "$1" ] || paths+=("$1")
    shift
  done
  printf ".%s\n" "$(listJoin "." "${paths[@]}")"
}
_jsonPath() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__jqPathClean() {
  local path="$1"
  path="${path#.}"
  path="${path%.}"
  path=".$path"
  printf -- "%s\n" "$path"
}

__jqObject() {
  local path="$1" jqPrefix="${2-"{}"}"
  local segments=() segment
  IFS="." read -r -a segments <<<"${path#.}"
  local reverse=()
  for segment in "${segments[@]}"; do
    reverse=("$segment" "${reverse[@]+"${reverse[@]}"}")
  done
  for segment in "${reverse[@]}"; do
    jqPrefix="{ $segment: $jqPrefix }"
  done
  printf "%s\n" "$jqPrefix"
}

# Get a value in a JSON file
# Argument: jsonFile - File. Required. File to get value from.
# Argument: path - String. Required. dot-separated path to get
jsonFileGet() {
  local handler="_${FUNCNAME[0]}"
  local jsonFile path value

  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0

  jsonFile=$(usageArgumentFile "$handler" "jsonFile" "${1-}") && shift || return $?
  path=$(usageArgumentString "$handler" "path" "${1-}") && shift || return $?

  path="$(__jqPathClean "$path")"

  catchReturn "$handler" jq -r "$(__jqObject "$path") + . | $path" <"$jsonFile" || return $?
}
_jsonFileGet() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Set a value in a JSON file
# Argument: jsonFile - File. Required. File to get value from.
# Argument: path - String. Required. dot-separated path to modify (e.g. `extra.fingerprint`)
# Argument: value - String. Required. Value to set.
jsonFileSet() {
  local handler="_${FUNCNAME[0]}"
  local jsonFile path value

  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0

  jsonFile=$(usageArgumentFile "$handler" "jsonFile" "${1-}") && shift || return $?
  path=$(usageArgumentString "$handler" "path" "${1-}") && shift || return $?
  value=$(usageArgumentEmptyString "$handler" "value" "${1-}") && shift || return $?

  whichExists jq || throwEnvironment "$handler" "Requires jq - not installed" || return $?

  path=$(__jqPathClean "$path")
  catchEnvironment "$handler" jq --sort-keys -r "$(__jqObject "$path") + . | $path = \"$value\"" <"$jsonFile" >"$jsonFile.new" || returnClean $? "$jsonFile.new" || return $?
  catchEnvironment "$handler" mv -f "$jsonFile.new" "$jsonFile" || returnClean $? "$jsonFile.new" || return $?
}
_jsonFileSet() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Sets the value of a variable in a JSON file
#
# Argument: --filter - Function. Optional. Run value through this filter prior to inserting into the JSON file.
# Argument: --status - Flag. Optional. When set, returns `0` when the value was updated successfully and `$(returnCode identical)` when the values is the same
# Argument: --quiet - Flag. Optional. Do not output anything to `stdout` and just do the action and exit.
# Argument: --generator - Function. Optional. Function to generate the value. Defaults to `hookVersionCurrent`.
# Argument: --value - String. Optional. Value to set in JSON file. (Skips generation)
# Argument: --key - String. Optional. Key to set in JSON file. Defaults to `version`.
# Argument: key - Required. If not specified as `--key`, specify it here.
# Argument: file - File. Required. Modify and update this file
# Return Code: 0 - File was updated successfully.
# Return Code: 1 - Environment error
# Return Code: 2 - Argument error
# Return Code: 105 - Identical files (only when --status is passed)
jsonSetValue() {
  local handler="_${FUNCNAME[0]}"
  local value="" statusFlag=false quietFlag=false file="" key="version"
  local generator="hookVersionCurrent" filter="versionNoVee"

  whichExists jq || throwEnvironment "$handler" "Requires jq - not installed" || return $?

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --generator)
      shift
      generator="$(usageArgumentFunction "$handler" "$argument" "${1-}")" || return $?
      ;;
    --status)
      statusFlag=true
      ;;
    --quiet)
      quietFlag=true
      ;;
    --value)
      shift
      value="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --key)
      shift
      key="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --filter)
      shift
      filter="$(usageArgumentFunction "$handler" "$argument" "${1-}")" || return $?
      ;;
    *)
      file="$(usageArgumentFile "$handler" "$argument" "${1-}")" || return $?
      if [ -z "$value" ]; then
        if [ -z "$generator" ]; then
          throwArgument "$handler" "--generator or --value is required" || return $?
        fi
        value=$(catchEnvironment "$handler" "$generator") || return $?
        if [ -z "$value" ]; then
          throwEnvironment "$handler" "Value returned by --generator $generator hook is blank" || return $?
        fi
      fi
      if [ -n "$filter" ]; then
        value=$(catchEnvironment "$handler" "$filter" "$value") || return $?
        if [ -z "$value" ]; then
          throwEnvironment "$handler" "Value returned by --filter $filter hook is blank" || return $?
        fi
      fi
      __jsonSetValue "$handler" "$file" "$key" "$value" "$quietFlag" "$statusFlag" || return $?
      ;;
    esac
    shift
  done
  [ -n "$file" ] || throwArgument "$handler" "file is required" || return $?
}
_jsonSetValue() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__jsonSetValue() {
  local handler="$1" json="$2" key="$3" value="$4" quietFlag="$5" statusFlag="$6" key

  local oldValue decoratedJSON newJSON decoratedValue decoratedOldValue

  decoratedJSON="$(decorate file "$json")"
  newJSON="$json.${FUNCNAME[0]}.$$"
  key="${key#.}"

  oldValue="$(catchEnvironment "$handler" jq ".$key" <"$json")" || return $?

  catchEnvironment "$handler" jq --sort-keys --arg value "$value" ". + { $key: \$value }" <"$json" >"$newJSON" || returnClean $? "$newJSON" || return $?

  decoratedValue=$(decorate value "$value")
  decoratedOldValue=$(decorate value "$oldValue")

  if muzzle diff -q "$json" "$newJSON"; then
    $quietFlag || statusMessage --last decorate info "$decoratedJSON $key is $decoratedValue (up to date)"
    catchEnvironment "$handler" rm -rf "$newJSON" || return $?
    ! $statusFlag || return "$(returnCode identical)"
  else
    catchEnvironment "$handler" mv -f "$newJSON" "$json" || returnClean $? "$newJSON" || return $?
    $quietFlag || statusMessage --last decorate info "$decoratedJSON $key updated to $decoratedValue (old value $decoratedOldValue)"
  fi
}
