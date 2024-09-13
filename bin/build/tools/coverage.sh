#!/usr/bin/env bash
#
# coverage.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/coverage.md
# Test: o ./test/tools/coverage-tests.sh
#

# Usage: {fn} [ --target reportFile ] thingToRun
# Collect code coverage statistics for a code sample
# Covert resulting files using `bashCoverageReport`
# See: bashCoverageReport
bashCoverage() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local start home target="" verbose=false

  # local binPath actualBash

  home=$(__usageEnvironment "$usage" buildHome) || return $?
  # IDENTICAL startBeginTiming 1
  start=$(__usageEnvironment "$usage" beginTiming) || return $?

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  [ -n "$target" ] || target="$home/coverage.stats"
  ! $verbose || consoleInfo "Collecting coverage to $(consoleCode "${target#"$home"}")"
  __usageEnvironment "$usage" __bashCoverageWrapper "$target" "$@" || return $?
  ! $verbose || reportTiming "$start" "Coverage completed in"
}
_bashCoverage() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

bashCoverageReport() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved

  local reportCache target file line dataPath commandFile files=() home

  # IDENTICAL startBeginTiming 1
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  home=$(__usageEnvironment "$usage" buildHome) || return $?

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
        # IDENTICAL argumentUnknown 1
        files+=("$(usageArgumentFile "$usage" "$argument" "${1-}")") || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  [ -n "$target" ] || target="$home/test-coverage"
  if [ -z "$reportCache" ]; then
    reportCache=$(__usageEnvironment "$usage" buildCacheDirectory ".bashCoverageReport") || return $?
    reportCache=$(__usageEnvironment "$usage" requireDirectory "$reportCache") || return $?
  fi
  target=$(__usageEnvironment "$usage" requireDirectory "$target") || return $?

  consoleInfo "$reportCache"
  consoleInfo "Report: $target"

  if [ "${#files[@]}" -eq 0 ]; then
    __bashCoverageReportFile "$usage" "$reportCache" "$target"
  else
    for file in "${files[@]}"; do
      statusMessage consoleInfo "$(pwd) Loading $(consoleCode "$file")"
      __bashCoverageReportFile "$usage" "$reportCache" "$target" <"$file"
    done
  fi
  statusMessage consoleInfo "Reporting to $(consoleCode "$target")"
  for file in coverage.css coverage.js; do
    __usageEnvironment "$usage" cp "$(__bashCoverageReportTemplate "$file")" "$target/$file" || return $?
  done
  __bashCoverageReportConvertFiles "$usage" "$reportCache" "$target" || return $?
}
_bashCoverageReport() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Internal: true
# Debugger function tracks coverage calls and stores them in target file (1st argument)
# KISS as this needs to be AFAFP
__bashCoverageMarker() {
  export BUILD_HOME
  local source=${BASH_SOURCE[1]} home="${BUILD_HOME%/}/" command="${BASH_COMMAND//$'\n'/\n}"
  source="${source#"$home"}"
  printf "%s:%d %s\n" "$source" "${BASH_LINENO[0]}" "$command" >>"$1"
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

  tempFile=$(__usageEnvironment "$usage" mktemp) || return $?
  sort -u >"$tempFile"
  lineCount=$(($(wc -l <"$tempFile") + 0))
  __bashCoverageReportProcessStats "$usage" "$reportCache" "$target" "$lineCount" <"$tempFile" || _clean $? "$tempFile" || return $?
  __usageEnvironment "$usage" rm -rf "$tempFile" || return $?
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
    dataPath=$(__usageEnvironment "$usage" requireDirectory "$reportCache/$file/$line/") || return $?
    commandFile="$(printf "%s\n" "$command" | shaPipe)"
    printf "%s\n" "$command" >"$dataPath/$commandFile" || __failEnvironment "$usage" "Writing $commandFile" || return $?
    targetFile="$reportBase/$file.html"
    requireFileDirectory "$targetFile" || return $?
    [ -f "$targetFile" ] || __usageEnvironment "$usage" touch "$targetFile" || return $?
    __usageEnvironment "$usage" printf "%s\n" "$file" >>"$reportCache/all"
    index=$((index + 1))
    statusMessage consoleInfo "Line $index/$totalLines ..."
  done
  __usageEnvironment "$usage" sort -u <"$reportCache/all" >"$reportCache/files" || return $?
}

