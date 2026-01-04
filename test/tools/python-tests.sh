#!/usr/bin/env bash
#
# python-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Tag: package-install
testPythonInstallation() {
  if ! whichExists python; then
    __checkFunctionInstalls whichExists "Package" python pythonInstall || return $?
  fi
}

# Tag: package-install
testPythonStuff() {
  local handler="returnMessage"

  # uninstall if needed
  if pythonPackageInstalled mkdocs; then
    assertExitCode 0 pipUninstall mkdocs || return $?
  fi
  assertExitCode 1 pythonPackageInstalled mkdocs || return $?
  assertExitCode 0 pipInstall mkdocs || return $?
  assertExitCode 0 pipUpgrade || return $?
  assertExitCode 0 pythonPackageInstalled mkdocs || return $?
  assertExitCode --stdout-match "mkdocs" 0 pipWrapper list || return $?
  # TODO Fix later?
  #  assertExitCode 0 pipUninstall mkdocs || return $?
  #  assertExitCode 1 pythonPackageInstalled mkdocs || return $?
  #  # Test twice calls
  #  assertExitCode 0 pipUninstall mkdocs || return $?
}

# Tag: package-install
# Leaks PATH, __OLD_VIRTUAL_PATH PS1 VIRTUAL_ENV VIRTUAL_ENV_PROMPT
testPythonVirtual() {
  local handler="returnMessage"
  local temp

  mockEnvironmentStart PATH "${PATH-}"
  mockEnvironmentStart _OLD_VIRTUAL_PATH
  mockEnvironmentStart _OLD_VIRTUAL_PS1
  mockEnvironmentStart PS1
  mockEnvironmentStart VIRTUAL_ENV
  mockEnvironmentStart VIRTUAL_ENV_PROMPT

  temp=$(fileTemporaryName "$handler" -d) || return $?

  assertExitCode --skip-plumber 0 pythonVirtual --application "$temp" mkdocs || return $?

  catchReturn "$handler" rm -rf "$temp" || return $?

  mockEnvironmentStop PATH _OLD_VIRTUAL_PATH PS1 _OLD_VIRTUAL_PS1 VIRTUAL_ENV VIRTUAL_ENV_PROMPT
}

# Tag: package-install
testPythonUninstallation() {
  if whichExists python; then
    __checkFunctionUninstalls whichExists "already installed" python pythonUninstall || return $?
  fi
}
