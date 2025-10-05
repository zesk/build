#!/usr/bin/env bash
#
# missing-tests.sh
#
# Tests which need to be written
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testEverythingElse() {
  #  catchEnvironmentQuiet
  #  executeInputSupport
  #  isType
  #  approveBashSource
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
  #  fileExtractLines
  #  fileGroup
  #  fileIsOldest
  #  fileModificationTimes
  #  fileModifiedDays
  #  fileModifiedRecentlyName
  #  fileModifiedRecentlyTimestamp
  #  fileModifiedSeconds
  #  fileOwner
  #  fileReverseLines
  #  filesRename
  #  gitBranchExists
  #  gitBranchExistsLocal
  #  gitBranchExistsRemote
  #  gitBranchMergeCurrent
  #  gitBranchify
  #  gitEnsureSafeDirectory
  #  gitFindHome
  #  gitInstallHook
  #  gitInstallHooks
  #  gitMainly
  #  gitPreCommitHasExtension
  #  gitPreCommitListExtension
  #  gitPreCommitSetup
  #  gitRemoveFileFromHistory
  #  gitRepositoryChanged
  #  gitShowChanges
  #  gitShowStatus
  #  gitTagAgain
  #  gitTagDelete
  #  gitTagVersion
  #  gitVersionLast
  #  githubLatest
  #  githubLatestRelease
  #  githubProjectJSON
  #  githubPublishDate
  #  githubRelease
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
  #  isBashBuiltin
  #  isCharacterClasses
  #  isDockerComposeCommand
  #  isPHPStorm
  #  isPyCharm
  #  isVisualStudioCode
  #  lineFill
  #  linkRename
  #  listCleanDuplicates
  #  loopExecute
  #  manPathCleanDuplicates
  #  mapValueTrim
  #  markdownIndentHeading
  #  nodePackageManagerValid
  #  notify
  #  phpTailLog
  #  phpTest
  #  pipeRunner
  #  rotateLogs
  #  sshSetup
  #  urlOpener
  #  usageDocumentSimple
  #  usageRequireBinary
  #  validateFileContents

  # VALIDATE

  #  validate
  #  isValidateType

  ## Python

  #  pipInstall
  #  pipUninstall
  #  pipUpgrade
  #  pipWrapper
  #  pythonPackageInstalled
  #  pythonVirtual

  ## Package

  #  packageDefault
  #  packageGroupInstall
  #  packageGroupUninstall
  #  packageIsInstalled
  #  packageMapping
  #  packageUninstall
  #  packageUpgrade

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

  assertExitCode 0 printf "" || return $?
}