#
# Gets the path to a template file for the coverage report
#
__bashCoverageReportTemplate() {
  local home path

  home=$(__environment buildHome) || return $?
  path="$home/bin/build/tools/coverage/$1"
  [ -f "$path" ] || _environment "${FUNCNAME[0]} $path not found" || return $?
  printf "%s\n" "$path"
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

  home=$(__usageEnvironment "$usage" buildHome)
  coveredTemplate=$(__bashCoverageReportTemplate "covered.html") || return $?
  notCoveredTemplate=$(__bashCoverageReportTemplate "not-covered.html") || return $?
  pageTemplate=$(__bashCoverageReportTemplate "page.html") || return $?
  fileTemplate=$(__bashCoverageReportTemplate "file.html") || return $?
  lineTemplate=$(__bashCoverageReportTemplate "line.html") || return $?

  lineContentFile=$(__usageEnvironment "$usage" mktemp) || return $?
  while read -r file; do
    statusMessage consoleInfo "Generating $(consoleCode "$file")"
    if isAbsolutePath "$file"; then
      source="$file"
    else
      source="${home%/}/${file#/}"
    fi
    if [ ! -f "$file" ]; then
      consoleWarning "$file is no longer available"
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
      statusMessage consoleInfo "Processing $(consoleCode "$file"):$index"
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
        content=$(wrapLines "        " "" <<<"$content")
        printf "%s\n" "$content" | tee "$dataPath/$index.cached" >>"$lineContentFile"
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
    statusMessage consoleInfo "Final template $(consoleCode "$file") $coverage%"

    export "${fileTemplateVariables[@]}"
    fileContent="$(file_classes="${fileClasses[*]}" total="$index" name="$file" coverage=$coverage content=$'\n'"$magic"$'\n' mapEnvironment "${fileTemplateVariables[@]}" <"$fileTemplate")"

    pageClasses=("is-a-page")
    relativeTop="$dotDot" head="" foot="" page_classes="${pageClasses[*]}" content="$fileContent" title="$file" mapEnvironment "${pageTemplateVariables[@]}" <"$pageTemplate" >"$targetFile.$$"
    {
      grep -B 32767 -m 1 "$magic" <"$targetFile.$$" | grep -v "$magic"
      cat "$lineContentFile"
      grep -A 32767 -m 1 "$magic" <"$targetFile.$$" | grep -v "$magic"
    } >"$targetFile"
    __usageEnvironment "$usage" rm -rf "$targetFile.$$" || return $?
    clearLine
    printf "%s %s\n" "$(consoleInfo "Wrote")" "$(consoleCode "$targetFile")"
  done <"$reportCache/files"
}

# Usage: {fn} line uncoveredTexts template
__bashCoveragePartialLine() {
  local line="$1" template="$3" codes=() code index replace

  IFS=$'\n' read -d '' -r -a codes < <(printf "%s\n" "$2") || :
  if [ "${#codes[@]}" -eq 0 ]; then
    line="$(__htmlCode "$line")<em class=\"error\">NO CODES: \"$2\"<em>"
  else
    index=0
    for code in "${codes[@]}"; do
      code="$(quoteGrepPattern "$code")"
      replace="%%%%$index%%%%"
      line="${line//$code/$replace}"
      index=$((index + 1))
    done
    line=$(__htmlCode "$line")
    index=0
    for code in "${codes[@]}"; do
      replace="$(content="$(__htmlCode "$code")" mapEnvironment content <"$template")"
      line="${line//%%%%$index%%%%/$replace}"
      index=$((index + 1))
    done
  fi
  printf "%s\n" "$line"
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
  IFS=' ' read -r -a tokens <<<"$remain"
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
