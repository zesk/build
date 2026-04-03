#!/usr/bin/env bash
#
# list-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__dataListContains() {
  cat <<'EOF'
0|a:b:c:d|:|a:b:c
0|a,b,c,d|,|a,b,c
1|a,b,c,d|,|a,b,e
1|aa,bb,cc,dd|,|aa,bb,ee
0|aa,bb,cc,dd|,|aa
0|aa,bb,cc,dd|,|bb
0|aa,bb,cc,dd|,|cc
0|aa,bb,cc,dd|,|dd
1|aa,bb,cc,dd|,|ee
1|aa,bb,cc,dd|,|ee,aa
0|JohnQBarbieQKen|Q|KenQBarbie
0|JohnQBabyQHal|Q|Baby
0|JohnQBarbieQHal|Q|Barbie
EOF
}
testListContains() {
  local expectedExitCode listValues sep itemsText
  while IFS='|' read -r expectedExitCode listValues sep itemsText; do
    local items=() && IFS="$sep" read -r -a items <<<"$itemsText"
    local ee=()
    [ "$expectedExitCode" -ne 2 ] || ee=(--stderr-ok)
    assertExitCode "${ee[@]+"${ee[@]}"}" "$expectedExitCode" listContains "$listValues" "$sep" "${items[@]+"${items[@]}"}" || return $?
  done < <(__dataListContains)
}

testListAppend() {
  local item testList="" s=":" reverseList

  for s in : \| ^ ! _; do
    testList=""
    reverseList=""
    for item in a b c dee eff gee H "\$ii" " good idea - mate " -- 49 "12,22"; do
      testList=$(listAppend "$testList" "$s" --last "$item")
      reverseList=$(listAppend "$reverseList" "$s" --first "$item")
    done
    assertEquals "a${s}b${s}c${s}dee${s}eff${s}gee${s}H${s}\$ii${s} good idea - mate ${s}--${s}49${s}12,22" "$testList" || return $?
    assertEquals "12,22${s}49${s}--${s} good idea - mate ${s}\$ii${s}H${s}gee${s}eff${s}dee${s}c${s}b${s}a" "$reverseList" || return $?

    testList="$(listRemove "$testList" " good idea - mate " "$s")"
    reverseList="$(listRemove "$reverseList" " good idea - mate " "$s")"

    assertEquals "a${s}b${s}c${s}dee${s}eff${s}gee${s}H${s}\$ii${s}--${s}49${s}12,22" "$testList" || return $?
    assertEquals "12,22${s}49${s}--${s}\$ii${s}H${s}gee${s}eff${s}dee${s}c${s}b${s}a" "$reverseList" || return $?

    testList="$(listRemove "$testList" "--" "$s")"
    reverseList="$(listRemove "$reverseList" "--" "$s")"

    assertEquals "a${s}b${s}c${s}dee${s}eff${s}gee${s}H${s}\$ii${s}49${s}12,22" "$testList" || return $?
    assertEquals "12,22${s}49${s}\$ii${s}H${s}gee${s}eff${s}dee${s}c${s}b${s}a" "$reverseList" || return $?
  done
}
testListAppendSame() {
  assertEquals "$(listAppend "foo:does/not/match" ":" "not/match")" "foo:does/not/match:not/match" || return $?
}
testListJoin() {
  assertEquals "a:b:c" "$(listJoin ":" a b c)" || return $?
  assertEquals "a:b:c" "$(listJoin "::" a b c)" || return $?
}

__dataListCleanDuplicates() {
  cat <<EOF
a;b;c;d|;|a;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d
a;b;c;d;e|;|a;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d;a;e;c;d
a;f;b;c;d;e|;|a;f;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d;a;b;c;d;a;e;c;d
EOF
}

testListCleanDuplicates() {
  local testRow=()
  #  listCleanDuplicates
  while IFS="|" read -r -a testRow; do
    set -- "${testRow[@]}"
    local expected="$1" && shift
    assertEquals --display "listCleanDuplicates $*" "$expected" "$(listCleanDuplicates "$@")" || return $?
  done < <(__dataListCleanDuplicates)
}
