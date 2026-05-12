#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Extract and build the documentation settings cache and generate derived files
# Argument: --clean - Flag. Optional. Clean everything and then exit.
# Argument: --git - Flag. Optional. Do some handy `git` changes. (Adding/removing files)
# Argument: --all - Flag. Optional. Do everything regardless of cache state.
# Argument: --fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date.
# Argument: functionName ... - String. Optional. Specific functions to compile.
buildFunctionsDerivedCompile() {
  local handler="_${FUNCNAME[0]}"
  local dd=() fingerprint="" key="buildFunctions"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --clean | --git | --all) dd+=("$argument") ;;
    --key) shift && key=$(validate "$handler" String "$argument" "${1-}") || return "$(convertValue $? 120 0)" ;;
    --fingerprint) fingerprint=$(validate "$handler" Fingerprint fingerprintFlag "$key") || return "$(convertValue $? 120 0)" ;;
    --check)
      [ $# -eq 0 ] || throwArgument "$handler" "Extra arguments: $# $*" || return $?
      fingerprint --key "$key" --check
      return $?
      ;;
    *) break ;;
    esac
    shift
  done

  dd+=(--derive bashDocumentationDeriveSee --)
  dd+=(--derive bashDocumentationDeriveFunction --)
  catchReturn "$handler" documentationFileCompile "${dd[@]+"${dd[@]}"}" "$@" || return $?

  [ -z "$fingerprint" ] || fingerprint --key "$key" --verbose
}
_buildFunctionsDerivedCompile() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

buildFunctionsRemoveDeprecated() {
  local handler="_${FUNCNAME[0]}"

  local dryRun=false verboseFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --verbose) verboseFlag=true ;;
    --dry-run) dryRun=true ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local deprecatedFiles=()
  local fun && while read -r fun; do
    local extension && for extension in sh md; do
      local prefix && for prefix in "" "SEE/"; do
        ! $verboseFlag || statusMessage decorate info "Checking $prefix$fun.$extension"
        if path=$(__documentationFile "$home" "$prefix$fun" false "$extension"); then
          deprecatedFiles+=("$path")
        fi
      done
    done
  done < <(catchReturn "$handler" buildDeprecatedFunctions) || return $?
  if $dryRun; then
    [ "${#deprecatedFiles[@]}" -eq 0 ] && statusMessage --last printf -- "%s\n" "# No deprecated files." || printf -- "git rm -f %s\n" "${deprecatedFiles[@]}" || return $?
  else
    [ "${#deprecatedFiles[@]}" -eq 0 ] || local f && for f in "${deprecatedFiles[@]}"; do
      ! $verboseFlag || decorate info "Remove \"$f\""
      catchEnvironment "$handler" git rm -f "$f" 2>/dev/null || catchReturn "$handler" rm -f "$f" || return $?
    done
  fi
}
_buildFunctionsRemoveDeprecated() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__buildFunctionsLoad() {
  local handler="$1" && shift

  : # Do nothing currently
}

# Is everything up to date?
# Argument: handler - Function. Required.
# Argument: docPath - Directory. Required.
# Argument: tempFunctions - File. Required. File containing list of function names
__buildFunctionsIsComplete() {
  local handler="$handler" && shift
  local docPath="$1" && shift
  local tempFunctions="$1" && shift

  local missing=() finished=false && while ! $finished; do
    local fun && read -r fun || finished=true
    [ -n "$fun" ] || continue
    if [ ! -f "$docPath/$fun.sh" ]; then
      missing+=("$fun")
    fi
  done <"$tempFunctions"
  finished=false && while ! $finished; do
    local file fun && read -r file || finished=true
    [ -n "$file" ] || continue
    fun="${file##*/}" && fun="${fun%.sh}"
    if ! isFunction "$fun" && ! muzzle buildEnvironmentGet "$fun" 2>/dev/null; then
      catchReturn "$handler" statusMessage --last decorate error "File $(decorate file "$file") has no matching function $(decorate code "$fun") anymore" || return $?
    fi
  done < <(find "$docPath" -type f -name '*.sh')
  local index=0 fun
  [ "${#missing[@]}" -eq 0 ] || for fun in "${missing[@]}"; do
    index=$((index + 1))
    catchReturn "$handler" statusMessage decorate warning "Loading missing: $fun" || return $?
    (
      __documentationFileCompileFunction "$handler" "$docPath" "$fun" "" "Missing #$index/${#missing[@]}" "$@" || return $?
    ) || return $?
  done
  catchReturn "$handler" statusMessage decorate info "No functions missing" || return $?
}
