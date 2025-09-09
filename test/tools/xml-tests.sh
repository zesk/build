#!/usr/bin/env bash
#
# Tests for jUnit
#
# Copyright &copy; 2025 Market Acumen, Inc.

test_XMLBasics() {
  local handler="_return"

  local rando

  rando=$(__catch "$handler" randomString) || return $?

  local matches=(
    --stdout-match "<?xml"
    --stdout-match "?>"
    --stdout-match "version=\"2.0\""
    --stdout-match "encoding=\"UTF-8\""
  )
  assertExitCode "${matches[@]}" 0 __xmlHeader "version=2.0" || return $?

  assertEquals "<html /> " __xmlTag "name=Test run" || return $?
  assertEquals "<html name=\"Test run\" /> " __xmlTag html "name=Test run" || return $?
  assertEquals "<html> " __xmlTagOpen html || return $?
  assertEquals "<html lang=\"fr\"> " __xmlTagOpen html lang=fr || return $?
  assertEquals "</html>" __xmlTagClose html || return $?
  assertEquals "</html>" __xmlTagClose html "name=$rando" || return $?
  local matches=(
    --stdout-match "<properties>"
    --stdout-match "<property name=\"name\" value=\"$rando\" />"
    --stdout-match "</properties>"
  )
  assertEquals " name=\"$rando\"" 0 __xmlAttributes "name=$rando" || return $?
  assertEquals "" 0 __xmlAttributes "" || return $?
  assertEquals " word" 0 __xmlAttributes "word" || return $?
  assertEquals " word" 0 __xmlAttributes "word tag thing" || return $?
  assertEquals " word tag thing" 0 __xmlAttributes "word tag thing" || return $?
  # Bash removes "what" quotes here
  assertEquals " word=\"what\" tag" 0 __xmlAttributes word="what" tag || return $?
  # Bash does not remove "what" quotes here
  assertEquals " word=\"&quot;what&quot;\" tag" 0 __xmlAttributes "word=\"what\"" tag || return $?
}
