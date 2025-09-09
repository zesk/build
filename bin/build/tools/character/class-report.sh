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

  local arg character classList indexList outer matched total classOuter=false outerList innerList nouns outerText width=5
  local savedLimit

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
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
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  classList=()
  for arg in $(characterClasses); do
    classList+=("$arg")
  done

  savedLimit="$(__catchEnvironment "$handler" ulimit -n)" || return $?
  __catchEnvironment "$handler" ulimit -n 10240 || return $?
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
  total=0
  for outer in "${outerList[@]}"; do
    matched=0
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
  __catchEnvironment "$handler" ulimit -n "$savedLimit" || return $?
}
