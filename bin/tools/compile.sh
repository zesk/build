#!/usr/bin/env bash
#
# Build Build
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#

# Experimental - resulting file ends up being around 1MB
# Example:     timing runCount 100 source bin/build/tools.sh ; timing runCount 100 source bin/build/tools-compiled.sh
# Example:     runCount 100 source bin/build/tools.sh 8.628 seconds
# Example:     runCount 100 source bin/build/tools-compiled.sh 7.728 seconds
buildToolsCompile() {
  local handler="_${FUNCNAME[0]}"
  local destroyFlag=false

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
    --destroy) destroyFlag=true ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  home=$(catchReturn "$handler" buildHome) || return $?

  local tempDirectory
  tempDirectory=$(fileTemporaryName "$handler" -d) || return $?

  local clean=("$tempDirectory")
  local targetFile="$tempDirectory/source/tools.sh"
  local sourcePath="$home/bin/build"
  local sourceFile="$sourcePath/tools.sh" sourceFileLines

  sourceFileLines=$(fileLineCount "$sourceFile")
  catchEnvironment "$handler" muzzle directoryRequire "$tempDirectory/source" || return $?
  catchEnvironment "$handler" grep -B "$sourceFileLines" -e '^# LOAD' <"$sourceFile" | grep -v '# LOAD' >"$targetFile" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" cp -r "$sourcePath/identical" "$tempDirectory/identical" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" muzzle identicalCheck --repair "$tempDirectory/identical" --extension "sh" --prefix "# COMPILED" --cd "$tempDirectory" || returnClean $? "${clean[@]}" || return $?

  local toolsPath="$home/bin/build/tools"
  local toolsList="$toolsPath/tools.conf" toolFile
  [ -f "$toolsList" ] || throwEnvironment "$handler" "Missing $toolsList" 1>&2 || returnClean $? "${clean[@]}" || return $?
  while read -r toolFile; do
    [ "${toolFile#\#}" = "$toolFile" ] || continue
    {
      printf "%s\n" "" "# ${toolFile#"$home"}" "" || returnClean $? "${clean[@]}" || return $?
      catchEnvironment "$handler" cat "$toolsPath/$toolFile.sh" || returnClean $? "${clean[@]}" || return $?
    } >>"$targetFile" || returnClean $? "${clean[@]}" || return $?
  done <"$toolsList"
  catchEnvironment "$handler" sed -e "$(sedReplacePattern "../../.." "../..")" -e '/^#!/d' <"$toolsPath/../env/BUILD_HOME.sh" | printfOutputPrefix "\n" >>"$targetFile" || return $?
  catchEnvironment "$handler" grep -A "$sourceFileLines" -e '^# LOAD' <"$sourceFile" | grep -v '# LOAD' >>"$targetFile" || returnClean $? "${clean[@]}" || return $?
  local sourceTarget="$sourcePath/main.sh"
  catchEnvironment "$handler" cp "$targetFile" "$sourceTarget" || return $?
  export SHFMT_ARGUMENTS
  catchReturn "$handler" buildEnvironmentLoad SHFMT_ARGUMENTS || return $?
  isArray SHFMT_ARGUMENTS || SHFMT_ARGUMENTS=()
  local aa=("${SHFMT_ARGUMENTS[@]+"${SHFMT_ARGUMENTS[@]}"}")
  inArray "-s" "${aa[@]+"${aa[@]}"}" || aa+=("-s")
  inArray "--minify" "${aa[@]+"${aa[@]}"}" || aa+=("--minify")
  catchEnvironment "$handler" bashLint --verbose "$sourceTarget" || return $?
  # Removes all comments - therefore shellcheck chokes on this as all of our disabled flags do not work
  catchEnvironment "$handler" shfmt "${aa[@]+"${aa[@]}"}" -w "$sourceTarget" || return $?
  # So, ensure it's added to etc/bashSanitize.conf to be ignored
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?

  if $destroyFlag; then
    catchEnvironment "$handler" mv -f "$sourceTarget" "$toolsPath/bin/build/tools.sh" || return $?
    catchEnvironment "$handler" find "$toolsPath" -maxdepth 1 -mindepth 1 -type f -name '*.sh' ! -name '*-deprecated.sh' -delete || return $?
  fi
}
_buildToolsCompile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
