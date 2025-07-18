#!/usr/bin/env bash
#
# coverage.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/coverage.md
# Test: o ./test/tools/coverage-tests.sh
#

# Usage: {fn} [ --target reportFile ] thingToRun
# Collect code coverage statistics for a code sample
# Covert resulting files using `bashCoverageReport`
# See: bashCoverageReport
bashCoverage() {
  local usage="_${FUNCNAME[0]}"

  local start home target="" verbose=false

  # local binPath actualBash

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?

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
    --verbose)
      verbose=true
      ;;
    --target)
      shift
      target="$(usageArgumentFileDirectory "$usage" "$argument" "${1-}")" || return $?
      ;;
    *)
      break
      ;;
    esac
    shift
  done
  [ -n "$target" ] || target="$home/coverage.stats"
  ! $verbose || decorate info "Collecting coverage to $(decorate code "${target#"$home"}")"
  __catchEnvironment "$usage" __bashCoverageWrapper "$target" "$@" || return $?
  ! $verbose || timingReport "$start" "Coverage completed in"
}
_bashCoverage() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Generate a coverage report using the coverage statistics file
# Usage: {fn} [ --help ] [ --cache cacheDirectory ] [ --target targetDirectory ] [ statsFile ]
# stdin: Accepts a stats file
bashCoverageReport() {
  local usage="_${FUNCNAME[0]}"

  local reportCache target file line dataPath commandFile files=() home

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?
  home=$(__catchEnvironment "$usage" buildHome) || return $?

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
    --cache)
      shift
      reportCache="$(usageArgumentDirectory "$usage" "$argument" "${1-}")" || return $?
      ;;
    --target)
      shift
      target="$(usageArgumentFileDirectory "$usage" "$argument" "${1-}")" || return $?
      ;;
    *)
      files+=("$(usageArgumentFile "$usage" "coverageFile" "$1")") || return $?
      ;;
    esac
    shift
  done

  [ -n "$target" ] || target="$home/test-coverage"
  if [ -z "$reportCache" ]; then
    reportCache=$(__catchEnvironment "$usage" buildCacheDirectory ".bashCoverageReport") || return $?
  fi
  target=$(__catchEnvironment "$usage" directoryRequire "$target") || return $?

  decorate info "$reportCache"
  decorate info "Report: $target"

  if [ "${#files[@]}" -eq 0 ]; then
    __bashCoverageReportFile "$usage" "$reportCache" "$target"
  else
    for file in "${files[@]}"; do
      statusMessage decorate info "$(pwd) Loading $(decorate code "$file")"
      __bashCoverageReportFile "$usage" "$reportCache" "$target" <"$file"
    done
  fi
  statusMessage decorate info "Reporting to $(decorate code "$target")"
  for file in coverage.css coverage.js; do
    __catchEnvironment "$usage" cp "$(__bashCoverageReportTemplate "$file")" "$target/$file" || return $?
  done
  __bashCoverageReportConvertFiles "$usage" "$reportCache" "$target" || return $?
}
_bashCoverageReport() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Internal: true
# Debugger function tracks coverage calls and stores them in target file (1st argument)
# KISS as this needs to be AFAFP
__bashCoverageMarker() {
  export BUILD_HOME
  local source=${BASH_SOURCE[1]} home="${BUILD_HOME%/}/" command="${BASH_COMMAND//$'\n'/\n}"
  source="${source#"$home"}"
  printf -- "%s:%s %s %s\n" "$source" "${BASH_LINENO[1]}" "${FUNCNAME[1]}" "$command" >>"$1"
  # debuggingStack >>"$1.stack" || return $?
}
___bashCoverageMarker() {
  __bashCoverageEnd
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Utility - cover passed command
#
__bashCoverageWrapper() {
  local e=0 target="$1" && shift
  __bashCoverageStart "$target"
  "$@" || e=$?
  __bashCoverageEnd
  return $e
}

#
# Utility - start coverage recording
#
__bashCoverageStart() {
  shopt -s extdebug
  set -o functrace
  # shellcheck disable=SC2064
  trap "__bashCoverageMarker \"$1\"" DEBUG
}

#
# Utility - stop coverage recording
#
__bashCoverageEnd() {
  trap - DEBUG
  set +o functrace
  shopt -u extdebug
}

# Sort unique and then import
__bashCoverageReportFile() {
  local usage="$1" reportCache="$2" target="$3" tempFile lineCount

  tempFile=$(fileTemporaryName "$usage") || return $?
  sort -u >"$tempFile"
  lineCount=$(__catchEnvironment "$usage" fileLineCount "$tempFile") || return $?
  __bashCoverageReportProcessStats "$usage" "$reportCache" "$target" "$lineCount" <"$tempFile" || returnClean $? "$tempFile" || return $?
  __catchEnvironment "$usage" rm -rf "$tempFile" || return $?
}

#
# Takes a coverage statistics file and generates data directory structure and report structure
# After: reportBase/all and reportBase/files are lists of sorted files tracked
#
__bashCoverageReportProcessStats() {
  local usage="$1" reportCache="$2" reportBase="$3" totalLines="${4-Unknown}" index=0
  local fileLine file line dataPath commandFile

  while read -r fileLine command; do
    file="${fileLine%:*}"
    line="${fileLine##*:}"
    dataPath=$(__catchEnvironment "$usage" directoryRequire "$reportCache/$file/$line/") || return $?
    commandFile="$(printf -- "%s\n" "$command" | shaPipe)"
    printf -- "%s\n" "$command" >"$dataPath/$commandFile" || __throwEnvironment "$usage" "Writing $commandFile" || return $?
    targetFile="$reportBase/$file.html"
    targetFile=$(__catchEnvironment "$usage" fileDirectoryRequire "$targetFile") || return $?
    [ -f "$targetFile" ] || __catchEnvironment "$usage" touch "$targetFile" || return $?
    __catchEnvironment "$usage" printf -- "%s\n" "$file" >>"$reportCache/all" || return $?
    index=$((index + 1))
    statusMessage decorate info "Line $index/$totalLines ..."
  done
  __catchEnvironment "$usage" sort -u <"$reportCache/all" >"$reportCache/files" || return $?
}

#
# Gets the path to a template file for the coverage report
#
__bashCoverageReportTemplate() {
  local home path

  home=$(__environment buildHome) || return $?
  path="$home/bin/build/tools/coverage/$1"
  [ -f "$path" ] || _environment "${FUNCNAME[0]} $path not found" || return $?
  printf -- "%s\n" "$path"
}

#
# Takes a .stats file and generates data directory structure and report structure
# After: reportBase/all and reportBase/files are lists of sorted files tracked
#
__bashCoverageReportConvertFiles() {
  local usage="$1" reportCache="$2" reportBase="$3" file dataPath
  local home content
  local source index line trimmedLine coverableLines notCoverableLines coveredLines notCoveredLines coverable
  local coveredTemplate notCoveredTemplate pageTemplate fileTemplate lineTemplate lineContentFile extra
  local uncoveredCodes magic="@COVERAGE@"
  local pageClasses lineClasses fileClasses dotDot
  local lineTemplateVariables=(line_classes index content extra)
  local fileTemplateVariables=(content file_classes total name coverage coveredLines notCoveredLines coverableLines notCoverableLines)
  local pageTemplateVariables=(title content head foot body_classes relativeTop)

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  coveredTemplate=$(__bashCoverageReportTemplate "covered.html") || return $?
  notCoveredTemplate=$(__bashCoverageReportTemplate "not-covered.html") || return $?
  pageTemplate=$(__bashCoverageReportTemplate "page.html") || return $?
  fileTemplate=$(__bashCoverageReportTemplate "file.html") || return $?
  lineTemplate=$(__bashCoverageReportTemplate "line.html") || return $?

  lineContentFile=$(fileTemporaryName "$usage") || return $?
  while read -r file; do
    statusMessage decorate info "Generating $(decorate code "$file")"
    if isAbsolutePath "$file"; then
      source="$file"
    else
      source="${home%/}/${file#/}"
    fi
    if [ ! -f "$file" ]; then
      decorate warning "$file is no longer available"
      continue
    fi
    file="${file#/}" # Trim leading slash
    dotDot=$(directoryRelativePath "$file")
    dataPath="$reportCache/$file"
    targetFile="$reportBase/$file.html"
    index=0
    coverableLines=0
    notCoverableLines=0
    coveredLines=0
    notCoveredLines=0
    while IFS='' read -r line; do
      lineClasses=()
      extra=""
      if __bashCoverageLineIsCoverable "$line"; then
        coverable=true
        lineClasses+=("coverable")
        coverableLines=$((coverableLines + 1))
      else
        coverable=false
        lineClasses+=("not-coverable")
        notCoverableLines=$((notCoverableLines + 1))
      fi
      index=$((index + 1))
      statusMessage decorate info "Processing $(decorate code "$(decorate file "$file")"):$index"
      if [ $((index & 1)) ]; then
        lineClasses+=(odd "row-1")
      else
        lineClasses+=(even "row-0")
      fi
      if [ ! -f "$dataPath/$index.cached" ]; then
        if [ -d "$dataPath/$index" ]; then
          uncoveredCodes=$(__bashCoverageMatch "$line" "$dataPath/$index")
          if [ -z "$uncoveredCodes" ]; then
            # We are covered
            if ! $coverable; then
              extra="(NOT COVERABLE)"
              lineClasses+=("has-extra")
            fi
            coveredLines=$((coveredLines + 1))
            content="$(__htmlCode "$line")"
            content="$(content="$content" mapEnvironment content <"$coveredTemplate")"
            lineClasses+=(covered)
          else
            content="$(__bashCoveragePartialLine "$line" "$uncoveredCodes" "$notCoveredTemplate")"
            notCoveredLines=$((notCoveredLines + 1))
            lineClasses+=(covered-partially)
          fi
        else
          content="$(content="$(__htmlCode "$line")" mapEnvironment content <"$notCoveredTemplate")"
          notCoveredLines=$((notCoveredLines + 1))
          lineClasses+=(uncovered)
        fi
        content=$(line_classes="${lineClasses[*]}" content="$content" index="$index" extra="$extra" mapEnvironment "${lineTemplateVariables[@]}" <"$lineTemplate")
        content=$(decorate wrap "        " "" <<<"$content")
        printf -- "%s\n" "$content" | tee "$dataPath/$index.cached" >>"$lineContentFile"
      else
        cat "$dataPath/$index.cached" >>"$lineContentFile"
      fi
    done <"$source"
    if [ $coverableLines -eq 0 ]; then
      coverage=100
    else
      coverage=$((coveredLines * 100 / coverableLines))
    fi
    # lineContent is too big for mapEnvironment
    statusMessage decorate info "Final template $(decorate code "$file") $coverage%"

    export "${fileTemplateVariables[@]}"
    fileContent="$(file_classes="${fileClasses[*]}" total="$index" name="$file" coverage=$coverage content=$'\n'"$magic"$'\n' mapEnvironment "${fileTemplateVariables[@]}" <"$fileTemplate")"

    pageClasses=("is-a-page")
    relativeTop="$dotDot" head="" foot="" page_classes="${pageClasses[*]}" content="$fileContent" title="$file" mapEnvironment "${pageTemplateVariables[@]}" <"$pageTemplate" >"$targetFile.$$"
    {
      grep -B 32767 -m 1 "$magic" <"$targetFile.$$" | grep -v "$magic"
      cat "$lineContentFile"
      grep -A 32767 -m 1 "$magic" <"$targetFile.$$" | grep -v "$magic"
    } >"$targetFile"
    __catchEnvironment "$usage" rm -rf "$targetFile.$$" || return $?
    statusMessage --last printf -- "%s %s\n" "$(decorate info "Wrote")" "$(decorate code "$targetFile")"
  done <"$reportCache/files"
}

# Usage: {fn} line uncoveredTexts template
__bashCoveragePartialLine() {
  local line="$1" template="$3" codes=() code index search replace

  IFS=$'\n' read -d '' -r -a codes < <(printf -- "%s\n" "$2") || :
  if [ "${#codes[@]}" -eq 0 ]; then
    line="$(__htmlCode "$line")<em class=\"error\">NO CODES: \"$2\"<em>"
  else
    index=0
    for code in "${codes[@]}"; do
      replace="%%%%$index%%%%"
      line="${line//"$code"/"$replace"}"
      index=$((index + 1))
    done
    line=$(__htmlCode "$line")
    index=0
    for code in "${codes[@]}"; do
      replace="$(content="$(__htmlCode "$code")" mapEnvironment content <"$template")"
      search="%%%%$index%%%%"
      line="${line//"$search"/"$replace"}"
      index=$((index + 1))
    done
  fi
  printf -- "%s\n" "$line"
}
__htmlCode() {
  printf "%s\n" "$@" | sed -e 's/&/'$'\2''/g' -e 's/"/\&quot;/g' -e 's/ /\&nbsp;/g' -e 's/'$'\2''/\&amp;/g'
}

__bashCoverageMatch() {
  local line="$1" directory="$2" remain="$1" file code tokens

  while read -r file; do
    code=$(cat "$file")
    remain="${remain//"$code"/}"
  done < <(find "$directory" -type f)
  IFS=' ' read -r -a tokens <<<"$remain" || :
  [ "${#tokens[@]}" -gt 0 ] || return 0
  __bashCoverageCanIgnore "${tokens[@]}"
}

__bashCoverageCanIgnore() {
  while [ $# -gt 0 ]; do
    case "$1" in
    "&&" | "!" | "!!" | ";" | ":" | "()" | "{" | "}") ;;
    "|" | "||" | ";;") ;;
    "if" | "fi" | "case" | "esac") ;;
    *)
      case "$(unquote "\"" "$1")" in
      "\$()") ;;
      *) printf "%s\n" "$1" ;;
      esac
      ;;
    esac
    shift
  done
}

#
# Given a line of BASH code, should it be covered?
#
__bashCoverageLineIsCoverable() {
  local trimmedLine

  while [ $# -gt 0 ]; do
    trimmedLine=$(trimSpace "$1")
    case "$trimmedLine" in
    "" | "}" | "{" | "done" | "fi" | "else" | "then")
      return 1
      ;;
    *)
      if [ "${trimmedLine:0:1}" = "#" ]; then
        return 1
      fi
      ;;
    esac
    shift
  done
}
