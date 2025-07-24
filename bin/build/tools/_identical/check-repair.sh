#!/usr/bin/env bash
#
# Checking identical
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# In case you forgot, the directory in which this file is named `_identical` and *NOT* `identical`.
#
# This is to avoid having this match when doing `identicalRepair` - causes issues.
#
# Thanks for your consideration.
#

# Repair two files which differ using repair source directories to determine which file should prevail
#
# Argument: handler - Function. Required.
# Argument: prefix - String. Required.
# Argument: token - String. Required.
# Argument: file1 - File. Required. Path to a mismatched file.
# Argument: file2 - File. Required. Path to another mismatched file.
# Argument: repairSources ... - Directory. Optional. One or more directories which have the source files for repairs. If either file is found in one of these directories, it will be consider the source and used to repair the target (other) file.
__identicalCheckRepair() {
  local handler="$1" && shift
  local prefix="$1" && shift
  local token="$1" && shift
  local fileA="$1" && shift
  local fileB="$1" && shift

  fileA=$(__catch "$handler" realPath "$fileA") || return $?
  fileB=$(__catch "$handler" realPath "$fileB") || return $?

  [ "$fileA" != "$fileB" ] || __throwArgument "$handler" "Repair in same file not possible: $(decorate file "$fileA") (Prefix: $(decorate code "$prefix"))" || return $?
  while [ $# -gt 0 ]; do
    local checkPath="$1"
    statusMessage decorate info "Checking path $checkPath ..."
    if [ "${fileA#"$checkPath"}" != "$fileA" ]; then
      statusMessage decorate info Repairing "$fileB" with "$fileA"
      __catch "$handler" identicalRepair --prefix "$prefix" --token "$token" "$fileA" "$fileB" || return $?
      return $?
    elif [ "${fileB#"$checkPath"}" != "$fileB" ]; then
      statusMessage decorate info Repairing "$fileA" with "$fileB"
      __catch "$handler" identicalRepair --prefix "$prefix" --token "$token" "$fileB" "$fileA" || return $?
      return $?
    fi
    shift
  done
  __throwEnvironment "$handler" "No repair found between $(decorate file "$fileA") and $(decorate file "$fileB") (Prefix: $(decorate code "$prefix"))" || return $?
}
