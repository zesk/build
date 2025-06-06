#!/usr/bin/env bash
#
# JSON functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/json.md
# Test: ./test/tools/json-tests.sh

# _IDENTICAL_ jsonField 22

# Fetch a non-blank field from a JSON file with error handling
# Argument: handler - Function. Required. Error handler.
# Argument: jsonFile - File. Required. A JSON file to parse
# Argument: ... - Arguments. Optional. Passed directly to jq
# stdout: selected field
# stderr: error messages
# Exit Code: 0 - Field was found and was non-blank
# Exit Code: 1 - Field was not found or is blank
# Requires: jq whichExists __throwEnvironment printf rm decorate head
jsonField() {
  local handler="$1" jsonFile="$2" value message && shift 2

  [ -f "$jsonFile" ] || __throwEnvironment "$handler" "$jsonFile is not a file" || return $?
  whichExists jq || __throwEnvironment "$handler" "Requires jq - not installed" || return $?
  if ! value=$(jq -r "$@" <"$jsonFile"); then
    message="$(printf -- "%s\n%s\n" "Unable to fetch selector $(decorate each code "$@") from JSON:" "$(head -n 100 "$jsonFile")")"
    __throwEnvironment "$handler" "$message" || return $?
  fi
  [ -n "$value" ] || __throwEnvironment "$handler" "$(printf -- "%s\n%s\n" "Selector $(decorate each code "$@") was blank from JSON:" "$(head -n 100 "$jsonFile")")" || return $?
  printf -- "%s\n" "$value"
}

# For any project, ensures the `version` field in a `.json` matches `runHook version-current`
#
# Run as a commit hook for any project which stores versions in files.
#
# Typically the version is copied in without the leading `v`.
#
# Argument: --filter - Function. Optional. Run value through this filter prior to inserting into the JSON file.
# Argument: --status - Flag. Optional. When set, returns 0 when te version was updated successfully and $(_code identical) when the files are the same
# Argument: --quiet - Flag. Optional. Do not output anything to stdout and just do the action and exit.
# Argument: --generator - Function. Optional. Function to generate the value. Defaults to `hookVersionCurrent`.
# Argument: --value - String. Optional. Value to set in JSON file. (Skips generation)
# Argument: --key - String. Optional. Key to set in JSON file. Defaults to `version`.
# Argument: key - Required. If not specified as `--key`, specify it here.
# Argument: file - File. Required. Modify and update this file
# Exit Code: 0 - File was updated successfully.
# Exit Code: 1 - Environment error
# Exit Code: 2 - Argument error
# Exit Code: 105 - Identical files (only when --status is passed)
jsonSetValue() {
  local usage="_${FUNCNAME[0]}"
  local value="" statusFlag=false quietFlag=false file="" key="version"
  local generator="hookVersionCurrent" filter="versionNoVee"

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
    --generator)
      shift
      generator="$(usageArgumentFunction "$usage" "$argument" "${1-}")" || return $?
      ;;
    --status)
      statusFlag=true
      ;;
    --quiet)
      quietFlag=true
      ;;
    --value)
      shift
      value="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
      ;;
    --key)
      shift
      key="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
      ;;
    --filter)
      shift
      filter="$(usageArgumentFunction "$usage" "$argument" "${1-}")" || return $?
      ;;
    *)
      file="$(usageArgumentFile "$usage" "$argument" "${1-}")" || return $?
      if [ -z "$value" ]; then
        if [ -z "$generator" ]; then
          __throwArgument "$usage" "--generator or --value is required" || return $?
        fi
        value=$(__catchEnvironment "$usage" "$generator") || return $?
        if [ -z "$value" ]; then
          __throwEnvironment "$usage" "Value returned by --generator $generator hook is blank" || return $?
        fi
      fi
      if [ -n "$filter" ]; then
        value=$(__catchEnvironment "$usage" "$filter" "$value") || return $?
        if [ -z "$value" ]; then
          __throwEnvironment "$usage" "Value returned by --filter $filter hook is blank" || return $?
        fi
      fi
      __jsonSetValue "$usage" "$file" "$key" "$value" "$quietFlag" "$statusFlag" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ -n "$file" ] || __throwArgument "$usage" "file is required" || return $?
}
_jsonSetValue() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__jsonSetValue() {
  local usage="$1" json="$2" key="$3" value="$4" quietFlag="$5" statusFlag="$6" key

  local oldValue decoratedJSON newJSON decoratedValue decoratedOldValue

  decoratedJSON="$(decorate file "$json")"
  newJSON="$json.${FUNCNAME[0]}.$$"
  key="${key#.}"

  oldValue="$(__catchEnvironment "$usage" jq ".$key" <"$json")" || return $?

  __catchEnvironment "$usage" jq --arg value "$value" ". + { $key: \$value }" <"$json" >"$newJSON" || _clean $? "$newJSON" || return $?

  decoratedValue=$(decorate value "$value")
  decoratedOldValue=$(decorate value "$oldValue")

  if muzzle diff -q "$json" "$newJSON"; then
    $quietFlag || statusMessage --last decorate info "$decoratedJSON $key is $decoratedValue (up to date)"
    __catchEnvironment "$usage" rm -rf "$newJSON" || return $?
    ! $statusFlag || return "$(_code identical)"
  else
    __catchEnvironment "$usage" mv -f "$newJSON" "$json" || _clean $? "$newJSON" || return $?
    $quietFlag || statusMessage --last decorate info "$decoratedJSON $key updated to $decoratedValue (old value $decoratedOldValue)"
  fi
}
