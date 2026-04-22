#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Shell Dependencies: awk sed date echo sort printf
#
# Docs: o ./documentation/source/tools/decoration.md
# Test: o ./test/tools/decoration-tests.sh

# Display large text in the console for banners and important messages
# fn: decorate big
# `BUILD_TEXT_BINARY` can be `figlet` or `toilet`
#
# Argument: text - String. Required. Text to output
# Argument: --bigger - Flag. Optional. Text font size is bigger.
#
# standard (figlet)
#
#      _     _      _____         _
#     | |__ (_) __ |_   _|____  _| |_
#     | '_ \| |/ _` || |/ _ \ \/ / __|
#     | |_) | | (_| || |  __/>  <| |_
#     |_.__/|_|\__, ||_|\___/_/\_\\__|
#              |___/
#
# --bigger (figlet)
#
#      _     _    _______        _
#     | |   (_)  |__   __|      | |
#     | |__  _  __ _| | _____  _| |_
#     | '_ \| |/ _` | |/ _ \ \/ / __|
#     | |_) | | (_| | |  __/>  <| |_
#     |_.__/|_|\__, |_|\___/_/\_\\__|
#               __/ |
#              |___/
#
# smblock (regular) toilet
#
#     ▌  ▗   ▀▛▘     ▐
#     ▛▀▖▄ ▞▀▌▌▞▀▖▚▗▘▜▀
#     ▌ ▌▐ ▚▄▌▌▛▀ ▗▚ ▐ ▖
#     ▀▀ ▀▘▗▄▘▘▝▀▘▘ ▘ ▀
#
# smmono12 (--bigger) toilet
#
#     ▗▖     █       ▗▄▄▄▖
#     ▐▌     ▀       ▝▀█▀▘           ▐▌
#     ▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███
#     ▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌
#     ▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌
#     ▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄
#     ▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀
#                ▜█▛▘
# Environment: BUILD_TEXT_BINARY
__decorateExtensionBig() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0

  local fonts binary index=0

  binary=$(catchReturn "$handler" buildEnvironmentGet BUILD_TEXT_BINARY) || return $?
  [ -n "$binary" ] || binary="$(catchReturn "$handler" __decorateBigBinary)" || return $?
  [ -n "$binary" ] || throwEnvironment "$handler" "Need BUILD_TEXT_BINARY" || return $?
  case "$binary" in
  figlet) fonts=("standard" "big") ;;
  toilet) fonts=("smblock" "smmono12") ;;
  *)
    throwEnvironment "$handler" "Unknown BUILD_TEXT_BINARY $(decorate code "$binary")" || return $?
    ;;
  esac
  if ! executableExists "$binary"; then
    decorate green "BIG TEXT: $*"
    return 0
  fi
  if [ "${1-}" = "--bigger" ]; then
    index=1
    shift
  fi
  "$binary" -w "$(consoleColumns)" -f "${fonts[index]}" "$@"
}
___decorateExtensionBig() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Makes this a pure function - handles `stdin`
__decorateExtensionAt.Pure() {
  __decorateExtensionAt "$@"
}

