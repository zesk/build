# Current plans

- `usage.sh` and related `usageArgument` will be moved to a less verbose type-checking interface modeled after the
  `decorate` pattern which seemed to work well.
- Continue migration to local `local` usage instead of head of function (`example.sh` arguments handling)
- Move `docs` to something not Bash-based perhaps
- Start writing some tutorials on how to get it set up and working (video?)

## Done

- "Work on 30-minute build timing or make it faster somehow" - Added `--tag` to `testSuite` to skip slow tests each run
- "Move away from `.check-assertions`" - now just checks everything - may not be a good choice
- Move away from `.debugging` markers - now uses a hash of the file stored in the file itself. (Ignoring the hash line.)

## Slowest tests 2025

On a "2x" machine:

- 123.617 testBuildEnvironmentLoadAll
- 107.896 testDeployApplication
- 105.799 testDeployToRemote
- 80.488 testDumpEnvironmentUnsafe
- 78.615 testHookSystem
- 74.292 testDumpEnvironmentSafe
- 68.06 testDeployBuildEnvironment
- 67.409 testAWSIPAccess
- 66.525 testUsageArgumentFunctions
- 64.07 testPHPBuild
- 60.256 testIdenticalChecks
- 58.65 testWrapperShellScripts
- 57.774 testIdenticalCheckAndRepairMap
- 52.701 testAdditionalBins
- 49.8 testDocSections
- 49.398 testBadNumericSamples
- 47.985 testLogFileRotate1
- 44.375 testLogFileRotate
- 42.346 testPackageAPI
- 42.16 testDeployRemoteFinish
- 37.931 testFileMatches
- 33.45 testIsUpToDate
- 30.435 testDaemontools
- 29.172 testBashPrompt
- 26.732 testAwsEnvironmentFromCredentials
- 26.454 testVersionNext
- 25.426 testValidateCharacterClass
- 25.303 testUn_dataSignedIntegerSamples
- 25.214 testHooksWhichSeemBenign
- 23.901 testUn_dataSignedNumberSamples
- 22.142 testSignedNumberSamples
- 21.639 testRunCount
- 21.415 testServiceToPort
- 20.431 test__catchCode
- 20.05 testMapPrefixSuffix
- 19.738 testProcessWait
- 19.657 testLinkCreate
- 18.159 testSugar
- 17.498 testEnvironmentFileLoad
- 16.931 testIdenticalCheckSingles
- 16.827 testExecutableCallable
- 16.656 testServiceToPortStandard
- 16.508 testListAppend
- 16.268 testIsMappable
- 15.136 testRepeat2
- 14.934 testNotExecutable
- 14.927 testTestSuite
- 14.847 testInstallBinBuild
- 14.688 testAWSProfiles
- 14.048 testHousekeeper
