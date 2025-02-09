#!/usr/bin/env bash
#
# list-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testListAppend() {
  local item testList="" s=":"

  for s in : \| ^ ! _; do
    testList=""
    reverseList=""
    for item in a b c dee eff gee H "\$ii" " good idea - mate " -- 49 "12,22"; do
      testList=$(listAppend "$testList" "$s" --last "$item")
      reverseList=$(listAppend "$reverseList" "$s" --first "$item")
    done
    assertEquals --line "$LINENO" "a${s}b${s}c${s}dee${s}eff${s}gee${s}H${s}\$ii${s} good idea - mate ${s}--${s}49${s}12,22" "$testList" || return $?
    assertEquals --line "$LINENO" "12,22${s}49${s}--${s} good idea - mate ${s}\$ii${s}H${s}gee${s}eff${s}dee${s}c${s}b${s}a" "$reverseList" || return $?

    testList="$(listRemove "$testList" " good idea - mate " "$s")"
    reverseList="$(listRemove "$reverseList" " good idea - mate " "$s")"

    assertEquals --line "$LINENO" "a${s}b${s}c${s}dee${s}eff${s}gee${s}H${s}\$ii${s}--${s}49${s}12,22" "$testList" || return $?
    assertEquals --line "$LINENO" "12,22${s}49${s}--${s}\$ii${s}H${s}gee${s}eff${s}dee${s}c${s}b${s}a" "$reverseList" || return $?

    testList="$(listRemove "$testList" "--" "$s")"
    reverseList="$(listRemove "$reverseList" "--" "$s")"

    assertEquals --line "$LINENO" "a${s}b${s}c${s}dee${s}eff${s}gee${s}H${s}\$ii${s}49${s}12,22" "$testList" || return $?
    assertEquals --line "$LINENO" "12,22${s}49${s}\$ii${s}H${s}gee${s}eff${s}dee${s}c${s}b${s}a" "$reverseList" || return $?
  done
}

testListJoin() {
  assertEquals --line "$LINENO" "a:b:c" "$(listJoin ":" a b c)" || return $?
  assertEquals --line "$LINENO" "a:b:c" "$(listJoin "::" a b c)" || return $?
}
