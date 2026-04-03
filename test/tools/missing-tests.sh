#!/usr/bin/env bash
#
# missing-tests.sh
#
# Tests which need to be written
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testEverythingElse() {
  # dockerComposeWrapper
  # plasterLines

  #  catchEnvironmentQuiet
  #  executeInputSupport

  # awsSecurityGroupIPModify

  # BASH Parsing

  #  bashFileComment
  #  bashFinalComment
  #  bashCommentVariable
  #  bashFunctionCommentVariable
  #  bashFunctionDefined

  #  bashLibrary
  #  bashLibraryHome
  #  bashLint
  #  bashLintFiles
  #  bashLintFilesInteractive
  #  bashSanitize
  #  bashListFunctions
  #  bashPromptColorScheme
  #  bashPromptColorsFormat
  #  bashPromptMarkers
  #  bashPromptModule_dotFilesWatcher
  #  bashRecursionDebug
  #  bashShowUsage
  #  bashUserInput
  #  decorate at
  #  bitbucketContainer
  #  bitbucketGetVariable
  #  buildDevelopmentLink
  #  buildEnvironmentContext
  #  buildEnvironmentGetDirectory
  #  cachedShaPipe
  #  integerClamp

  ## COLORS
  #  colorMultiply
  #  colorNormalize
  #  colorParse
  #  confirmMenu
  #  consoleBrightness
  #  consoleConfigureDecorate
  #  consoleConfigureColorMode
  #  consoleConfigureDecorate
  #  consoleDefaultTitle
  #  consoleGetColor
  #  consoleLinksSupported
  #  consoleSetTitle
  #  contextShow

  #  filesOpenStatus
  #  debuggingStack

  #  deployLink
  #  deployMove
  #  deprecatedCannonFile
  #  deprecatedFilePrependVersion
  #  deprecatedTokensFile

  ## DEVELOPER

  #  developerAnnounce
  #  developerDevelopmentLink
  #  developerTrack

  ## DOCKER

  #  dockerComposeUninstall
  #  dockerImages
  #  dockerLocalContainer
  #  dockerVolumeDelete
  #  dockerVolumeExists

  ## DOCUMENTATION

  #  documentationBuild
  #  documentationBuildCache
  #  documentationBuildEnvironment
  #  documentationIndexDocumentation
  #  documentationIndexLookup
  #  documentationTemplate
  #  documentationTemplateCompile
  #  documentationTemplateDirectoryCompile
  #  documentationTemplateFunctionCompile
  #  documentationTemplateUpdate
  #  documentationUnlinked
  #  dotEnvConfigure
  #  dotFilesApproved
  #  dotFilesApprovedFile
  #  dumpFile
  #  dumpHex
  #  dumpLoadAverages
  #  environmentApplicationLoad
  #  environmentFileApplicationVerify
  #  environmentFileShow
  #  environmentLoad
  #  environmentValueConvertArray
  #  evalCheck

  #  hookRunOptional
  #  hookSource
  #  hookSourceOptional
  #  hostTTFB
  #  identicalCheckShell
  #  identicalFindTokens
  #  identicalWatch
  #  installInstallBinary
  #  interactiveCountdown
  #  interactiveManager
  #  isDockerComposeCommand
  #  isPHPStorm
  #  isPyCharm
  #  isVisualStudioCode
  #  consoleHeadingLine
  #  linkRename
  #  executeLoop
  #  manPathCleanDuplicates
  #  mapValueTrim
  #  markdownIndentHeading
  #  nodePackageManagerValid
  #  phpTailLog
  #  phpTest
  #  pipeRunner
  #  logRotates
  #  sshSetup
  #  bashSimpleDocumentation
  #  executableRequire
  #  validateFileContents

  # VALIDATE

  #  validate
  #  isValidateType

  # Likely do not need tests or are harder to test
  #  processOpenPipes
  #  gitTagVee
  #  websiteScrape
  #  backgroundProcess

  # MANPATH and PATH

  #  manPathConfigure
  #  manPathRemove
  #  pathConfigure
  #  pathRemove

  # INTERACTIVE

  #  urlOpener
  #  notify
  # approveBashSource
  # approvedSources

  # Daemontools
  #
  #  daemontoolsManager
  #  daemontoolsRestart
  #  daemontoolsTerminate

  assertExitCode 0 printf "" || return $?
}
