#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
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

  local classOuter=false

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

  if ! muzzle ulimit -n 10240 2>&1; then
    # Skip attempting to modify ulimit - no permission likely so just venture on
    savedLimit=""
  fi
  local indexList=() outerList=() innerList=() nouns=()

  # shellcheck disable=SC2207
  indexList=($(seq 0 127))

  if $classOuter; then
    outerList=("${classList[@]}")
    innerList=("${indexList[@]}")
    nouns=("character" "characters")
  else
    # shellcheck disable=SC2207
    outerList=("${indexList[@]}")
    innerList=("${classList[@]}")
    nouns=("class" "classes")
  fi
  local total=0 outer
  for outer in "${outerList[@]}"; do
    local matched=0 outerText class character
    if $classOuter; then
      class="$outer"
      outerText="$(decorate label "$(alignRight 10 "$outer")")"
    else
      character="$(characterFromInteger "$outer")" 2>/dev/null
      if ! isCharacterClass print "$character"; then
        outerText="$(printf "x%x " "$outer")"
        outerText="$(alignRight 5 "$outerText")"
        outerText="$(decorate subtle "$outerText")"
      else
        outerText="$(decorate blue "$(alignRight 5 "$character")")"
      fi
    fi
    printf "%s: " "$(alignLeft "$width" "$outerText")"
    local inner
    for inner in "${innerList[@]}"; do
      if $classOuter; then
        character="$(characterFromInteger "$inner")"
      else
        class="$inner"
      fi
      if isCharacterClass "$class" "$character"; then
        matched=$((matched + 1))
        if $classOuter; then
          if ! isCharacterClass print "$character"; then
            printf "%s " "$(decorate subtle "$(printf "x%x" "$inner")")"
          else
            printf "%s " "$(decorate blue "$(characterFromInteger "$inner")")"
          fi
        else
          printf "%s " "$(decorate blue "$class")"
        fi
      fi
    done
    printf "[%s %s]\n" "$(decorate bold-magenta "$matched")" "$(decorate subtle "$(plural "$matched" "${nouns[@]}")")"
    total=$((total + matched))
  done
  printf "%s total %s\n" "$(decorate bold-red "$total")" "$(decorate red "$(plural "$total" "${nouns[@]}")")"
  [ -z "$savedLimit" ] || muzzle ulimit -n "$savedLimit" 2>&1 || :
}
