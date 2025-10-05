#!/usr/bin/env bash
#
# Functions related to converting between Bash-compatible and Docker environment files
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# bin: head grep
# Docs: contextOpen ./documentation/source/tools/environment.md
# Test: contextOpen ./test/tools/environment-tests.sh

# Ensure an environment file is compatible with non-quoted docker environment files
# Argument: filename - Docker environment file to check for common issues
# Return Code: 1 - if errors occur
# Return Code: 0 - if file is valid
#
environmentFileIsDocker() {
  local file result=0 pattern='\$|="|='"'"

  for file in "$@"; do
    [ "$file" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
    if grep -q -E -e "$pattern" "$file"; then
      grep -E -e "$pattern" "$file" 1>&2
      result=1
    fi
  done
  return "$result"
}
_environmentFileIsDocker() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Takes any environment file and makes it compatible with BASH or Docker
#
# Outputs the compatible env to stdout
#
# Argument: handler - Function. Required. Error handler.
# Argument: passConvertFunction - Function. Required. Conversion function when `filename` is a Docker environment file.
# Argument: failConvertFunction - Function. Required. Conversion function when `filename` is a NOT a Docker environment file.
# Argument: filename - Optional. File. One or more files to convert.
# stdin: environment file
# stdout: bash-compatible environment statements
__anyEnvToFunctionEnv() {
  local handler="$1" passConvertFunction="$2" failConvertFunction="$3" && shift 3

  if [ $# -gt 0 ]; then
    local file
    for file in "$@"; do
      if [ "$file" = "--help" ]; then
        "$handler" 0
        return 0
      fi
      if environmentFileIsDocker "$file" 2>/dev/null; then
        # printf -- "%s\n" "environmentFileIsDocker=true" "converter=$passConvertFunction"
        catchEnvironment "$handler" "$passConvertFunction" <"$file" || return $?
      else
        # printf -- "%s\n" "environmentFileIsDocker=\"false\"" "converter=\"$failConvertFunction\""
        catchEnvironment "$handler" "$failConvertFunction" <"$file" || return $?
      fi
    done
  else
    local temp
    temp=$(fileTemporaryName "$handler") || return $?
    catchEnvironment "$handler" muzzle tee "$temp" || returnClean $? "$temp" || return $?
    returnCatch "$handler" __anyEnvToFunctionEnv "$handler" "$passConvertFunction" "$failConvertFunction" "$temp" || returnClean $? "$temp" || return $?
    catchEnvironment "$handler" rm "$temp" || return $?
    return 0
  fi
}

#
# Takes any environment file and makes it docker-compatible
#
# Outputs the compatible env to stdout
# handler: {fn} envFile [ ... ]
# Argument: envFile - Required. File. One or more files to convert.
#
environmentFileToDocker() {
  __anyEnvToFunctionEnv "_${FUNCNAME[0]}" bashCommentFilter environmentFileBashCompatibleToDocker "$@" || return $?
}
_environmentFileToDocker() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Takes any environment file and makes it bash-compatible
#
# Outputs the compatible env to stdout
#
# handler: {fn} filename [ ... ]
# Argument: filename - Optional. File. One or more files to convert.
# stdin: environment file
# stdout: bash-compatible environment statements
environmentFileToBashCompatible() {
  __anyEnvToFunctionEnv "_${FUNCNAME[0]}" environmentFileDockerToBashCompatible cat "$@" || return $?
}
_environmentFileToBashCompatible() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Ensure an environment file is compatible with non-quoted docker environment files
# May take a list of files to convert or stdin piped in
#
# Outputs bash-compatible entries to stdout
# Any output to stdout is considered valid output
# Any output to stderr is errors in the file but is written to be compatible with a bash
#
# handler: {fn} [ filename ... ]
# Argument: filename - Docker environment file to check for common issues
# Return Code: 1 - if errors occur
# Return Code: 0 - if file is valid
#
environmentFileDockerToBashCompatible() {
  local handler="_${FUNCNAME[0]}"
  local file index envLine result=0
  if [ $# -eq 0 ]; then
    __internalEnvironmentFileDockerToBashCompatiblePipe
  else
    for file in "$@"; do
      if [ "$file" = "--help" ]; then
        "$handler" 0
        return $?
      fi
      [ -f "$file" ] || throwArgument "$handler" "Not a file $file" || return $?
      __internalEnvironmentFileDockerToBashCompatiblePipe <"$file" || throwArgument "$handler" "Invalid file: $file" || return $?
    done
  fi
}
_environmentFileDockerToBashCompatible() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Utility for environmentFileDockerToBashCompatible to handle both pipes and files
#
__internalEnvironmentFileDockerToBashCompatiblePipe() {
  local file index envLine result name value
  result=0
  index=0
  while IFS="" read -r envLine; do
    case "$envLine" in
    [[:space:]]*[#]* | [#]* | "")
      # Comment line
      printf -- "%s\n" "$envLine"
      ;;
    *)
      name="${envLine%%=*}"
      value="${envLine#*=}"
      if [ -n "$name" ] && [ "$name" != "$envLine" ]; then
        if [ -z "$(printf -- "%s" "$name" | sed 's/^[A-Za-z][0-9A-Za-z_]*$//g')" ]; then
          printf -- "%s=\"%s\"\n" "$name" "$(escapeDoubleQuotes "$value")"
        else
          returnArgument "Invalid name at line $index: $name" || result=$?
        fi
      else
        returnArgument "Invalid line $index: $envLine" || result=$?
      fi
      ;;
    esac
    index=$((index + 1))
  done
  return $result
}

# Ensure an environment file is compatible with non-quoted docker environment files
# Argument: filename - File. Optional. Docker environment file to check for common issues
# stdin: text - Optional. Environment file to convert.
# stdout: text - Only if stdin is supplied and no `filename` arguments.
# Return Code: 1 - if errors occur
# Return Code: 0 - if file is valid
#
environmentFileBashCompatibleToDocker() {
  local handler="_${FUNCNAME[0]}"
  local file envLine tempFile clean=()

  tempFile=$(fileTemporaryName "$handler") || return $?
  clean=("$tempFile")
  if [ $# -eq 0 ]; then
    catchEnvironment "$handler" muzzle tee "$tempFile.bash" || returnClean $? "${clean[@]}" || return $?
    clean+=("$tempFile.bash")
    set -- "$tempFile.bash"
  fi
  for file in "$@"; do
    if [ "$file" = "--help" ]; then
      "$handler" 0 && returnClean $? "${clean[@]}" && return $? || return $?
    fi
    [ -f "$file" ] || throwArgument "$handler" "Not a file $file" || returnClean $? "${clean[@]}" || return $?
    env -i bash -c "set -eoua pipefail; source \"$file\"; declare -px; declare -pa" >"$tempFile" 2>&1 | outputTrigger --name "$file" || throwArgument "$handler" "$file is not a valid bash file" || returnClean $? "${clean[@]}" || return $?
  done
  while IFS='' read -r envLine; do
    local name=${envLine%%=*} value=${envLine#*=}
    printf -- "%s=%s\n" "$name" "$(unquote "\"" "$value")"
  done < <(removeFields 2 <"$tempFile" | grep -E -v '^(UID|OLDPWD|PWD|_|SHLVL|FUNCNAME|PIPESTATUS|DIRSTACK|GROUPS)\b|^(BASH_)' || :)
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
}
_environmentFileBashCompatibleToDocker() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
