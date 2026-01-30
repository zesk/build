#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#                                ▗▄▄▖
#   ▐▌             ▐▌            ▐▛▀▜▌                     ▐▌
#  ▐███  ▟█▙ ▝█ █▘▐███   ▄       ▐▌ ▐▌ ▟█▙ ▐▙█▙  ▟█▙  █▟█▌▐███
#   ▐▌  ▐▙▄▟▌ ▐█▌  ▐▌    █       ▐███ ▐▙▄▟▌▐▛ ▜▌▐▛ ▜▌ █▘   ▐▌
#   ▐▌  ▐▛▀▀▘ ▗█▖  ▐▌            ▐▌▝█▖▐▛▀▀▘▐▌ ▐▌▐▌ ▐▌ █    ▐▌
#   ▐▙▄ ▝█▄▄▌ ▟▀▙  ▐▙▄   █       ▐▌ ▐▌▝█▄▄▌▐█▄█▘▝█▄█▘ █    ▐▙▄
#    ▀▀  ▝▀▀ ▝▀ ▀▘  ▀▀   ▀       ▝▘ ▝▀ ▝▀▀ ▐▌▀▘  ▝▀▘  ▀     ▀▀
#                                          ▐▌

__characterClassReport() {
  local handler="$1" && shift

  local classOuter=true

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --class)
      classOuter=true
      ;;
    --char)
      classOuter=false
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  local classList=()
  IFS=$'\n' read -r -d '' -a classList < <(characterClasses)

  local width=5

  local savedLimit

  savedLimit="$(catchEnvironment "$handler" ulimit -n)" || return $?

  if ! ulimit -n 10240 2>/dev/null 1>/dev/null; then
    # Skip attempting to modify ulimit - no permission likely so just venture on
    savedLimit=""
  fi
  local indexList=() nouns=()

  # shellcheck disable=SC2207
  indexList=($(seq 0 127))

  if $classOuter; then
    nouns=("character" "characters")
  else
    # shellcheck disable=SC2207
    nouns=("class" "classes")
  fi
  local total=0

  local matched outerText
  if $classOuter; then
    local class && for class in "${classList[@]}"; do
      matched=0
      outerText="$(decorate label "$(textAlignRight 10 "$class")")"
      printf "%s: " "$(textAlignLeft "$width" "$outerText")"
      local index character && for index in "${indexList[@]}"; do
        character="$(catchEnvironment "$handler" characterFromInteger "$index")" || return $?
        if isCharacterClass "$class" "$character"; then
          matched=$((matched + 1))
          if $classOuter; then
            case "$character" in
            [[:print:]]) printf "%s " "$(decorate blue "$character")" ;;
            *) printf "%s " "$(decorate subtle "$(printf "x%x" "$index")")" ;;
            esac
          else
            printf "%s " "$(decorate blue "$class")"
          fi
        fi
      done
      printf "[%s %s]\n" "$(decorate BOLD magenta "$matched")" "$(plural "$matched" "${nouns[@]}")"
      total=$((total + matched))
    done
  else
    local index character && for index in "${indexList[@]}"; do
      character="$(catchEnvironment "$handler" characterFromInteger "$index")" || return $?
      case "$character" in
      [[:print:]])
        outerText="$(decorate blue "$(textAlignRight 5 "$character")")"
        ;;
      *)
        outerText="$(printf "x%x " "$index")"
        outerText="$(textAlignRight 5 "$outerText")"
        outerText="$(decorate subtle "$outerText")"
        ;;
      esac
      printf "%s: " "$(textAlignLeft "$width" "$outerText")"
      local matchedClasses=() && IFS=$'\n' read -r -d '' -a matchedClasses < <(characterClasses "$character")
      matched=${#matchedClasses[@]}
      local classText
      if [ "$matched" -eq 0 ]; then
        classText=$(decorate warning "none")
      else
        classText="$(decorate blue "${matchedClasses[*]}")"
      fi
      printf "%s [%s %s]\n" "$classText" "$(decorate BOLD magenta "$matched")" "$(plural "$matched" "${nouns[@]}")"
      total=$((total + matched))
    done
  fi

  printf "%s total %s\n" "$(decorate BOLD red "$total")" "$(decorate red "$(plural "$total" "${nouns[@]}")")"
  [ -z "$savedLimit" ] || ulimit -n "$savedLimit" 1>/dev/null 2>&1 || :
}
