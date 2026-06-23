#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# missing-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Tests which need to be written
#

#  No references found for processCountWatcher

# bin/documentation.sh runs these:
#
# No references found for bashDocumentationDefaults
# No references found for bashDocumentationMissing

# bashDocumentationDeriveFunction
# bashDocumentationDeriveSee
# bashFirstComment
# bashRemoveCommentCharacter
# documentationIndexGenerate
# documentationMake
# documentationMaker
# documentationFileCompile
# documentationFilesAdd

testEverythingElse() {
  # dockerComposeWrapper
  # plasterLines

  # documentationIndexUnlinkedFunctions
  # bashDocumentationMarkdown
  # documentationTemplateFileCompile
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
  #  documentationCache
  #  documentationEnvironmentMake
  #  documentationIndexDocumentation
  #  documentationIndexLookup
  #  documentationTemplate
  #  documentationTemplateCompile
  #  documentationTemplateDirectoryCompile
  #  documentationTemplateFunctionCompile
  #  documentationIdenticalRepair
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
  #  dockerComposeCommandIsValid
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
  #  logDirectoryRotate
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
