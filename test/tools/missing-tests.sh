#!/usr/bin/env bash
#
# missing-tests.sh
#
# Tests which need to be written
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testEverythingElse() {
  # SUGAR

  # approvedSources
  # dockerComposeWrapper
  # plasterLines

  #  catchEnvironmentQuiet
  #  executeInputSupport
  #  isBashBuiltin
  #  isType

  #  awsSecurityGroupIPModify

  # BASH Parsing

  #  bashFileComment
  #  bashFinalComment
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
  #  bigTextAt
  #  bitbucketContainer
  #  bitbucketGetVariable
  #  buildDevelopmentLink
  #  buildEnvironmentContext
  #  buildEnvironmentGetDirectory
  #  cachedShaPipe
  #  clampDigits

  ## COLORS
  #  colorMultiply
  #  colorNormalize
  #  colorParse
  #  confirmMenu
  #  consoleBrightness
  #  consoleColorMode
  #  consoleConfigureColorMode
  #  consoleDefaultTitle
  #  consoleGetColor
  #  consoleLinksSupported
  #  consoleSetTitle
  #  contextShow
  #  convertValue
  #  daemontoolsManager
  #  daemontoolsRestart
  #  daemontoolsTerminate
  #  debugOpenFiles
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
  #  lineFill
  #  linkRename
  #  loopExecute
  #  manPathCleanDuplicates
  #  mapValueTrim
  #  markdownIndentHeading
  #  nodePackageManagerValid
  #  phpTailLog
  #  phpTest
  #  pipeRunner
  #  rotateLogs
  #  sshSetup
  #  usageDocumentSimple
  #  usageRequireBinary
  #  validateFileContents

  # VALIDATE

  #  validate
  #  isValidateType

  # Likely do not need tests or are harder to test
  #  processOpenPipes
  #  veeGitTag
  #  websiteScrape
  #  backgroundProcess

  # MANPATH and PATH

  #  manPathConfigure
  #  manPathRemove
  #  pathConfigure
  #  pathRemove

  # INTERACTIVE

  #  approveBashSource
  #  urlOpener
  #  notify

  assertExitCode 0 printf "" || return $?
}