# Experimental
# fn: decorate at
# Place text at a position on the console.
# Argument: x - Integer. Console X offset
# Argument: y - Integer. Console Y offset
# Argument: text ... - EmptyString. Text line to output at the x,y console location. Additional lines are placed below the previous line.
__decorateExtensionAt() {
  local handler="_${FUNCNAME[0]}"
  local x="" y=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$x" ]; then
        x=$(validate "$handler" Integer "xOffset" "$argument") || return $?
      elif [ -z "$y" ]; then
        y=$(validate "$handler" Integer "yOffset" "$argument") || return $?
        break
      fi
      ;;
    esac
    shift
  done

  if [ $# -eq 1 ] && [ "$1" = "--" ]; then
    shift
  fi
  [ -n "$x" ] || throwArgument "$handler" "Missing x" || return $?
  [ -n "$y" ] || throwArgument "$handler" "Missing y" || return $?
  local maxX maxY theX="$x" theY="$y" saveX saveY
  maxX=$(catchReturn "$handler" consoleColumns) || return $?
  maxY=$(catchReturn "$handler" consoleRows) || return $?
  [ "$x" -lt "$maxX" ] || throwArgument "$handler" "$x -gt $maxX exceeds column width" || return $?
  [ "$y" -lt "$maxY" ] || throwArgument "$handler" "$y -gt $maxY exceeds row height" || return $?
  [ "$x" -gt "-$maxX" ] || throwArgument "$handler" "$x -lt -$maxX exceeds negative column width" || return $?
  [ "$y" -gt "-$maxY" ] || throwArgument "$handler" "$y -lt -$maxY exceeds negative row height" || return $?
  IFS=$'\n' read -r -d '' saveX saveY < <(cursorGet)
  [ "$theX" -ge 0 ] || theX=$((maxX + theX))
  [ "$theY" -ge 0 ] || theY=$((maxY + theY))
  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      catchEnvironment "$handler" cursorSet "$theX" "$theY" || return $?
      printf -- "%s" "$1"
      theY=$((theY + 1))
      [ "$theY" -le "$maxY" ] || break
      shift
    done
  fi
  local outputLine && while read -r outputLine; do
    catchEnvironment "$handler" cursorSet "$theX" "$theY" || return $?
    printf -- "%s" "$outputLine"
    theY=$((theY + 1))
    [ "$theY" -le "$maxY" ] || break
  done
  catchEnvironment "$handler" cursorSet "$saveX" "$saveY" || return $?
}
___decorateExtensionAt() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: --top - Flag. Optional. Place label at the top.
# Argument: --bottom - Flag. Optional. Place label at the bottom.
# Argument: --prefix prefixText - String. Optional. Optional prefix on each line.
# Argument: --tween tweenText - String. Optional. Optional between text after label and before `decorate big` on each line (allows coloring or other decorations).
# Argument: --suffix suffixText - String. Optional. Optional suffix on each line.
# Argument: label - String. Required. Label to place on the left of big text.
# Argument: text - String. Required. Text for `decorate big`.
#
# Outputs a label before a decorate big for output.
#
# This function will strip any ANSI from the label to calculate correct string sizes.
#
# Example:     > bin/build/tools.sh labeledBigText --top "Neat: " Done
# Example:     Neat: ▛▀▖
# Example:           ▌ ▌▞▀▖▛▀▖▞▀▖
# Example:           ▌ ▌▌ ▌▌ ▌▛▀
# Example:           ▀▀ ▝▀ ▘ ▘▝▀▘
# Example:     > bin/build/tools.sh labeledBigText --bottom "Neat: " Done
# Example:           ▛▀▖
# Example:           ▌ ▌▞▀▖▛▀▖▞▀▖
# Example:           ▌ ▌▌ ▌▌ ▌▛▀
# Example:     Neat: ▀▀ ▝▀ ▘ ▘▝▀▘
labeledBigText() {
  local handler="_${FUNCNAME[0]}"

  local plainLabel="" label="" isBottom=true linePrefix="" lineSuffix="" tweenLabel="" tweenNonLabel=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --top)
      isBottom=false
      ;;
    --bottom)
      isBottom=true
      ;;
    --prefix)
      shift || :
      linePrefix="${1-}"
      ;;
    --suffix)
      shift || :
      lineSuffix="${1-}"
      ;;
    --tween)
      shift || :
      tweenLabel="${1-}"
      tweenNonLabel="${1-}"
      ;;
    *)
      if [ "$argument" != "${argument#-}" ]; then
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      label="$argument"
      plainLabel="$(printf -- "%s\n" "$label" | consoleToPlain)" || throwArgument "$handler" "Unable to clean label" || return $?
      shift
      break
      ;;
    esac
    shift
  done

  local banner nLines
  banner="$(decorate big "$@")"
  nLines=$(printf -- "%s\n" "$banner" | fileLineCount)
  plainLabel="$(printf -- "%s\n" "$label" | consoleToPlain)"
  tweenNonLabel="$(textRepeat "$((${#plainLabel}))" " ")$tweenNonLabel"
  if $isBottom; then
    printf -- "%s%s\n""%s%s%s\n" \
      "$(printf -- "%s\n" "$banner" | decorate wrap "$linePrefix$tweenNonLabel" "$lineSuffix" | head -n "$((nLines - 1))")" "$lineSuffix" \
      "$linePrefix$label$tweenLabel" "$(printf -- "%s\n" "$banner" | tail -n 1)" "$lineSuffix"
  else
    printf -- "%s%s%s\n""%s%s\n" \
      "$linePrefix$label$tweenLabel" "$(printf -- "%s\n" "$banner" | head -n 1)" "$lineSuffix" \
      "$(printf -- "%s\n" "$banner" | decorate wrap "$linePrefix$tweenNonLabel" "$lineSuffix" | tail -n "$((nLines - 1))")" "$lineSuffix"
  fi
}
_labeledBigText() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
